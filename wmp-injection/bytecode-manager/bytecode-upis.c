
#include "libb43.h"
#include "bytecode-upis.h"
#include "hex2int.h"
#include "dataParser.h"
#include "vars.h"




void getParameterLowerLayer(struct debugfs_file * df, struct options * opt, char *return_message){
	// opt->get_parameter : "CSMA_CW,CSMA_CW_MIN,CSMA_CW_MAX,....."

  
	char ret_msg[1024]="";
	char * pch;
	unsigned int read_wmp_value;
	
	pch = strtok (opt->get_parameter,",");
	while (pch != NULL)
	{
	   
	    //PHY
	    if(!strcmp(pch,"IEEE80211_AP_CHANNEL")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"IEEE80211_CHANNEL")){
		  read_wmp_value = read16(df, B43_MMIO_CHANNEL);   //to check if work
	    }
	    if(!strcmp(pch,"IEEE80211_MCS")){
		  read_wmp_value = 0;
	    }
	    if(!strcmp(pch,"IEEE80211_CCA")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"TX_POWER")){
		  read_wmp_value = 0;
	    }
	    if(!strcmp(pch,"TX_ANTENNA")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"RX_ANTENNA")){
		  read_wmp_value = 0;
	    }
	      
	    //TDMA
	    if(!strcmp(pch,"TDMA_SUPER_FRAME_SIZE")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"TDMA_NUMBER_OF_SYNC_SLOT")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"TDMA_ALLOCATED_SLOT")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"TDMA_MAC_PRIORITY_CLASS")){
		  read_wmp_value = 0;
	    }
	      
	    //CSMA
	    if(!strcmp(pch,"CSMA_TIMESLOT")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"CSMA_MAC_PRIORITY_CLASS")){
		  read_wmp_value = 0;
	    } 
	    if(!strcmp(pch,"CSMA_BACKOFF_VALUE")){
		  read_wmp_value = 0;
	    }
	    if(!strcmp(pch,"CSMA_CW")){
		read_wmp_value = shmRead16(df, B43_SHM_REGS, CUR_CONTENTION_WIN);	
	    }
	    if(!strcmp(pch,"CSMA_CW_MIN")){
		read_wmp_value = shmRead16(df, B43_SHM_REGS, CUR_CONTENTION_WIN);
	    }
	    if(!strcmp(pch,"CSMA_CW_MAX")){
		read_wmp_value = shmRead16(df, B43_SHM_REGS, CUR_CONTENTION_WIN);
	    }
	    
	    if(!strcmp(ret_msg,""))
	      sprintf(ret_msg,"%s,%d", pch, read_wmp_value);
	    else
	      sprintf(ret_msg,"%s,%s,%d", ret_msg, pch, read_wmp_value);
	    
	    pch = strtok (NULL, ",");
	}

	sprintf(return_message,"%s",ret_msg);
}




void get_interface_name(){
 
  struct ifaddrs *addrs,*tmp;
  getifaddrs(&addrs);
  tmp = addrs;
  char ret_msg[1024]="";

  while (tmp)
  {
      if (tmp->ifa_addr && tmp->ifa_addr->sa_family == AF_PACKET){
	  //printf("%s\n", tmp->ifa_name);
	  if (strncmp (tmp->ifa_name, "wlan0", 4) == 0)
	  {
	    //printf("%s\n", tmp->ifa_name);
	    //if(!strcmp(ret_msg,""))
	      sprintf(ret_msg,"%s,WMP\n", tmp->ifa_name);
	    //else
	      //sprintf(ret_msg,"%s,%s", ret_msg, tmp->ifa_name);
	  }
      }
      tmp = tmp->ifa_next;
  }
  freeifaddrs(addrs);
  printf("%s",ret_msg);
}



