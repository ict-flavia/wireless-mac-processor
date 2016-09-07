#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include "vars.h"
#include "libb43.h"
#include "bytecode-work.h"
#include "bytecode-manager.h"
#include "dataParser.h"


void activeBytecode(struct debugfs_file * df, struct options * opt){
  
  //if(strcmp(opt->do_up,"1"))
  //	 putInWaitMode(df);
  
	writeAddressBytecode(df,opt);
  
  //if(strcmp(opt->do_up,"1"))
  //	returnFromWaitMode(df);
  
	return;
}

void autoActiveBytecode(struct debugfs_file * df, struct options * opt){
  
	FILE * log_high_time;
	log_high_time = fopen(opt->auto_active, "a+");
	long int usec;	 
	struct timeval starttime, finishtime;
	time_t rawtime;
	struct tm * timeinfo;
	char buffer[80];
	int i=0;
	int count_change=0;

	opt->active = "1";

	
	while(1){
	    opt->load = "2";
	    opt->name_file = "/tmp/dcf_v3-2.txt";
	    

	    
	    //activation
	    //writeAddressBytecode(df,opt);
		  
	    //loading
	    
	    if(strcmp(opt->do_up,"1"))
		  putInWaitMode(df);
	    
	    gettimeofday(&starttime, NULL);	    
	    bytecodeSharedWrite(df, opt);
	    gettimeofday(&finishtime, NULL);
	    
	    if(strcmp(opt->do_up,"1"))
		  returnFromWaitMode(df);
	    
	    
	    
	    usec=(finishtime.tv_sec-starttime.tv_sec)*1000000;
	    usec+=(finishtime.tv_usec-starttime.tv_usec);	    
	    //usec+=100;
	    
	    time(&rawtime);
	    timeinfo = localtime(&rawtime);
	    //2014 01 26 11 17 15
	    strftime (buffer,80,"%G%m%d%H%M%S",timeinfo);	
	
	    //time activation
	    //fprintf(log_high_time, "%s,%d,%d,%ld\n", buffer, 253, 0, usec); //activation high
	    //printf("%d - %d - %s,%d,%d,%ld\n", i, count_change, buffer, 253, 0,usec);
	    
	    //time loading
	    fprintf(log_high_time, "%s,%d,%d,%ld\n", buffer, 251, 0, usec);
	    printf("%d - %d - %s,%d,%d,%ld\n", i, count_change, buffer, 251, 0,usec);
	    fflush(log_high_time);
	    
	    sleep(2);
	    
	    
	    //2
	    i++;
	    if( (i%2) == 0)
		opt->active = "1";
	    else
	    	opt->active = "2";
	    
	    
	    if (count_change > 45)
	    {
	      printf("share readed\n");
	      shmReadActivateTime(df, opt->time_activate_measure);
	      count_change=0;
	    }
	    else
	      count_change++;

	    if(i>240)
	      break;
	    
	}

	fclose(log_high_time);
	
	return;
}



void writeAddressBytecode(struct debugfs_file * df, struct options * opt){

	int byte_code_address;
	int control_return;
	
/*	
	if(!strcmp(opt->active, "1")){
		printf("Active byte-code '1' \n");
		byte_code_address = PARAMETER_ADDR_OFFSET_BYTECODE_1 ;
	}
	else{
		if(!strcmp(opt->active, "2")){
			printf("Active byte-code '2' \n");
			byte_code_address = PARAMETER_ADDR_OFFSET_BYTECODE_2 ;
		}
		else{
			printf("active must be 1 or 2");
			return;
		}
	}
*/	

	if(!strcmp(opt->active, "1")){
		printf("Active byte-code 1 \n");
		shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xF0FF, 0x0100);
	}
	else{
		if(!strcmp(opt->active, "2")){
			printf("Active byte-code 2 \n");
			shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xF0FF, 0x0200);
		}
		else{
			printf("active must be 1 or 2");
			return;
		}
	}

	while(1)
	{
		control_return = shmRead16(df, B43_SHM_REGS, GPR_CONTROL);
		if( (control_return & 0x0F00) == 0)
		  break;
	}
	//shmMaskSet16(df, B43_SHM_REGS, GPR_BYTECODE_ADDRESS, 0x0000, byte_code_address);
	//setStartState(df);
	//#resetto i bit del timer per ogni evenienza
	//shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xFFF7, 0x000);
	return;
}






	
void setStartState(struct debugfs_file * df){
	int addr_num_state_start;
	int num_state_start;
	//l'indirizzo del bytecode concide proprio con l'indirizzo del paramtro 
	//che contiene lo stato di partenza, il primo parametro
	
	addr_num_state_start = shmRead16(df, B43_SHM_REGS, GPR_BYTECODE_ADDRESS);
	addr_num_state_start = addr_num_state_start * 2;
	//print "****value-addr*"
	//print address_state_start
	//print "***************"
	num_state_start = shmRead16(df, B43_SHM_SHARED, addr_num_state_start);
	shmMaskSet16(df, B43_SHM_REGS, GPR_CURRENT_STATE, 0x0000, num_state_start);
	//print "****value-start*"
	//print num_state_start
	//print "***************"
	return;
}



