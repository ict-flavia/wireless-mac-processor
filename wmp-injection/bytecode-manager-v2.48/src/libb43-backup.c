#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>
#include "libb43.h"
#include "hex2int.h"
#include <time.h>       /* time_t, struct tm, time, localtime, strftime */


void init_file(struct debugfs_file * df){

      char debugfs_path[256]="";
      char path[256]="";
      __debugfs_find(debugfs_path);

	sprintf(path,"%s%s",debugfs_path,"/mmio32read");
	df->f_mmio32read=fopen(path, "r+");

	sprintf(path,"%s%s",debugfs_path,"/mmio32write");
	df->f_mmio32write=fopen(path, "w");

	sprintf(path,"%s%s",debugfs_path,"/mmio16read");
	df->f_mmio16read=fopen(path, "r+");

	sprintf(path,"%s%s",debugfs_path,"/mmio16write");
	df->f_mmio16write=fopen(path, "w");

	sprintf(path,"%s%s",debugfs_path,"/shm16read");
	df->f_shm16read=fopen(path, "r+");
	
	sprintf(path,"%s%s",debugfs_path,"/shm16write");
	df->f_shm16write=fopen(path, "w");
	
	sprintf(path,"%s%s",debugfs_path,"/shm32read");
	df->f_shm32read=fopen(path, "r+");
	
	sprintf(path,"%s%s",debugfs_path,"/shm32write");
	df->f_shm32write=fopen(path, "w");
}

void close_file( struct debugfs_file * df){
  fclose(df->f_shm32read); 
  fclose(df->f_shm32write); 
  fclose(df->f_shm16read); 
  fclose(df->f_shm16write);
  fclose(df->f_mmio16read);
  fclose(df->f_mmio16write);
  fclose(df->f_mmio32read);
  fclose(df->f_mmio32write);
}





int read16(struct debugfs_file * df, int reg){

	/* """Do a 16bit MMIO read""" */
	char buffer[256];
	unsigned int ret=0;
	
	rewind (df->f_mmio16read);
	fprintf (df->f_mmio16read, "0x%X",reg);
	fflush(df->f_mmio16read);
	rewind (df->f_mmio16read);
	fscanf (df->f_mmio16read, "%s", buffer);
	ret=htoi(buffer);
	
	return ret;
}




void maskSet16(struct debugfs_file * df, int reg, int mask, int set){
	/* Do a 16bit MMIO mask-and-set operation */
	//printf("set = 0x%04X \t reg=%d\n",set,reg);
	mask &= 0xFFFF;
	set &= 0xFFFF;
	//printf("set & 0xFFFF = 0x%04X\n",set);

	rewind (df->f_mmio16write);
	fprintf (df->f_mmio16write, "0x%X 0x%X 0x%X",reg,mask,set);
	fflush(df->f_mmio16write);
}
void write16(struct debugfs_file * df, int reg, int value){
	/* Do a 16bit MMIO write */
	//printf("value = 0x%04X\n",value);
	maskSet16(df,reg, 0, value);

}	




void maskSet32(struct debugfs_file * df, int reg, int mask, int set){
	/* Do a 32bit MMIO mask-and-set operation */
	//printf("reg : 0x%08X, mask : 0x%08X, set : 0x%08X\n",reg,mask,set);
	mask &= 0xFFFFFFFF;
	set &= 0xFFFFFFFF;
	//printf("reg : 0x%08X, mask : 0x%08X, set : 0x%08X\n",reg,mask,set);
	
	rewind (df->f_mmio32write);
	fprintf (df->f_mmio32write, "0x%X 0x%X 0x%X",reg,mask,set);
	fflush(df->f_mmio32write);
	
}
void write32(struct debugfs_file * df, int reg, int value){
	/* Do a 16bit MMIO write */
	//printf("value = 0x%04X\n",value);
	maskSet32(df,reg, 0, value);

}	





void shmMaskSet16(struct debugfs_file * df, int routing, int offset, int mask, int set){
	mask &= 0xFFFF;
	set &= 0xFFFF;
	rewind (df->f_shm16write);
	fprintf (df->f_shm16write, "0x%X 0x%X 0x%X 0x%X",routing, offset,mask,set);
	fflush(df->f_shm16write);
}
void shmWrite16(struct debugfs_file * df, int routing, int offset, int value){
	/*"""Do a 16bit SHM write"""*/
	//printf("shmWrite16 --- value = %X\n",value);
	shmMaskSet16(df,routing,offset,0,value);
}