/*

void shmReadStateTime(struct debugfs_file * df,  char * file_name){
  
 	char buffer[80];
	char time_stamp_char[128][32];  
	char state_num_char[128][32];
	char exit_transition_char[128][32];
	int offset;
	int enable_store=0;
	long int time_stamp_1=1;  
	long int state_num_1=0;
	long int exit_transition_1=0;
	long int time_stamp_2=1;  
	long int state_num_2=0;
	long int exit_transition_2=0;
	long int state_time=0;
	long int last_time_stamp=0;
  
	time_t rawtime;
	struct tm * timeinfo;
  	int i,j;

	FILE * log_state_time;
	log_state_time = fopen(file_name, "w+");
	
	//printf("name file %s\n",file_name);
	
	for(j=0; j<300; j++){
		printf("%d\n", j);
		  
		#define REGION_DEBUG_START	3072	
		#define REGION_DEBUG_STOP 	4048
		i=0;
		for (offset=REGION_DEBUG_START; offset < REGION_DEBUG_STOP; offset+=4){
		  
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(time_stamp_char[i],"%c%c%c%c%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9],buffer[2],buffer[3],buffer[4],buffer[5]);
		      //printf("%s - %ld \n", time_stamp_char[i], strtol(time_stamp_char[i], NULL, 16));
		  
		      offset+=4;
		  		  
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(state_num_char[i],"%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9]);
		      //printf("%s ", state_num_char);
		      sprintf(exit_transition_char[i],"%c%c",buffer[4],buffer[5]);
		      //printf("%s ", exit_transition_char);
		      
		      i++;
		}
		
		i=0;
		state_num_1 = strtol(state_num_char[i], NULL, 16);
		exit_transition_1 = strtol(exit_transition_char[i], NULL, 16);
		time_stamp_1 = strtol(time_stamp_char[i], NULL, 16);
		i++;      
		
		for (offset=(REGION_DEBUG_START+8); offset < REGION_DEBUG_STOP; offset+=4){    
		      //printf("\n");
		      //printf("%d - 0x%04X:\t", i, offset);
		  
		      state_num_2 = strtol(state_num_char[i], NULL, 16);
		      //printf("%ld \t", state_num);

		      exit_transition_2 = strtol(exit_transition_char[i], NULL, 16);
		      //printf("%ld \t", exit_transition);

		      offset+=4;

		      time_stamp_2 = strtol(time_stamp_char[i], NULL, 16);
		      //printf("%ld \t\n", time_stamp);

		      if( time_stamp_1 > last_time_stamp && time_stamp_2 > time_stamp_1) {
			  last_time_stamp = time_stamp_1;
			  state_time = time_stamp_2 - time_stamp_1;
			  printf("%d - %d - 0x%04X:\t", j, i, offset);
		  
			  time(&rawtime);
			  timeinfo = localtime(&rawtime);
			  //2014 01 26 11 17 15
			  strftime (buffer,80,"%G%m%d%H%M%S",timeinfo);	
			  //printf("%s \t%ld\t %ld\t %ld\t %ld\t %ld\n", buffer, state_num_1, exit_transition_1, time_stamp_1, time_stamp_2, state_time);
			  printf("%s \t%ld\t %ld\t %ld\t %ld\n", buffer, state_num_1, exit_transition_1, time_stamp_2, state_time);
			  fprintf(log_state_time, "%s,%ld,%ld,%ld\n", buffer, state_num_1, exit_transition_1, state_time);
			  fflush(log_state_time);	      
		      }
		      time_stamp_1 = time_stamp_2;
		      state_num_1 = state_num_2;
		      exit_transition_1 = exit_transition_2;
		      i++;
		      
		}
			
		sleep(1);
	}
	
	fclose(log_state_time);
	printf("\n");

}



void shmReadActivateTime(struct debugfs_file * df,  char * file_name){
  
 	char buffer[80];
	char time_stamp_char[128][32];  
	char state_num_char[128][32];
	char exit_transition_char[128][32];
	int offset;
	int enable_store=1;
	long int time_stamp_1=1;  
	long int time_stamp_2=1;  
	long int state_num=0;
	long int state_num_1=0;
	long int state_num_2=0;
	long int state_time=0;
	long int exit_transition=0;
	long int last_time_stamp=0;
  
	time_t rawtime;
	struct tm * timeinfo;
  	int i,j;

	FILE * log_state_time;
	log_state_time = fopen(file_name, "a+");
	
	//printf("inside name file %s\n",file_name);


	#define REGION_DEBUG_START_1	3408	
	#define REGION_DEBUG_STOP_1 	3936

	
	//for(j=0; j<30; j++){
		printf("%d\n", j);
		  
		i=0;
		for (offset=REGION_DEBUG_START_1; offset < REGION_DEBUG_STOP_1; offset+=4){
		      
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(time_stamp_char[i],"%c%c%c%c%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9],buffer[2],buffer[3],buffer[4],buffer[5]);
		      printf("%s - %ld \t", time_stamp_char[i], strtol(time_stamp_char[i], NULL, 16));      
		      offset+=4;
		      
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(state_num_char[i],"%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9]);
		      printf("%s - %ld\n", state_num_char[i], strtol(state_num_char[i], NULL, 16));
		      //sprintf(exit_transition_char[i],"%c%c",buffer[4],buffer[5]);
		      //printf("%s ", exit_transition_char);
		      //printf("\n");		      
		      i++;
		}
		
		i=0;
		for (offset=REGION_DEBUG_START_1; offset < REGION_DEBUG_STOP_1; offset+=4){    
		      //printf("\n");
		      //printf("%d - 0x%04X:\t", i, offset);
		  
		      state_num_1 = strtol(state_num_char[i], NULL, 16);
		      offset+=4;
		      time_stamp_1 = strtol(time_stamp_char[i], NULL, 16);
		      printf("	%ld \t", time_stamp_1);
		      
		      offset+=4;
		      i++;

		      state_num_2 = strtol(state_num_char[i], NULL, 16);
		      offset+=4;
		      time_stamp_2 = strtol(time_stamp_char[i], NULL, 16);
		      printf("	%ld \t", time_stamp_2);
		      
		      printf(" = %ld \n", time_stamp_2-time_stamp_1);

		      if( time_stamp_1 > last_time_stamp) {
			      
			      last_time_stamp = time_stamp_2;
			      state_time = time_stamp_2 - time_stamp_1;
			  
			      if(state_time>0){
					time(&rawtime);
					timeinfo = localtime(&rawtime);
					//2014 01 26 11 17 15
					strftime (buffer,80,"%G%m%d%H%M%S",timeinfo);	
					printf("%d - %d - 0x%04X:\t", j, i, offset);
					//printf("%s \t%ld\t %d\t %ld\t %ld\t %ld\n", buffer, 0, 0, time_stamp_1, time_stamp_2, state_time);
					fprintf(log_state_time, "%s,%ld,%d,%ld\n", buffer, state_num_2, 0, state_time);
					fflush(log_state_time);
			      }
		      }
			 
		      i++;
		      
		}
		
	//	sleep(10);
	//}
	
		
	
	fclose(log_state_time);
	
}




void change_parameter(struct debugfs_file * df,  struct options * opt){
	int val_to_set = 0;
	int param_to_set = atoi(opt->change_param);
	
	switch (param_to_set){
	  case 10:
	    param_to_set = 0x16*2;
	    break;
	  case 11:
	    param_to_set = 0x21*2;
	    break;
	  case 12:
	    param_to_set = 0x1F*2;
	    break;
	  case 13:
	    param_to_set = 0x20*2;
	    break;
	  case 14:
	    param_to_set = 0x11*2;
	    break;
	  case 15:
	    param_to_set = 0x12*2;
	    break;
	  case 16:
	    param_to_set = 0x13*2;
	    break;
	  case 17:
	    param_to_set = 0x14*2;
	    break;
	  default:
	    printf("you can use only PRM from 10 to 17\n");
	    return;
	    break;
	}
	
	printf("Insert value for parameter %s : ", opt->change_param);
	scanf("%d", &val_to_set);
	  
	if(val_to_set < 65536)
	{  
		if(!strcmp(opt->active, "1")){
			printf("byte-code '1' \n");
			param_to_set = param_to_set + PARAMETER_ADDR_BYTECODE_1;
		}
		else{
			if(!strcmp(opt->active, "2")){
				printf("byte-code '2' \n");
				param_to_set = param_to_set + PARAMETER_ADDR_BYTECODE_2;
			}
			else{
				printf("bytecode must be 1 or 2\n");
				return;
			}
		}
		//printf("write to address %x \n",param_to_set);
		shmWrite16(df, B43_SHM_SHARED, param_to_set, val_to_set);
	}
	printf("Insert value successful\n");
}
*/