void load_params(struct debugfs_file * df, struct options * opt){

  
	char line[256];
	char sub_line[256];
	char sub_line_lo[3];
	char sub_line_hi[3];
	
	int address_state_params, address_state_params_start, address_state_descriptor, address_state;
	
	int index = 0;
	int detected_start_file = 0;
	int num_state=0;
	
	int num_addr_condition= 48;
	int addr_condition[48];
	int index_addr_condition = 0;
	int address_condition_procedure_temporary = ADDRESS_CONDITION_PROCEDURE;
	
	int rif_condition=0;
	int addr_proc_condition=0;
	
	FILE * file_bytecode;
		
	//printf("load param start\n");
	//printf("opt load %s\n", opt->load);
	//printf("opt byte-code name %s\n", opt->change_param_file);


	if(!strcmp(opt->load, "1")){
		printf( "Ready load params '1' \n");
		address_state_params_start = PARAMETER_ADDR_BYTECODE_1 ;
		address_state_params = address_state_params_start;
		//address_state_descriptor = 	COMBINATION_ADDR_BYTECODE_1;
		//address_state = 		STATE_ADDR_BYTECODE_1;
	}
	else{ 
		if(!strcmp(opt->load, "2")){
			printf("Ready load params '2' \n");
			address_state_params_start = PARAMETER_ADDR_BYTECODE_2 ;
			address_state_params = address_state_params_start;
			//address_state_descriptor = 	COMBINATION_ADDR_BYTECODE_2;
			//address_state = 		STATE_ADDR_BYTECODE_2;
		}
		else{
			printf("load must be 1 or 2\n");
			//error = True 
			return;
		}	
	}	
	
	if (file_bytecode = fopen(opt->change_param_file, "r")){
		printf("open file : %s\n", opt->change_param_file);
	}
	else{
		
		perror("");
		exit(1);
		//return;
	}


	while(!feof(file_bytecode)){
		//end file
		//if(feof(file_bytecode))
		//	break;
		//line = table_file.readline();
		//fscanf(file_bytecode, "%[^\n]", line);
		//fscanf (file_bytecode, "%s", line);
		fgets (line , 256 , file_bytecode);
		//printf("%s\n", line);
		strncpy(sub_line,line,6);
		sub_line[6]='\0';
		//printf("%s\n",sub_line);
		

		if( !strcmp(sub_line,"000001") ){
			detected_start_file = 1;
			printf("-------------------\n");
			printf("start file detected\n");
			
			while(!feof(file_bytecode)){
				//if(feof(file_bytecode))
				//	break;
				fgets (line , 256, file_bytecode);
				strncpy(sub_line,line,6);
				sub_line[6]='\0';
				//printf("%c\n", sub_line[0]);
				
				if(sub_line[0] == '#'){
					//printf( "commento\n");
					continue;
				}	
				//if len(line) == 0:
				//	break

				//read index state parameter
				if( !strcmp(sub_line,"000003") ){ //if line[0:6] == "000004":
					fgets (line , 256 , file_bytecode);
					//printf("type 000004   : %s  ", line);
					//printf("conversione %lu \n", strtoul(line,NULL,16));
					sprintf(sub_line_lo,"%c%c",line[0],line[1]);
					//sprintf(sub_line_hi,"%c%c",line[2],line[3]);
					//printf("conversione - 1 - %s - %lu \n",sub_line_lo, strtoul(sub_line_lo,NULL,16));
					address_state_params  = address_state_params_start  + (strtoul(sub_line_lo,NULL,16) * 2);
				}

				
				//read state parameter
				if( !strcmp(sub_line,"000004") ){ //if line[0:6] == "000004":
					fgets (line , 256 , file_bytecode);
					//printf("type 000004   : %s  ", line);
					//printf("conversione %lu \n", strtoul(line,NULL,16));

					sprintf(sub_line_lo,"%c%c",line[0],line[1]);
					sprintf(sub_line_hi,"%c%c",line[2],line[3]);
					
					//printf("conversione - 1 - %s - %lu \n",sub_line_lo, strtoul(sub_line_lo,NULL,16));
					//printf("conversione - 2 - %s - %lu \n",sub_line_hi, (strtoul(sub_line_hi,NULL,16) << 8));
					
					shmMaskSet16(df, B43_SHM_SHARED, address_state_params , 0xFF00, strtoul(sub_line_lo,NULL,16));
					shmMaskSet16(df, B43_SHM_SHARED, address_state_params , 0x00FF, (strtoul(sub_line_hi,NULL,16) << 8));
					address_state_params  = address_state_params  + 2;
				}
					
					
				//end file
				if( !strcmp(sub_line,"000099") ){ //if line[0:6] == "000099":
					printf("end load file\n");
					printf("-------------\n");
					break;
				}

	if(detected_start_file == 0)
		printf("Error : Could not find start file (000001)");

  			}
		}
	}

	fclose(file_bytecode);
	return;

}