void shmRead16_char(struct debugfs_file * df, int routing, int offset, char * buffer){
	rewind (df->f_shm16read);
	fprintf (df->f_shm16read, "0x%X 0x%X",routing,offset);
	fflush(df->f_shm16read);
	rewind (df->f_shm16read);
	fscanf (df->f_shm16read, "%s", buffer);
}

unsigned int shmRead16(struct debugfs_file * df, int routing, int offset ){
	char buffer[256];
	unsigned int int_buffer=0;
	
	rewind (df->f_shm16read);
	fprintf (df->f_shm16read, "0x%X 0x%X",routing,offset);
	fflush(df->f_shm16read);
	rewind (df->f_shm16read);
	fscanf (df->f_shm16read, "%s", buffer);
	
	
	//int_buffer = *((int *)buffer);
	//printf("buffer=%s \t int_buffer = %X\n",buffer,int_buffer);
	int_buffer=htoi(buffer);
	
	//printf("buffer=%s \t int_buffer = %X\n",buffer,int_buffer);
	return int_buffer;
}

void shmRead32(struct debugfs_file * df, int routing, int offset, char * buffer){
	rewind (df->f_shm32read);
	fprintf (df->f_shm32read, "0x%X 0x%X",routing,offset);
	fflush(df->f_shm32read);
	rewind (df->f_shm32read);
	fscanf (df->f_shm32read, "%s", buffer);
}

unsigned int shmRead32_int(struct debugfs_file * df, int routing, int offset){
	unsigned int buffer_int=0;
	char buffer[256];
	
	rewind (df->f_shm32read);
	fprintf (df->f_shm32read, "0x%X 0x%X",routing,offset);
	fflush(df->f_shm32read);

	rewind (df->f_shm32read);
	fscanf (df->f_shm32read, "%s", buffer);
	
	buffer_int=htoi(buffer);
	//printf("buffer=%s \t int_buffer = %X\n",buffer,buffer_int);
	return buffer_int;
}


void shmWrite32(struct debugfs_file * df, int routing, int offset, int value){
/* Do a 32bit SHM write */
	shmMaskSet32(df, routing, offset, 0, value);
}

void shmMaskSet32(struct debugfs_file * df, int routing, int offset, int mask, int set){
	/* Do a 32bit SHM mask-and-set operation */
	mask &=0xFFFFFFFF;
	set &=0xFFFFFFFF;
	rewind (df->f_shm32write);
	fprintf (df->f_shm32write, "0x%X 0x%X 0x%X 0x%X",routing, offset, mask, set);
	fflush(df->f_shm32write);
}

void __debugfs_find(char *path){
	FILE * mtab;
	char * ret;
	char * tmp_path="/sys/kernel/debug/b43";
	DIR *dp;
	struct dirent *ep;
	dp = opendir (tmp_path);
	
	char * phy="";
	
	if (dp != NULL) {
		while (ep = readdir (dp)){
			char dev[3];
			memcpy(dev, &ep->d_name[0], 3 );
			dev[3] = '\0';
			if (!strcmp(dev,"phy")){
				phy=ep->d_name;
				break;
			}
		}
 		sprintf( path, "%s/%s",tmp_path,phy );
		(void) closedir (dp);
		
	}
	else{
		perror ("Couldn't open the directory");
		exit(1);
	}
}

void shmSharedRead(struct debugfs_file * df){
  
  char * ret="";
   
  char buffer[256]="";
  char tmp_buff[256]="";  
  int offset;
  printf("Shared memory:\n");
  for (offset=0; offset < 4096; offset+=4){
  //for (offset=0; offset < 512; offset+=4){

    //unsigned int buffer_int = shmRead32_int(df, B43_SHM_SHARED, offset);

    if (offset%16==0){
      printf("\n");
      printf("0x%04X:\t", offset);
    }  

    shmRead32( df, B43_SHM_SHARED, offset, buffer);
    
    sprintf(tmp_buff,"%c%c%c%c", buffer[8], buffer[9],buffer[6],buffer[7]);
    printf("%s ", tmp_buff);

    sprintf(tmp_buff,"%c%c%c%c", buffer[4], buffer[5],buffer[2],buffer[3]);
    printf("%s ", tmp_buff);

  }

  printf("\n");

}


