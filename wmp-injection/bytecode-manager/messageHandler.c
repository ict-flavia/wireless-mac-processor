/* HANDLE Bytecode Encapsulated in XML */

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netinet/tcp.h>
#include "libb43.h"
#include "vars.h"
#include "messageHandler.h"


#include <unistd.h>
#include <pwd.h>


int xmlHandler(char * message,struct xml_node* xml_elements){

	int i=0;
	int delimiter=0;
	char tag_content[MAX_VAL_SIZE]="";
	char tag[MAX_TAG_SIZE]="";
	int pos=0;

	for(i=0;i <= strlen(message);i++){

		if (message[i]=='<' && message[i+1]!='/'){
			sprintf(xml_elements[pos].id,"%s","");
			sprintf(xml_elements[pos].value,"%s","");

			delimiter=1;
			continue;
		}
		if (message[i]=='>' && delimiter==1){  // tag aperto
			sprintf(tag,"%s",tag);
			sprintf(xml_elements[pos].id,"%s",tag);


			i++;
			
			sprintf(tag_content,"%s","");

			while(message[i]!='<'){
				
				sprintf(tag_content,"%s%c",tag_content,message[i]);
				i++;	
			}
			i--;

			sprintf(xml_elements[pos].value,"%s",tag_content);	
			delimiter=0;
			pos++;
			sprintf(tag,"%s","");
		}

		if (delimiter==1){
			sprintf(tag,"%s%c",tag,message[i]);
		}

	}
	return pos;
}

int isCommand(struct xml_node* xml_data,int num_of_tags){

	int ret = 0;
	int i;
	for (i=0;i<num_of_tags;i++){
		if(!strcmp(xml_data[i].id,"Command")){
			ret = 1;
			break;
		}
	}
	return ret;
}

int isBytecode(struct xml_node* xml_data,int num_of_tags){
	int ret = 0;
	int i;
	for (i=0;i<num_of_tags;i++){
		if(!strcmp(xml_data[i].id,"FileName")){
			ret = 1;
			break;
		}
	}
	return ret;
}


void getFilename(struct xml_node* xml_data,int num_of_tags,char *filename){

	int i,pos;
	char tmp_filename[256];
	for (i=0;i<num_of_tags;i++){
		if(!strcmp(xml_data[i].id,"FileName")){
			sprintf(tmp_filename,"%s",xml_data[i].value);
			break;
		}
	}
	pos=0;
	for (i=0;i<strlen(tmp_filename);i++){

	      if ( tmp_filename[i]>=0x21 && tmp_filename[i]<=0x7E ){ // trim all printable chars
	      filename[pos]=tmp_filename[i];
	      pos++; 
	    }
	}
	filename[pos]='\0';
}

void getBytecode(struct xml_node* xml_data,int num_of_tags,char *bytecode){
	int i;
	for (i=0;i<num_of_tags;i++){
		if(!strcmp(xml_data[i].id,"FileContent")){
			sprintf(bytecode,"%s",xml_data[i].value);
			break;
		}
	}
}

int getCommand(struct xml_node* xml_data,int num_of_tags,char *command){
	int i,pos;
	char tmp_command[1024];
	for (i=0;i<num_of_tags;i++){
		if(!strcmp(xml_data[i].id,"Command")){
			sprintf(tmp_command,"%s",xml_data[i].value);
			break;
		}
	}
	pos=0;
	/*trim all printable values and spaces*/
	for (i=0;i<strlen(tmp_command);i++){

	      if ( tmp_command[i]>=0x20 && tmp_command[i]<=0x7E ){ // trim all printable chars
	      command[pos]=tmp_command[i];
	      pos++; 
	    }
	}
	command[pos]='\0';
/* DEBUG */
	
	int argcCommand=0;
	for (i=0;i<strlen(command);i++){	
		if (command[i]==0x20)
			argcCommand++;
	}
// 	printf(" ************************* DEBUG ************************ \n");
// 	printf("command = %s \n", command);
// 	printf("argcCommand = %u \n", argcCommand);
	return argcCommand;
}

void saveBytecode(char *filename, char* bytecode){
	printf("-----------------\n");
	printf("save file  bytecode : %s\n",filename);
	printf("-----------------\n");
	FILE *f =fopen(filename,"w");
	fprintf(f,"%s",bytecode);
	fflush(f);
	fclose(f);
}