void parser(struct debugfs_file * df, struct options * opt){
  
	unsigned int byte_code_address;
	byte_code_address = shmRead16(df, B43_SHM_REGS, GPR_BYTECODE_ADDRESS);
  
// 	// this part force brutal write if the bytecode to loaded is not used
// 	if( (strcmp(opt->load, "1"))  &&  (byte_code_address == PARAMETER_ADDR_OFFSET_BYTECODE_1) ){
// 		//printf( "load byte-code '2' but activeted is 1 \n");
// 		opt->do_up = "1";
// 	}
// 	if( (strcmp(opt->load, "2"))  && (byte_code_address == PARAMETER_ADDR_OFFSET_BYTECODE_2) ){
// 		//printf("Ready load byte-code '2' \n");
// 		opt->do_up = "1";
// 	}
  
	//printf( "load byte-code 10 \n");
	
	if(strcmp(opt->do_up,"1"))
		putInWaitMode(df);

	//printf( "load byte-code 20 \n");
	
	bytecodeSharedWrite(df, opt);

	//printf( "load byte-code 30 \n");
	
	if(strcmp(opt->do_up,"1"))
		returnFromWaitMode(df);

	//printf( "load byte-code 40 \n");

	return;
}	




void putInWaitMode(struct debugfs_file * df){

	//fermo il MACengine solo quando questo raggiunge lo stato di start
	int value_reg=0;
	//printf("putFromWaitMode before set - 1 \n");
	
	//devo cambiare solo il bit che dice al MACengine che sono pronto a caricare una tabella
	shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xFFFE, 0x0001);
	
	//printf("putFromWaitMode before set - 2 \n");
	
	while (1){
		//verifico soltanto i due bit che mi dicono che adesso posso caricare la maclet,
		//perche il macengine si e' fermato nello stato di start
		//unsigned int shmRead32_int(struct debugfs_file * df, int routing, int offset);
		value_reg = shmRead16(df, B43_SHM_REGS, GPR_CONTROL);
		//printf("value_reg : %X \n", value_reg);   
		if ( (value_reg & 0x0003) == 0x03 ){
		      break;
		}
	}
	//printf("putFromWaitMode after set\n");
	//ucodeStop(df);
	return;
}

void returnFromWaitMode(struct debugfs_file * df){
	
	//conclusione inezione byte-code, adesso devo riportare i bit di control
	//printf("returnFromWaitMode before set\n");
	shmMaskSet16(df,B43_SHM_REGS, GPR_CONTROL, 0xFFFC, 0x0000);
	//printf("returnFromWaitMode after set\n");
	//ucodeStart(df);
	return;
}	


