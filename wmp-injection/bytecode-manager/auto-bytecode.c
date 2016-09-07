#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <getopt.h>

//#include "auto-bytecode.h"
#include "wmpVars.h"
#include "vars.h"



int auto_bytecode(struct options *current_options){

  int ret =0; 
//  int bc_loc=2;		// fixed at 2 because this is the bytecode for a environment different from normal 
//  int addr1, addr2, addr3;
  
  int index_subwrite=0;
  int num_param=0;
  int detected_start_file=0;
  int parameter_writted=0;
  char line[256];
  char line_mod[256];
  char sub_line[256];
  char sub_line_out[256];
  char sub_line_lo[3];
  char sub_line_hi[3];

  
	while(!feof(current_options->in_file)){
		fgets (line , 256 , current_options->in_file);
		strncpy(sub_line,line,6);
		sub_line[6]='\0';

		if( !strcmp(sub_line,"000001") ){
			detected_start_file = 1;
			printf("-------------------\n");
			printf("start file detected\n");	
			fputs(line,current_options->out_file);
			
			while(!feof(current_options->in_file)){
				fgets (line , 256, current_options->in_file);
				//printf("%s", line);
				strncpy(sub_line,line,6);
				sub_line[6]='\0';
				fputs(line,current_options->out_file);

				//check state parameter
				if( !strcmp(sub_line,"000004") ){ //if line[0:6] == "000004":
					fgets (line , 256, current_options->in_file);
					//printf("type 000004   : %s  : %d\n", line, num_param);
					//printf("conversione %lu \n", strtoul(line,NULL,16));
					//printf("conversione - 1 - %s - %lu \n",sub_line_lo, strtoul(sub_line_lo,NULL,16));
					//printf("conversione - 2 - %s - %lu \n",sub_line_hi, (strtoul(sub_line_hi,NULL,16) << 8));
					
					  
					  
//contiene lo stato di partenza delle vari macchine a stati
// 		#define 	STATE_MACHINE_START_OFFSET			0
// 		#define 	PARAM_BACKOFF_01_OFFSET				1
// 		#define		PARAM_CHANNEL_OFFSET				2
					if((num_param==PARAM_CHANNEL) & (current_options->channel!=-1)){
					      printf("change channel\n");
					      sprintf(line_mod,"%04X\n",current_options->channel);
					      sprintf(sub_line_out,"%c%c%c%c\n",line_mod[2],line_mod[3],line_mod[0],line_mod[1]);
					      fputs(sub_line_out,current_options->out_file);
					      parameter_writted=1;
					}

// 		#define		TX_PACKET_DEST_ADD_1_OFFSET				3
// 		#define		TX_PACKET_DEST_ADD_2_OFFSET				4
// 		#define		TX_PACKET_DEST_ADD_3_OFFSET				5
					if(num_param==TX_PACKET_DEST_ADD_1 && current_options->enable_mac_address!=-1){
					      printf("change tx-macaddress\n");
					      //sprintf(line,"%04X\n",current_options->mac_addr[0]);

					      sprintf(sub_line_out,"%02X%02X\n",current_options->mac_addr[0],current_options->mac_addr[1]);
					      fputs(sub_line_out,current_options->out_file);
					      num_param++;
					      
					      fgets (line , 256, current_options->in_file);
					      fputs(line,current_options->out_file);
					      fgets (line , 256, current_options->in_file);
					      sprintf(sub_line_out,"%02X%02X\n",current_options->mac_addr[2],current_options->mac_addr[3]);
					      fputs(sub_line_out,current_options->out_file);
					      num_param++;

					      fgets (line , 256, current_options->in_file);
					      fputs(line,current_options->out_file);
					      fgets (line , 256, current_options->in_file);
					      sprintf(sub_line_out,"%02X%02X\n",current_options->mac_addr[4],current_options->mac_addr[5]);
					      fputs(sub_line_out,current_options->out_file);
					      

					      parameter_writted=1;
					}
// 		#define		RX_PACKET_SOUR_ADD_1_OFFSET				6
// 		#define		RX_PACKET_SOUR_ADD_2_OFFSET				7
// 		#define		RX_PACKET_SOUR_ADD_3_OFFSET				8   

// 		#define		TSF_GPT0_0_CNTHI_OFFSET				9
// 		#define		TSF_GPT0_0_CNTLO_OFFSET				0x0A
// 		#define		TSF_GPT0_1_CNTHI_OFFSET				0x0B
// 		#define		TSF_GPT0_1_CNTLO_OFFSET				0x0C
// 		#define		TSF_GPT1_0_CNTHI_OFFSET				0x0D
// 		#define		TSF_GPT1_0_CNTLO_OFFSET				0x0E
// 		#define		TSF_GPT1_1_CNTHI_OFFSET				0x0F
// 		#define		TSF_GPT1_1_CNTLO_OFFSET				0x10
					if (num_param==TSF_GPT0_0_CNTHI && current_options->enable_timer!=-1){
						  printf("change timer value\n");
					      
						  index_subwrite=0;
						  sprintf(line_mod,"%08X\n",current_options->timer[0]*8);
//						  printf("%s : %d\n",line_mod,index_subwrite);
						  sprintf(sub_line_out,"%c%c%c%c\n",line_mod[2],line_mod[3],line_mod[0],line_mod[1]);
						  fputs(sub_line_out,current_options->out_file);
						  num_param++;
						  fgets (line , 256, current_options->in_file);
						  fputs(line,current_options->out_file);
						  fgets (line , 256, current_options->in_file);
						  sprintf(sub_line_out,"%c%c%c%c\n",line_mod[6],line_mod[7],line_mod[4],line_mod[5]);
						  fputs(sub_line_out,current_options->out_file);
						  num_param++;
						  //repeat again

						  for(index_subwrite=1; index_subwrite<4; index_subwrite++){
							fgets (line , 256, current_options->in_file);
							fputs(line,current_options->out_file);
							fgets (line , 256, current_options->in_file);
							sprintf(line_mod,"%08X\n",current_options->timer[index_subwrite]*8);
//							printf("%s : %d\n",line_mod,index_subwrite);
							sprintf(sub_line_out,"%c%c%c%c\n",line_mod[2],line_mod[3],line_mod[0],line_mod[1]);
							fputs(sub_line_out,current_options->out_file);
							num_param++;
							fgets (line , 256, current_options->in_file);
							fputs(line,current_options->out_file);
							fgets (line , 256, current_options->in_file);
							sprintf(sub_line_out,"%c%c%c%c\n",line_mod[6],line_mod[7],line_mod[4],line_mod[5]);
							fputs(sub_line_out,current_options->out_file);
							num_param++;
						  }  
						  
						  num_param--;
						  parameter_writted=1;

						
					}//leggere a vuoto un numero di righe a pari a quelle scritte
// 		#define		PARAM_FREE_02_OFFSET				0x11
// 		#define		PARAM_FREE_03_OFFSET				0x12
// 		#define		PARAM_FREE_04_OFFSET				0x13
// 		#define		PARAM_FREE_05_OFFSET				0x14
// 		#define		CHECK_CHANNEL_OFFSET				0x15
// 		#define		TIME_SLOT_OFFSET				0x16
					if(num_param==TIME_SLOT && current_options->timeslot!=-1){
					      printf("change time slot\n");
					      sprintf(line_mod,"%04X\n",current_options->timeslot);
					      sprintf(sub_line_out,"%c%c%c%c\n",line_mod[2],line_mod[3],line_mod[0],line_mod[1]);
					      fputs(sub_line_out,current_options->out_file);
					      parameter_writted=1;
					}
					
// 		#define		CHANNEL_MACLET_OFFSET					0x17
// 		#define		INFLATION_MUL_BACKOFF_OFFSET				0x18
// 		#define		INFLATION_ADD_BACKOFF_OFFSET				0x19
// 		#define		DEFLATION_DIV_BACKOFF_OFFSET				0x1A
// 		#define		DEFLATION_SUB_BACKOFF_OFFSET				0x1B
// 		#define		MIN_CONTENTION_WIN_BOOT_OFFSET				0x1C
// 		#define		MAX_CONTENTION_WIN_BOOT_OFFSET				0x1D
// 		#define		CUR_CONTENTION_WIN_BOOT_OFFSET				0x1E
// 		#define		SET_VALUE_OFFSET					0x1F
// 		#define		CHECK_VALUE_OFFSET					0x20
// 		#define		TIME_SLOT_POSITION_OFFSET				0x21
					if(num_param==TIME_SLOT_POSITION && current_options->position!=-1){
					      printf("change time slot position\n");
					      sprintf(line_mod,"%04X\n",current_options->position);
					      sprintf(sub_line_out,"%c%c%c%c\n",line_mod[2],line_mod[3],line_mod[0],line_mod[1]);
					      fputs(sub_line_out,current_options->out_file);
					      parameter_writted=1;
					}
					
					if(parameter_writted==0)
						fputs(line,current_options->out_file);
					else
						parameter_writted=0;
					
					num_param++;
					continue;
				}
				
				//end file
				if( !strcmp(sub_line,"000099") ){ //if line[0:6] == "000099":
					printf("end load file\n");
					printf("-------------\n");
					break;
				}


  			}
		}
	}
	
	if(detected_start_file == 0)
		printf("Error : Could not find start file (000001)");

	fclose(current_options->in_file);
	fclose(current_options->out_file);

	return ret;
  
}

  
//   if (current_options->enable_timer!=-1)
//   {
// 	printf("write timer\n");
// 	//fprintf(stdout,"%u %u %u %u\n",current_options->timer[0],current_options->timer[1],current_options->timer[2],current_options->timer[3]);
// 	//fprintf(stdout,"%x %x %x %x\n",current_options->timer[0],current_options->timer[1],current_options->timer[2],current_options->timer[3]);
//     
// 	// SETTING OF TIMERS
// 	unsigned short int timer_l=(current_options->timer[0]*8)&0xFFFF;
// 	unsigned short int timer_h=((current_options->timer[0]*8)&0xFFFF0000)>>16;
// 	//printf("timer_l=%x\n",timer_l);
// 	//printf("timer_h=%X\n",timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_00_H,timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_00_L,timer_l);
// 	
// 	timer_l=(current_options->timer[1]*8)&0xFFFF;
// 	timer_h=((current_options->timer[1]*8)&0xFFFF0000)>>16;
// 	//printf("timer_l=%x\n",timer_l);
// 	//printf("timer_h=%X\n",timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_01_H,timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_01_L,timer_l);
// 	
// 	timer_l=(current_options->timer[2]*8)&0xFFFF;
// 	timer_h=((current_options->timer[2]*8)&0xFFFF0000)>>16;
// 	//printf("timer_l=%x\n",timer_l);
// 	//printf("timer_h=%X\n",timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_10_H,timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_10_L,timer_l);
// 	timer_l=(current_options->timer[3]*8)&0xFFFF;
// 	timer_h=((current_options->timer[3]*8)&0xFFFF0000)>>16;
// 	//printf("timer_l=%x\n",timer_l);
// 	//printf("timer_h=%X\n",timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_11_H,timer_h);
// 	wmp_set_parameter(&wmpi,bc_loc,WMP_TIMER_11_L,timer_l);
// 	
//   }
//   
//   
//   
// 
//   
//   if (current_options->timeslot!=-1){
//       // SETTING OF TIMESLOT TIMESLOT
//       printf("write timeslot\n");
//       wmp_set_parameter(&wmpi,bc_loc, WMP_CHECK_TIME_SLOT, current_options->timeslot);
//       
//   }
//   
//   if (current_options->position!=-1){
//       // SETTING OF TIMESLOT POSITION
//       printf("write position\n");
//       wmp_set_parameter(&wmpi,bc_loc, WMP_TIME_SLOT_POSITION, current_options->position);
//       
//   }
// 
// //   if (current_options->channel!=-1){
// //       // SETTING OF TIMESLOT CHANNEL
// //       printf("write channel\n");
// //       wmp_set_parameter(&wmpi,bc_loc, WMP_PARAM_CHANNEL, current_options->channel);
// //       wmp_set_parameter(&wmpi,bc_loc, WMP_CHECK_CHANNEL, current_options->channel);
// //       
// //   }
// 
//   
// //   if (current_options->enable_mac_address!=-1)
// //   {
// //       //printf("Got: %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n", current_options->mac_addr[0],current_options->mac_addr[1],current_options->mac_addr[2],current_options->mac_addr[3],current_options->mac_addr[4],current_options->mac_addr[5]);
// //       addr1=(current_options->mac_addr[1]<<8)+current_options->mac_addr[0];
// //       addr2=(current_options->mac_addr[3]<<8)+current_options->mac_addr[2];
// //       addr3=(current_options->mac_addr[5]<<8)+current_options->mac_addr[4];
// //     
// //       // SETTING OF MAC ADDRESS for DIRECT LINK
// //       wmp_set_parameter(&wmpi,bc_loc,WMP_TX_MAC_ADDR_1,addr1);
// //       wmp_set_parameter(&wmpi,bc_loc,WMP_TX_MAC_ADDR_2,addr2);
// //       wmp_set_parameter(&wmpi,bc_loc,WMP_TX_MAC_ADDR_3,addr3);
// //       
// //       wmp_set_parameter(&wmpi,bc_loc,WMP_RX_MAC_ADDR_1,addr1);
// //       wmp_set_parameter(&wmpi,bc_loc,WMP_RX_MAC_ADDR_2,addr2);
// //       wmp_set_parameter(&wmpi,bc_loc, WMP_RX_MAC_ADDR_3, addr3); 
// //   }
  
 
  