void getGprs(struct debugfs_file * df){
	/* Returns an array of 64 ints. One for each General Purpose register. */
	unsigned int reg=0;
	int i=0;
	printf("General purpose registers:\n");

	for (i=0;i<64;i++){
		reg = shmRead16(df,B43_SHM_REGS, i);
		printf("r%02u: %04X  ",i,reg);
		if ((i-3)%4==0)
			printf("\n");
	}
}

void getLinkRegs(struct debugfs_file * df){
	unsigned int reg=0;
	int i=0;
	int tmp_val=0;
	printf("Link registers:\n");
	for (i=0;i<4;i++){
		reg = read16(df, 0x4D0 + (i * 2));
		printf("lr%u: %04X  ",i,reg);
		
	}
	printf("\n");
}
void getOffsetRegs(struct debugfs_file * df){
/*"""Returns an array of 7 ints. One for each Offset Register."""*/
	unsigned int reg=0;
	int i;
	printf("Offset registers:\n");
	for (i=0;i<7;i++){
		reg = read16(df, 0x4C0 + (i * 2));
		printf("off%u: %04X  ",i,reg);
		if ((i-3)%4==0)
		  printf("\n");
	}
	printf("\n");

}


void shmReadStateTime(struct debugfs_file * df,  char * file_name){
  
 	char buffer[80];
	char time_stamp_char[128][32];  
	char state_num_char[128][32];
	char exit_transition_char[128][32];
	int offset;
	int enable_store=0;
	long int time_stamp=1;  
	long int state_num=0;
	long int state_time=0;
	long int exit_transition=0;
	long int last_time_stamp=0;
  
	time_t rawtime;
	struct tm * timeinfo;
  	int i,j;

	FILE * log_state_time;
	log_state_time = fopen(file_name, "w+");
	
	//printf("name file %s\n",file_name);
	
	for(j=0; j<300; j++){
		printf("%d\n", j);
		  
		#define REGION_DEBUG_START	3340	
		#define REGION_DEBUG_STOP 	4052
		i=0;
		for (offset=REGION_DEBUG_START; offset < REGION_DEBUG_STOP; offset+=4){
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(state_num_char[i],"%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9]);
		      //printf("%s ", state_num_char);
		      sprintf(exit_transition_char[i],"%c%c",buffer[4],buffer[5]);
		      //printf("%s ", exit_transition_char);
		      
		      offset+=4;
		      
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(time_stamp_char[i],"%c%c%c%c%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9],buffer[2],buffer[3],buffer[4],buffer[5]);
		      //printf("%s - %ld \n", time_stamp_char[i], strtol(time_stamp_char[i], NULL, 16));
		      
		      i++;
		}
		i=0;
		for (offset=REGION_DEBUG_START; offset < REGION_DEBUG_STOP; offset+=4){    
		      //printf("\n");
		      //printf("%d - 0x%04X:\t", i, offset);
		  
		      state_num = strtol(state_num_char[i], NULL, 16);
		      //printf("%ld \t", state_num);

		      exit_transition = strtol(exit_transition_char[i], NULL, 16);
		      //printf("%ld \t", exit_transition);

		      offset+=4;

		      time_stamp = strtol(time_stamp_char[i], NULL, 16);
		      //printf("%ld \t\n", time_stamp);
		      
		      if (offset > (REGION_DEBUG_START+4) && enable_store ){
			  state_time = time_stamp - last_time_stamp;
			  if( state_time > 0) {
			      printf("%d - %d - 0x%04X:\t", j, i, offset);
		  
			      //printf("%ld \t", state_time);
			      last_time_stamp = time_stamp;
			      
			      time(&rawtime);
			      timeinfo = localtime(&rawtime);
			      //2014 01 26 11 17 15
			      strftime (buffer,80,"%G%m%d%H%M%S",timeinfo);	
			      printf("%s \t%ld\t %ld\t %ld\t %ld\n", buffer, state_num, exit_transition, time_stamp, state_time);
			      fprintf(log_state_time, "%s,%ld,%ld,%ld\n", buffer, state_num, exit_transition, state_time);
			      fflush(log_state_time);
			  }
			  else
			    enable_store = 0;
		      }      
		      else {
			 if(last_time_stamp < time_stamp){
			   enable_store = 1;
			   last_time_stamp = time_stamp;
			 }
			 else{
			   enable_store = 0;
			   last_time_stamp = time_stamp;
			 }
		      }
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
	log_state_time = fopen(file_name, "w+");
	
	//printf("inside name file %s\n",file_name);


	#define REGION_DEBUG_START_1	3408	
	#define REGION_DEBUG_STOP_1 	3936

	
	for(j=0; j<30; j++){
		printf("%d\n", j);
		  
		i=0;
		for (offset=REGION_DEBUG_START_1; offset < REGION_DEBUG_STOP_1; offset+=4){
		      
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(time_stamp_char[i],"%c%c%c%c%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9],buffer[2],buffer[3],buffer[4],buffer[5]);
		      //printf("%s - %ld \n", time_stamp_char[i], strtol(time_stamp_char[i], NULL, 16));      
		      offset+=4;
		      
		      shmRead32( df, B43_SHM_SHARED, offset, buffer);
		      sprintf(state_num_char[i],"%c%c%c%c",buffer[6],buffer[7],buffer[8],buffer[9]);
		      //printf("%s - %ld\t", state_num_char[i], strtol(state_num_char[i], NULL, 16));
		      //sprintf(exit_transition_char[i],"%c%c",buffer[4],buffer[5]);
		      //printf("%s ", exit_transition_char);
		      		      
		      i++;
		}
		
		i=0;
		for (offset=REGION_DEBUG_START_1; offset < REGION_DEBUG_STOP_1; offset+=4){    
		      //printf("\n");
		      //printf("%d - 0x%04X:\t", i, offset);
		  
		      state_num_1 = strtol(state_num_char[i], NULL, 16);
		      //exit_transition = strtol(exit_transition_char[i], NULL, 16);
		      //printf("%ld \t", exit_transition);
		      offset+=4;
		      time_stamp_1 = strtol(time_stamp_char[i], NULL, 16);
		      
		      offset+=4;
		      i++;

		      state_num_2 = strtol(state_num_char[i], NULL, 16);
		      //exit_transition = strtol(exit_transition_char[i], NULL, 16);
		      //printf("%ld \t", exit_transition);
		      offset+=4;
		      time_stamp_2 = strtol(time_stamp_char[i], NULL, 16);

/*		      if(state_num_1 !=0){
				printf("%ld \t",last_time_stamp);
				printf("%ld \t", state_num_1);
				printf("%ld \t", time_stamp_1);
				printf("%ld \t", state_num_2);
				printf("%ld \t\n", time_stamp_2);
		      }
*/
		      if( time_stamp_1 > last_time_stamp) {
			      
			      last_time_stamp = time_stamp_1;
			      state_time = time_stamp_2 - time_stamp_1;
			  
			      if(state_time>0){
					time(&rawtime);
					timeinfo = localtime(&rawtime);
					//2014 01 26 11 17 15
					strftime (buffer,80,"%G%m%d%H%M%S",timeinfo);	
					printf("%d - %d - 0x%04X:\t", j, i, offset);
					printf("%s \t%ld\t %d\t %ld\t %ld\t %ld\n", buffer, state_num_2, 0, time_stamp_1, time_stamp_2, state_time);
					fprintf(log_state_time, "%s,%ld,%d,%ld\n", buffer, state_num_2, 0, state_time);
					fflush(log_state_time);
			      }
		      }
			 
		      i++;
		      
		}
		
		sleep(10);
	}
	
		
	
	fclose(log_state_time);
	
}



void getRaw(struct debugfs_file * df){

}
void getPc(struct debugfs_file * df){

}


void ucodeStop(struct debugfs_file * df){
  //Unconditionally stop the microcode PSM
  
  maskSet32(df, B43_MMIO_MACCTL, ~B43_MACCTL_PSM_RUN, 0);
  
  
}
void ucodeStart(struct debugfs_file * df){
  /*	Unconditionally start the microcode PSM. This will restart the
	microcode on the current PC. It will not jump to 0. Warning: This will
	unconditionally restart the PSM and ignore any driver-state!
  */
  maskSet32(df, B43_MMIO_MACCTL, ~0, B43_MACCTL_PSM_RUN);
  
}