void bytecodeSharedWrite(struct debugfs_file * df, struct options * opt){
	
	char line[256];
	char sub_line[256];
	char sub_line_lo[3];
	char sub_line_hi[3];
	
	int address_state_params, address_state_params_start, address_state_descriptor, address_state;
	
	int index = 0;
	int detected_start_file = 0;
	int num_state=0;
	int num_writings=0;
	
	int num_addr_condition= 48;
	int addr_condition[48];
	int index_addr_condition = 0;
	int address_condition_procedure_temporary = ADDRESS_CONDITION_PROCEDURE;
	
	int rif_condition=0;
	int addr_proc_condition=0;
	
	FILE * file_bytecode;
		
//	printf("parser start\n");
//	printf("opt load %s\n", opt->load);
//	printf("opt byte-code name %s\n", opt->name_file);

	if(!strcmp(opt->load, "1")){
		printf( "Ready load byte-code '1' \n");
		address_state_params_start = PARAMETER_ADDR_BYTECODE_1 ;
		address_state_params = 	address_state_params_start;
		address_state_descriptor = 	COMBINATION_ADDR_BYTECODE_1;
		address_state = 		STATE_ADDR_BYTECODE_1;
	}
	else{ 
		if(!strcmp(opt->load, "2")){
			printf("Ready load byte-code '2' \n");
			address_state_params_start = PARAMETER_ADDR_BYTECODE_2 ;
			address_state_params = address_state_params_start;
			address_state_descriptor = 	COMBINATION_ADDR_BYTECODE_2;
			address_state = 		STATE_ADDR_BYTECODE_2;
		}
		else{
			printf("load must be 1 or 2\n");
			//error = True 
			return;
		}	
	}	
	
	if (file_bytecode = fopen(opt->name_file, "r")){
		printf("open file : %s\n", opt->name_file);
	}
	else{
		
		perror("");
		exit(1);
		//return;
	}

	//printf( "address_state_params : %X \n address_state_descriptor : %X \n address_state : %X\n", address_state_params, address_state_descriptor, address_state);

	//Fetch the hardware information
	//load address condition
	//addr_condition=zeros(num_addr_condition, Int)
	//addr_condition=range(0,48)
	while (index_addr_condition != num_addr_condition){
		addr_condition[index_addr_condition] = shmRead16(df,B43_SHM_SHARED, address_condition_procedure_temporary);
		address_condition_procedure_temporary += 2;
		index_addr_condition += 1;
	}
	index_addr_condition=0;
	//while (index_addr_condition != num_addr_condition){
	//	printf(" %X ",addr_condition[index_addr_condition]);
	//	//print addr_condition[ind_addr_condition]
	//	index_addr_condition += 1;
	//}
	
	while(!feof(file_bytecode)){
		//end file
		//if(feof(file_bytecode))
		//	break;
		//line = table_file.readline();
		//fscanf(file_bytecode, "%[^\n]", line);
		//fscanf (file_bytecode, "%s", line);
		fgets (line , 256 , file_bytecode);
		//printf("%s\n", line);
		strncpy(sub_line,line,6);
		sub_line[6]='\0';
		//printf("%s\n",sub_line);
		

		if( !strcmp(sub_line,"000001") ){
			detected_start_file = 1;
			printf("-------------------\n");
			printf("start file detected\n");
			
			while(!feof(file_bytecode)){
				//if(feof(file_bytecode))
				//	break;
				fgets (line , 256, file_bytecode);
				strncpy(sub_line,line,6);
				sub_line[6]='\0';
				//printf("%c\n", sub_line[0]);
				
				if(sub_line[0] == '#'){
					//printf( "commento\n");
					continue;
				}	
				//if len(line) == 0:
				//	break

				//read index state parameter
				if( !strcmp(sub_line,"000003") ){ //if line[0:6] == "000004":
					fgets (line , 256 , file_bytecode);
					//printf("type 000004   : %s  ", line);
					//printf("conversione %lu \n", strtoul(line,NULL,16));
					sprintf(sub_line_lo,"%c%c",line[0],line[1]);
					//sprintf(sub_line_hi,"%c%c",line[2],line[3]);
					//printf("conversione - 1 - %s - %lu \n",sub_line_lo, strtoul(sub_line_lo,NULL,16));
					address_state_params  = address_state_params_start  + (strtoul(sub_line_lo,NULL,16) * 2);
				}
				
				//read state parameter
				if( !strcmp(sub_line,"000004") ){ //if line[0:6] == "000004":
					fgets (line , 256 , file_bytecode);
					//printf("type 000004   : %s  ", line);
					//printf("conversione %lu \n", strtoul(line,NULL,16));

					sprintf(sub_line_lo,"%c%c",line[0],line[1]);
					sprintf(sub_line_hi,"%c%c",line[2],line[3]);
					
					//printf("conversione - 1 - %s - %lu \n",sub_line_lo, strtoul(sub_line_lo,NULL,16));
					//printf("conversione - 2 - %s - %lu \n",sub_line_hi, (strtoul(sub_line_hi,NULL,16) << 8));
					
					shmMaskSet16(df, B43_SHM_SHARED, address_state_params , 0xFF00, strtoul(sub_line_lo,NULL,16));
					shmMaskSet16(df, B43_SHM_SHARED, address_state_params , 0x00FF, (strtoul(sub_line_hi,NULL,16) << 8));
					address_state_params  = address_state_params  + 2;
				}
					
				//read combination
				if( !strcmp(sub_line,"000006") ){ //if line[0:6] == "000006":
					fgets (line , 256 , file_bytecode);
					//printf("type 000006   : %s  ", line);
					//printf("conversione %lu \n", strtoul(line,NULL,16));
					index = 0;
					while(1){
						sprintf(sub_line,"%c%c",line[index+2],line[index+3]);
						rif_condition = strtoul(sub_line,NULL,16);

						//printf("******** debug ***********\n");
						//printf("%X\n", rif_condition);
						addr_proc_condition = addr_condition[rif_condition];
						//printf("%X\n", addr_proc_condition);
																	
						shmMaskSet16(df, B43_SHM_SHARED, address_state_descriptor, 0x0000, addr_proc_condition);
						address_state_descriptor = address_state_descriptor + 2;
						index = index + 4;

						sprintf(sub_line,"%c%c",line[index],line[index+1]);
						shmMaskSet16(df, B43_SHM_SHARED, address_state_descriptor, 0xFF00, strtoul(sub_line,NULL,16));
						sprintf(sub_line,"%c%c",line[index+2],line[index+3]);
						shmMaskSet16(df,B43_SHM_SHARED, address_state_descriptor, 0x00FF, (strtoul(sub_line,NULL,16)<<8));
						address_state_descriptor = address_state_descriptor + 2;
						index = index + 4;
						
						sprintf(sub_line,"%c%c",line[index],line[index+1]);
						shmMaskSet16(df,B43_SHM_SHARED, address_state_descriptor, 0xFF00, strtoul(sub_line,NULL,16));
						sprintf(sub_line,"%c%c",line[index+2],line[index+3]);
						shmMaskSet16(df,B43_SHM_SHARED, address_state_descriptor, 0x00FF, (strtoul(sub_line,NULL,16)<<8) );
						address_state_descriptor = address_state_descriptor + 2;
						index = index + 4;
						
						sprintf(sub_line,"%c%c%c%c",line[index],line[index+1],line[index+2],line[index+3]);
						if( !strcmp(sub_line, "FFFF")){
							shmMaskSet16(df,B43_SHM_SHARED, address_state_descriptor, 0xFFFF, 0xFFFF);
							address_state_descriptor = address_state_descriptor + 2;
							break;
						}
						
						if(line[index]== '$'){
							//printf("dentro if ");
							break;
						}	
					
					}
				}

				//read state
				if( !strcmp(sub_line,"000010") ){ //if line[0:6] == "000010":
					fgets (line , 256 , file_bytecode);
					//printf("type 000010    %s  ", line);
					
					sprintf(sub_line,"%c%c",line[0],line[1]);
					shmMaskSet16(df,B43_SHM_SHARED, address_state, 0xFF00, (strtoul(sub_line,NULL,16)));
					
					sprintf(sub_line,"%c%c",line[2],line[3]);
					shmMaskSet16(df,B43_SHM_SHARED, address_state, 0x00FF, (strtoul(sub_line,NULL,16)<<8));
					
					address_state = address_state + 2;
				}	
					
				//end file
				if( !strcmp(sub_line,"000099") ){ //if line[0:6] == "000099":
					printf("end load file\n");
					printf("-------------\n");
					break;
				}

// 				num_writings++;
// 				if (num_writings == 10){
// 				  num_writings=0;
// 				  returnFromWaitMode(df);
// 				  sleep(2);
// 				  putInWaitMode(df);
// 				}	
  			}  			
		}

	}

	
	
	if(detected_start_file == 0)
	    printf("Error : Could not find start file (000001)");

	
	fclose(file_bytecode);
	return;
}