void executeCommand(char *command, char *res_message, struct debugfs_file *df){
	int i,pos;
	char  l_option[4]="";
        char  m_option[128]="";
        char  a_option[4]="";
	char  v_option[4]="";
	char  f_option[128]="";
	char  d_option[128]="";


	char res_options[256]="";


	
	printf("command=%s\n",command);
	
	//sprintf(res_message,"");
	//struct debugfs_file local_df;
        struct options server_options;
	init_options(&server_options);
	for (i=0;i<strlen(command);i++){
	   if (command[i]=='-'){
	      i++;
	      char opt=command[i];
	      i++;
	         switch(opt){
/* '-l' option*/
	           case 'l':
		     pos=0;
		     i++;
	             while (command[i]!=0x20){
			l_option[pos]=command[i];
			pos++;
			i++;
		     }
		     l_option[pos]='\0';			

		     // fill server_option fields for injection
		     server_options.load=l_option;
	             sprintf(res_options,"%s|%c=OK",res_options,opt);
	             continue;
/* '-m' option*/
		   case 'm':

		     pos=0;
		     i++;
	             while (command[i]!=0x20){
			m_option[pos]=command[i];
			pos++;
			i++;
		     }
		     m_option[pos]='\0';
		     char path[256]="";
                     //fill server_options field for injection
		     //printf("\nm_option : %s ,tmp_m_option %s \n",m_option,tmp_m_option);
		    
		    struct passwd *pw = getpwuid(getuid());
		    const char *homedir = pw->pw_dir;
		    
		    //printf("homedir : %s\n",homedir);
		     sprintf(path,"%s/%s%s",homedir,CACHE_PATH_FILE,m_option);
		     server_options.name_file=path;
		   
		     sprintf(res_options,"%s|%c=OK",res_options,opt);
		     continue;
		     
/* '-a' option*/
		   case 'a':

		     pos=0;
		     i++;
	             while (command[i]!=0x20){
			a_option[pos]=command[i];
			pos++;
			i++;
		     }
		     a_option[pos]='\0';
		     printf("option value=%s\n",a_option);

			/** TODO: get a response of ACTIVATION */

		     server_options.active=a_option;

	             sprintf(res_options,"%s|%c=OK",res_options,opt);
		     continue;

/* '-v' option*/
		   case 'v':
			/* IN THIS CASE IGNORE NEXT PART  and activate a flag*/
			server_options.view=1;
			sprintf(res_options,"%s|%c=OK",res_options,opt);
			continue;

/* '-f' option*/
		   case 'f':
			pos=0;
			i++;
			while (command[i]!=0x20){
				f_option[pos]=command[i];
				pos++;
				i++;
			}
			f_option[pos]='\0';
			server_options.calculation=f_option;
			/** MANAGE VALUE 'f' GET BY CLIENT */
			//sprintf(res_options,"");
			printf("f_option = %s \n",f_option);
			//sprintf(res_options,"%s|%c=OK",res_options,opt);	             
			sprintf(res_options,"|%c=OK",opt);	             
			continue;


/* '-d' option*/

		   case 'd':
		     pos=0;
		     i++;
	             while (command[i]!=0x20){
			d_option[pos]=command[i];
			pos++;
			i++;
		     }
		     f_option[pos]='\0';

		     server_options.delay=d_option;

		     /** MANAGE VALUE 'd' GET BY CLIENT */

		     printf("d_option = %s \n",d_option);
		     setDelay(df, &server_options);
	             sprintf(res_options,"%s|%c=OK",res_options,opt);

		     continue;


		}
		i++;
	   }

	}
	if (strcmp(l_option,"") && strcmp(m_option,"")){
		printf("server_options.load = %s \n",server_options.load);
		printf("server_options.name_file = %s \n",server_options.name_file);
		FILE *f;
		if (f = fopen(server_options.name_file, "r")){
			fclose(f);
			parser(df, &server_options);
		}else{
			sprintf(res_options,"no_file_in_cache");
		}
	}

	if (strcmp(a_option,"")){
		printf("server_options.active = %s \n",server_options.active);
		activeBytecode(df, &server_options);
	}

	if(server_options.view){
				char viewBytecode[1024]="";
				viewActiveBytecode(df,viewBytecode);
				//printf("viewBytecode : %s",viewBytecode);
				sprintf(res_options,"%s%s",res_options,viewBytecode);
	  
	}

	if (strcmp(f_option,"")){
		int timestamp = calculateDelay(df, &server_options);
		//printf(" %s\n",res_options);
		sprintf(res_options,"%s\n",res_options);
		sprintf(res_options,"%s-------------------------------------\n",res_options);
		sprintf(res_options,"%sCalculation value of activation delay\n",res_options);
		sprintf(res_options,"%stime stamp : %u\n",res_options, timestamp);
		sprintf(res_options,"%s-------------------------------------\n",res_options);
		sprintf(res_options,"%s",res_options);

	}

	
	//printf("res_options : %s\n", res_options);
	sprintf(res_message, "%s", res_options);
	//printf("res_message : %s\n", res_message);
}




