
#include "libb43.h"
#include "hex2int.h"
#include "dataParser.h"
#include "vars.h"


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





uint16_t read16(struct debugfs_file * df, int reg){

	/* """Do a 16bit MMIO read""" */
	char buffer[256];
	uint16_t ret=0;
	
	rewind(df->f_mmio16read);
	
	fprintf(df->f_mmio16read, "0x%X",reg);
	
	fflush(df->f_mmio16read);
	
	rewind(df->f_mmio16read);
	
	fscanf(df->f_mmio16read, "%s", buffer);
	
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
	fprintf (df->f_mmio16write, "0x%X 0x%X 0x%X", reg, mask,set);
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

void getTSFRegs(struct debugfs_file * df, uint64_t * tsf){
	uint64_t tmp;
	uint16_t v0, v1, v2, v3;
        uint16_t test1, test2, test3;
	do {
                        v3 = read16(df, B43_MMIO_TSF_3);
                        v2 = read16(df, B43_MMIO_TSF_2);
                        v1 = read16(df, B43_MMIO_TSF_1);
                        v0 = read16(df, B43_MMIO_TSF_0);
 
                        test3 = read16(df, B43_MMIO_TSF_3);
                        test2 = read16(df, B43_MMIO_TSF_2);
                        test1 = read16(df, B43_MMIO_TSF_1);
        } while (v3 != test3 || v2 != test2 || v1 != test1);
        *tsf = v3;
        *tsf <<= 48;
        tmp = v2;
        tmp <<= 32;
        *tsf |= tmp;
        tmp = v1;
        tmp <<= 16;
        *tsf |= tmp;
        *tsf |= v0;
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