void setTimer2(struct debugfs_file * df, struct options * opt){
	unsigned int time_word2, time_word1, time_word0, time_word_all, time_stamp_to_active;
	
	unsigned int micro_time = atoi(opt->time) * 1000000 ;
	micro_time = micro_time >> 16; 
	//printf("setTimer2 - micro_time : %04x\n", micro_time);
	//SHM_RX_TIME_WORD3	=	0x078
	//SHM_RX_TIME_WORD2	=	0x07A
	//inserire un controllo sul massimo valore in secondi che si puo' coprire con 32bit
	//time_word2 =	shmRead16(df, B43_SHM_SHARED, SHM_RX_TIME_WORD2);
	//time_word1 =	shmRead16(df, B43_SHM_SHARED, SHM_RX_TIME_WORD1);
	//time_word0 =	shmRead16(df, B43_SHM_SHARED, SHM_RX_TIME_WORD0);
	//time_word_all = 0xFFFF0000 & (time_word2<<16);
	//time_word_all = time_word_all + time_word1;
	//printf("setTimer2 - time_word_all : %08x\n", time_word_all);
	//time_stamp_to_active = time_word_all + micro_time;
	//printf("setTimer2 - time_stamp_to_active : %08x\n", time_stamp_to_active);
	
	shmMaskSet16(df, B43_SHM_REGS, REG_TIMER_DELAY_2, 0x0000, (micro_time>>16) );
	shmMaskSet16(df, B43_SHM_REGS, REG_TIMER_DELAY_1, 0x0000, micro_time);

	//conclusione inezione byte-code, adesso devo riportare i bit di control per attivare il controllo del timer
	shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xFFF3, 0x004);

	return;
}


int calculateDelay(struct debugfs_file * df, struct options * opt){
	//print "in to calcuate"
	//print calculation
	int micro_delay, time_word1, time_word0, time_word_all, time_stamp_to_active;
	
	//inserire un controllo sul massimo valore in secondi che si puo' coprire con 32bit
	micro_delay = atoi(opt->calculation) * 1000000 ;
	//print micro_delay
	//print 	b43.shmRead16(B43_SHM_SHARED, SHM_RX_TIME_WORD3)
	//print 	b43.shmRead16(B43_SHM_SHARED, SHM_RX_TIME_WORD2)
	time_word1 = shmRead16(df, B43_SHM_SHARED, SHM_RX_TIME_WORD1);
	time_word0 = shmRead16(df, B43_SHM_SHARED, SHM_RX_TIME_WORD0);
	//print hex(time_word1)
	//#print hex(time_word0)
	
	time_word_all = 0xFFFF0000 & (time_word1<<16);
	time_word_all = time_word_all + time_word0;
	//print 	hex(time_word_all)
	//printf("time_word_all : %u\n", time_word_all);
	time_stamp_to_active = time_word_all + micro_delay;

	return time_stamp_to_active;	
}




void setDelay(struct debugfs_file * df, struct options * opt){
	//print "in to delay"
	//print delay
	unsigned int time_stamp_to_active;
	
	time_stamp_to_active = atoi(opt->delay);
	time_stamp_to_active = time_stamp_to_active >> 16;
	//printf("time_stamp_to_active : %08x\n", time_stamp_to_active);
	
	shmMaskSet16(df, B43_SHM_REGS, REG_TIMER_DELAY_2, 0x0000, (time_stamp_to_active>>16) );
	shmMaskSet16(df, B43_SHM_REGS, REG_TIMER_DELAY_1, 0x0000, time_stamp_to_active);
	
	//per attivare lo switch con ritardo devo abilitare il 5 bit del registro control
	shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xFFEF, 0x010);

	return;
}

	
void setDelayTimer(struct debugfs_file * df, struct options * opt){
	//print "in to timer_delay"
	int micro_time_delay = 0;
	micro_time_delay = atoi(opt->time) * 1000000 ;
	micro_time_delay = micro_time_delay >> 16;
	
	shmMaskSet16(df, B43_SHM_SHARED, TIMER_DELAY_2_TIME_OUT, 0x0000, (micro_time_delay>>16) );
	shmMaskSet16(df, B43_SHM_SHARED, TIMER_DELAY_1_TIME_OUT, 0x0000, micro_time_delay);

	//conclusione inezione byte-code, adesso devo riportare i bit di control per attivare il controllo del timer
	shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xFFF3, 0x004);
	return;
}


void resetControl(struct debugfs_file * df){
	shmMaskSet16(df, B43_SHM_REGS, GPR_CONTROL, 0xFFE0, 0x0000);
	return;
}	

