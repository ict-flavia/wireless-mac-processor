/****************
* bytecode-manager.c
*****************/



#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netinet/tcp.h>
#include <time.h>       /* time_t, struct tm, time, localtime, strftime */


#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/ioctl.h>

#include <pwd.h>
#include <getopt.h>

#include "vars.h"
#include "libb43.h"
#include "bytecode-manager.h"
#include "HandleTCP.h"
#include "dataParser.h"
#include "messageHandler.h"
#include "auto-bytecode.h"
#include "bytecode-work.h"



#define RCVBUFSIZE 1500
#define MAX_MESSAGE_SIZE 8192
#define MAXPENDING 5    /* Maximum outstanding connection requests */




int main(int argc, char * argv[])
{
 

	struct options current_options; 
	char buffer[256]="";
	char *buff_ptr;
	buff_ptr = buffer;
	char message[MAX_MESSAGE_SIZE];
	int status_create_message = 0;
	int send_status = 0;
	
	struct debugfs_file df;
	
	//printf("%s",STARTUP_LOGO);
	
	//printf("%s\n\n",argv[0]);
	parseArgs(argc, argv, &current_options);
		
	switch(current_options.OP_MODE){
		
		// OFFLINE MODE
		case 0: 
			//printf("Current work mode : \"local\"\n");	
			if(current_options.enable_autobytecode==1){
			  printf("Auto-Bytecode execution\n");
			  auto_bytecode(&current_options);
			  break;
			}
			
			//init broadcom interface
			init_file(&df); // da far fare solo se si è un modalità OFFLINE o Server
			
			
			if (strcmp(current_options.change_param,""))
			{
			  printf("Change bytecode parameter\n");
			  change_parameter(&df, &current_options);
			  break;
			}
			
			
			if(strcmp(current_options.reset,"") ){
				printf("Reset control register\n");
				resetControl(&df);
				printf("Reset control register success\n");
				break;
			}

			
			if(!strcmp(current_options.reg_share,"1")){
				getLinkRegs(&df);
				getOffsetRegs(&df);
				getGprs(&df);
				break;
			}
			
			
			/*GET INTERFACE NAME*/
			if(!strcmp(current_options.get_interface_name,"1")){
				//printf("\n\n");
				get_interface_name();
				break;
			}
	
			/* DUMP SHM */
			if(!strcmp(current_options.reg_share,"2")){
				printf("SHM dump %s\n\n",current_options.reg_share);
				shmSharedRead(&df);
				break;
			}
	
			/* DUMP REGISTERS and SHM */
			if(!strcmp(current_options.reg_share,"3")){
				printf("SHM and REG dump %s\n\n",current_options.reg_share);
				//funzione per leggere dai registri
				getLinkRegs(&df);
				getOffsetRegs(&df);
				getGprs(&df);
				printf("\n\n");
				shmSharedRead(&df);
				break;
			}
			
			/* DUMP TSF */
			if(!strcmp(current_options.reg_share,"4")){
				uint64_t tsf;
				getTSFRegs(&df, &tsf);
				printf("TSF registers dump %f\n",(double)tsf);
				break;
			}

			/* READ SHM ZIGBEE RX*/
			if(strcmp(current_options.zigbee_rx,"")){
				printf("SHM read zigbee rx \n");
				shmReadZigbeeRx(&df, current_options.zigbee_rx);
				break;
			}
			
			/* READ SLOT TIME INFORMATION*/
			if(strcmp(current_options.slot_time_value,"")){
				printf("Read slot time value \n");
				readSlotTimeValue(&df, current_options.slot_time_value);
				break;
			}
			
			/* READ SHM STATE TIME*/
			if(strcmp(current_options.time_state_measure,"")){
				printf("SHM read state time \n");
				shmReadStateTime(&df, current_options.time_state_measure);
				break;
			}
			
			
			if(strcmp(current_options.auto_active,"")){
				autoActiveBytecode(&df, &current_options);
		
			}
			/* READ SHM ACTIVATION TIME*/
			// in this moment inside autoActiveBytecode
			/* 
			 * if(strcmp(current_options.time_activate_measure,"")){
				printf("SHM read activation time \n");
				shmReadActivateTime(&df, current_options.time_activate_measure);
				break;
			}
			*/
	
			/* Write frame into template ram */
			if(strcmp(current_options.write_frame,"")){
				printf("Write frame into template ram\n\n");
				write_tamplate_frame(&df);
				printf("\n\n");
				break;
			}
			
			
			/* Write beacon into template ram */
			if(strcmp(current_options.write_beacon_frame,"")){
				printf("Write beacon into template ram\n\n");
				write_beacon_frame(&df);
				printf("\n\n");
				break;
			}

						

			/* Managed other options */
			if(strcmp(current_options.other_option,"")){
				printf("Managed other option\n\n");
				managed_other_information(&df);
				printf("\n\n");
				break;
			}
			
			if(strcmp(current_options.state_debug,"")){
				printf("Selected state-debug\n");
				setControlDebug(&df, &current_options);
				break;
			}
			
			if(strcmp(current_options.load,"")) {
							
				if(strcmp(current_options.change_param_file,"")){
				    load_params(&df, &current_options);
				}
				else{
				    parser(&df, &current_options);
				}
			  
			}
			
			if(strcmp(current_options.active,"")){
				activeBytecode(&df, &current_options);
		
			}

			if(current_options.view){
				printf("Selected view\n");
				char viewBytecode[1024];
				viewActiveBytecode(&df,viewBytecode);
				printf("%s",viewBytecode);
			}
			
			if(strcmp(current_options.memorydiff,"")){
				viewDiffMemory(&df, &current_options);
			}
				
			if(strcmp(current_options.calculation,"")){
				int time_stamp_to_active = calculateDelay(&df, &current_options);
				printf("-------------------------------------\n");
				printf("Calculation value of activation delay\n");
				printf("time stamp : %u\n", time_stamp_to_active);
				//printf time_stamp_to_active
				//print hex(time_stamp_to_active)
				printf("-------------------------------------\n");
				break;
			}
			
			if(strcmp(current_options.delay,"") ){
				check_association();
				setDelay(&df, &current_options);
				if(strcmp(current_options.time,"")){
					setDelayTimer(&df, &current_options);
					printf("Select delay with timer success\n");
				}
				else{
					printf("Select delay success\n");
				}
				break;
			}
			
			if(strcmp(current_options.time,"") ){
				printf("Set timer activate\n");
				setTimer2(&df, &current_options);
				printf("Set timer activate success\n");
			}
			
			if(strcmp(current_options.get_parameter,"") ){
				char viewParameter[1024];
				getParameterLowerLayer(&df, &current_options, viewParameter);
				printf("%s",viewParameter);
			}

			close_file(&df);

			break;

// CLIENT MODE
		case 1: 
			printf("Current work mode : \"client\"\n");	

			if((strcmp(current_options.give_file,""))){
				forgeMessageBytecode(current_options.give_file,message);
				status_create_message = 1;
			}else{
				status_create_message = forgeMessageCommand(argc,argv,message,&df);
			}
			//printf("status_create_message : %u\n",status_create_message);
			if(status_create_message){
				//printf("message : %s\n",message);
				send_status = TCPClient(current_options.HOST, atoi(current_options.PORT),message);
			}
			//printf("send_status = %u\n", send_status);
			break;

// SERVER MODE
		case 2: 
			printf("Current work mode : \"server\"\n");	

			struct passwd *pw = getpwuid(getuid());
			const char *homedir = pw->pw_dir;
			char cachedir[256];
			//printf("homedir : %s\n",homedir);
			sprintf(cachedir,"%s/%s",homedir,CACHE_PATH_FILE);
			//printf("cachedir : %s\n",cachedir);
			
			if (mkdir(cachedir)==0) {
			    printf("Cache directory not found - created now\n");
			}

			init_file(&df); // da far fare solo se si è un modalità OFFLINE o Server

			printf("Starting bytecode Manager in SERVER mode, listen on port %s\n",current_options.PORT);
			
			int ret = TCPServer(atoi(current_options.PORT),&current_options,&df);

			close_file(&df);
			break;
		default:
			break;
	}
	return 0;
}




void check_association(){
	FILE *fp;
  	int status;
	char iface_wlan[128];
        char command_iwconfig[2048];
        char iwconfig_output[4000];
	fp = popen("iw dev | grep Interface | awk '{print $2}'", "r");
  	if (fp == NULL) {
    		printf("Failed to run command\n" );
  	}	

	fgets(iface_wlan, 128, fp);
        //printf("%s", iface_wlan);
        iface_wlan[strlen(iface_wlan)-1]='\0';
	fclose(fp);
	//sprintf(command_iwconfig,"iwconfig %s | grep 'Access Point' | awk '{print $6}'\0",iface_wlan);
	sprintf(command_iwconfig,"iwconfig %s | grep 'Not-Associated'",iface_wlan);

	fp = popen(command_iwconfig, "r");
	if (fp == NULL) {
    		printf("Failed to run command\n" );
  	}	
	fgets(iwconfig_output, 4000, fp);
        //printf("%s",iwconfig_output);
	if (strcmp(iwconfig_output,"")){
		printf("Interface not associated to an Access Point, stopping...\n");
		exit(1);
	}
        fclose(fp);
}

void usage(void)
{
	printf("%s",usageMenu);
	printf("%s",usageExamples);
}

void init_options(struct options * current_options){


	current_options->phy="";
	current_options->load ="";
	current_options->active ="";
	current_options->auto_active ="";
	current_options->binary ="";
	current_options->time ="";
	current_options->dasmopt ="";
	current_options->dumpShm ="";
	current_options->dumpShmBin ="";
	current_options->name_file ="";
	current_options->delay ="";
	current_options->calculation ="";
	current_options->reset ="";
	current_options->timer_delay ="";
	current_options->view =0;
	current_options->HOST ="";
	current_options->PORT ="";
	current_options->OP_MODE = 0; 

	current_options->give_file = "";
	current_options->nic = "";
	current_options->do_up = "";
	current_options->byte_code = "";
	current_options->state_debug = "";
	current_options->reg_share = "";
	current_options->write_frame = "";
	current_options->write_beacon_frame = "";
	current_options->other_option = "";
	current_options->change_param_file = "";
	current_options->memorydiff = "";
	current_options->time_state_measure = "";
	current_options->time_activate_measure = "";
	current_options->zigbee_rx="";
	current_options->slot_time_value="";
	current_options->change_param="";
	current_options->get_parameter="";
	current_options->get_interface_name="";

	
	
	//autobytecode variable
	current_options->enable_autobytecode = 0;
	
	current_options->output_file_name="";
	current_options->out_file=NULL;
	current_options->input_file_name="";
	current_options->in_file=NULL;
	
	current_options->enable_mac_address=-1;
	//current_options->mac_addr[6];
	current_options->channel=-1; 
	current_options->timeslot=-1;
	current_options->position=-1;
	current_options->enable_timer=-1;
	//current_options->timer[4];
	
}

void parseArgs(int argc, char **argv, struct options * current_options)
{
	static int verbose_flag;
	int option_index = 0;

/*
    h
    w
    o:
    i:
    n:
    m:
    l:
    a:
    t:
    d:
    y:
    f:
    r
    v
    c:
    p:
    g:
    s
    u
    b
    e:
    x:
    '1' 
    '2'
    '3' 
    '4' 
    '5' 
    '6' 
    '7' 
    '8' 
    '9' 
    'i' 
    'o' 
    'ò' 
    'à' 
    'ì' 
    'k' 
*/



	
	static struct option long_option[] = {
	          {"tx-macaddress",		required_argument,	0,	'1' },
		  {"channel",			required_argument,	0,	'2' },
		  {"timeslot",			required_argument,	0,  	'3' },
		  {"position",			required_argument, 	0,  	'4' },
		  {"timer",			required_argument, 	0,  	'5' },
		  {"memory-diff",		required_argument,	0,  	'6' },
		  {"time-state-measure",	required_argument,	0,  	'7' },
		  {"time-activate-measure",	required_argument,	0,  	'8' },
		  {"auto-active",		required_argument,	0,  	'9' },
		  {"input",			required_argument, 	0,  	'i' },
		  {"output",			required_argument, 	0,  	'o' },
		  {"write-reg-mem",		required_argument, 	0,  	'ò' },
		  {"zigbee-rx",			required_argument, 	0,  	'à' },
		  {"read-slot",			required_argument, 	0,  	'ì' },
		  {"modify-parameter",		required_argument, 	0,  	'k' },
		  {"get-parameter",		required_argument, 	0,  	'j' },
		  {"get-interface-name",	no_argument,	 	0,  	'è' },
		  {0,				0,			0,	 0   }
	};
	
	init_options(current_options);
	
	FILE * file;
	int c;
	int function_sesult;
	
	//autobytecode variable
	  unsigned char addr[6];
	    addr[0]=0xFF;
	    addr[1]=0xFF;
	    addr[2]=0xFF;
	    addr[3]=0xFF;
	    addr[4]=0xFF;
	    addr[5]=0xFF;
	  unsigned int timer[4];
	    timer[0]=0;
	    timer[1]=0;
	    timer[2]=0;
	    timer[3]=0;
	  int source_file=0;

	if ( argc == 1){
		usage();
		exit(0);
	}
	while((c = getopt_long(argc, argv, "hwo:i:n:m:l:a:t:d:y:f:rvc:p:g:sube:x:", long_option, &option_index )) != -1) {
	
		switch(c) {
		  
		  case 0:
			//printf("option selected %s\n", long_option[option_index].name);
			//printf("option arg : %s\n", optarg);
			current_options->channel =atoi(optarg);
			break;
	
		  case 'h':
			usage();
			exit(0);
			break;

		  case 'm':
			current_options->name_file = optarg ;
			if(current_options->OP_MODE==0){ 
			  printf("WORKING IN STAND-ALONE\n");
			  if (file = fopen(current_options->name_file, "r")){
				  fclose(file);
			  }	
			  else{
				  fprintf( stderr, "file %s: ", current_options->name_file);
				  perror("");
				  exit(1);
			  }
			}
			break;

		  case 'n':
			current_options->change_param_file = optarg;
			if(current_options->OP_MODE==0){ 
				printf("WORKING IN STAND-ALONE\n");
				if (file = fopen(current_options->change_param_file, "r")){
					fclose(file);
				}	
				else{
					fprintf( stderr, "file %s: ", current_options->change_param_file);
					perror("");
					exit(1);
				}
			}
			
			break;
			
		  case 'z':
			current_options->phy = optarg;
			break;

		  case 'l':
			current_options->load = optarg;
			
			if (  !(!strcmp(current_options->load, "1") ||  !strcmp(current_options->load, "2")) )
			{	
				printf("index must be 1 or 2\n");
				exit(1);
			}
			break;
			
		  case 'a': // activation
			current_options->active=optarg;
			if (  !(!strcmp(current_options->active, "1") ||  !strcmp(current_options->active, "2")) )
			{
				printf("index must be 1 or 2\n");
				exit(1);
			}
			break;
		  case 't':
			current_options->time=optarg;
			int time_control;
			time_control=atoi(current_options->time);
			if ((time_control > 0) && (time_control < 4290))
				printf( "Timed Activation %d\n",time_control);
			else{
				printf( "activation time must be between 0 and 4290 (sec)\n");
				exit(1);
			}
			break;

		  case 'd':
			current_options->delay=optarg;
			unsigned long long int delay_control;
			delay_control=atoi(current_options->delay);
			if ((delay_control > 0) && (delay_control < 4294967296LL))
				printf( "Delayed Activation of %s usec\n",current_options->delay);
			else{
				printf( "activation time must be between 0 and 4294967296 (usec)\n");
				exit(1);
			}
			break;
		  case 'y':
			current_options->timer_delay=optarg;
			printf("Selected timer_delay\n");
			break;
		  case 'f':
			current_options->calculation=optarg;
			printf("Selected find absolute time\n");
			break;
		  
		  case 'r':
			current_options->reset="1";
			printf("Selected reset\n");
			break;
		  
		  case 'v':
			//printf("Selected view option\n");
			current_options->view=1;
			break;
		  
		  case 'c':
			current_options->HOST = optarg;
			current_options->OP_MODE = 1; /*CLIENT MODE */
			// printf("Selected client mode\n");
			break;
			
		  case 'p':
			current_options->PORT =optarg;
			break;
		  case 'g':
			current_options->give_file = optarg;
			if (file = fopen(current_options->give_file, "r")){
				printf("file %s found \n", current_options->give_file);
				fclose(file);
			}	
			else{
				printf( "file %s not found \n", current_options->give_file);
				exit(1);
			}
			break;
		  case 's':	
			if (optarg != NULL)
				current_options->nic = optarg;
			
			current_options->OP_MODE = 2; 					/*SERVER MODE */
			
			if( !strcmp(current_options->PORT,"") )
			      current_options->PORT="9898";	
			
			//printf("SERVER MODE\n");
			
			break;
		  case 'u': 
			current_options->do_up = "1";
			printf("Selected do_up\n");
			break;
		  case 'e':
			current_options->state_debug = optarg;
			break;
		  case 'x':
			current_options->reg_share = optarg;
			if(!strcmp(current_options->reg_share,"")){
				usage();
				exit(0);
			}
			break;

		  case 'b':
			current_options->write_beacon_frame = "1";
			break;
			
		  case 'w':
			current_options->write_frame = "1";
			break;
			
		  case 'ò':
			current_options->other_option = "1";
			break;
		  
		  case 'k':
			current_options->change_param = optarg;
			break;
		  
		  case 'è':
			current_options->get_interface_name = "1";
			break;
			
// autobytecode-option
		  case '1':
			    current_options->enable_mac_address=1;
			    //sprintf(current_options->.mac_addr,"%s",optarg);
			    function_sesult = sscanf(optarg, "%2hhx:%2hhx:%2hhx:%2hhx:%2hhx:%2hhx",
				    &addr[0], &addr[1], &addr[2], &addr[3], &addr[4], &addr[5]);

			      if (function_sesult == EOF) {
				  fprintf(stderr, "MAC ADDRESS SET: Reached end of input without matching\n");
				  exit(1);
			      } else if (function_sesult < 6) {
				  fprintf(stderr, "MAC ADDRESS SET: Got fewer hex digits than expected\n");
				  exit(1);
			      } else if (function_sesult > 6) {
				  fprintf(stderr, "MAC ADDRESS SET: Got extra characters after input\n");
				  exit(1);
			      }
			      current_options->mac_addr[0]=addr[0];
			      current_options->mac_addr[1]=addr[1];
			      current_options->mac_addr[2]=addr[2];
			      current_options->mac_addr[3]=addr[3];
			      current_options->mac_addr[4]=addr[4];
			      current_options->mac_addr[5]=addr[5];

			      break;
		case '2':
			      current_options->channel = atoi(optarg);
			      if( (current_options->channel>13) | (current_options->channel<1) ){
				fprintf(stderr, "Channel must been a number between 1 and 13\n");
				exit(1);
			      }
			      break;
		case '3':
			      current_options->timeslot = atoi(optarg);
			      break;
		case '4':
			      current_options->position = atoi(optarg);
			      break;
		case '5':
			      current_options->enable_timer=1;
			      //sprintf(current_options->mac_addr,"%s",optarg);
			      function_sesult = sscanf(optarg, "%d-%d-%d-%d",
				      &timer[0], &timer[1], &timer[2], &timer[3]);

				if (function_sesult == EOF) {
				    fprintf(stderr, "TIMER SET: Reached end of input without matching\n");
				    exit(1);
				} else if (function_sesult < 4) {
				    fprintf(stderr, "TIMER SET: Got fewer hex digits than expected\n");
				    exit(1);
				} else if (function_sesult > 4) {
				    fprintf(stderr, "TIMER SET: Got extra characters after input\n");
				    exit(1);
				}
				current_options->timer[0]=timer[0];
				current_options->timer[1]=timer[1];
				current_options->timer[2]=timer[2];
				current_options->timer[3]=timer[3];

				break;
		
		case '6':
			      current_options->memorydiff = optarg;
			      break;

		case '7':
			      current_options->time_state_measure = optarg;
			      printf("input file %s\n", current_options->time_state_measure );
			      break;
		case '8':
			      current_options->time_activate_measure = optarg;
			      printf("input file %s\n", current_options->time_activate_measure );
			      break;
		
		case '9':
			      current_options->auto_active = optarg;
			      printf("input file %s\n", current_options->auto_active );
			      break;
		case 'à':
			      current_options->zigbee_rx = optarg;
			      printf("output file %s\n", current_options->zigbee_rx );
			      break;
		
		case 'ì':
			      current_options->slot_time_value = optarg;
			      printf("output file %s\n", current_options->slot_time_value );
			      break;
		  
		case 'o':
				current_options->output_file_name = optarg;
				source_file++;
				break;
				
				
		case 'i':
				current_options->input_file_name = optarg;
				if (!(current_options->in_file = fopen(current_options->input_file_name, "r")))
				{
				    fprintf(stderr, "input file %s not exist\n",current_options->input_file_name);
				    exit(1);
				}
				source_file++;
				break;
			
		case 'j':	
				current_options->get_parameter = optarg;
				break;
		default:
		       fprintf(stderr, "./bytecode-manager: check the help with option -h\n\n");
		       //usage();
		       exit(1);
		       break;
		}
	}
	
	if( source_file==1 ){
		fprintf(stderr, "You need insert output and input file\n");	    
		exit(0);
	}
	if( source_file==2 ){
		if(strcmp( current_options->output_file_name, current_options->input_file_name )==0){
		  fprintf(stderr, "Input file and output file must been different\n");	    
		  exit(0);
		}
		else{
  		    current_options->out_file = fopen(current_options->output_file_name, "w+");
		    if (current_options->out_file == NULL) {
			fprintf(stderr, "I couldn't open output file %s for writing.\n",current_options->output_file_name);
			exit(0);
		    }
		    current_options->enable_autobytecode=1;
		}
	}  

	
	if (strcmp(current_options->change_param,""))
	{
		if (!strcmp(current_options->active,""))
		{
			printf("modify-parameter option need bytecode slot\n");
			exit(1);
		}
	}
	
	if (strcmp(current_options->HOST,""))
		if (!strcmp(current_options->PORT,""))
			current_options->PORT=DEFAULT_SERVER_PORT;
	
	if (strcmp(current_options->nic,""))
		if (strcmp(current_options->PORT,""))
			printf("Use specific Port : %s", current_options->PORT);	
		else{
			current_options->PORT=DEFAULT_SERVER_PORT;
			printf("Use specific Port : %s", current_options->PORT);
		}
 
}


void forgeMessageBytecode(char * bytecode_path, char * message){
	int fileSize = 0;
	//printf("forge Bytecode\n");

	/* OPEN BYTECODE FILE */
	FILE * pFile=fopen(bytecode_path,"r");
	
	if(pFile == NULL){
		printf("ERROR reading file\n");
		exit(1);

	}

	fseek(pFile, 0, SEEK_END);
	fileSize = ftell(pFile);
	rewind(pFile);
	char *data = (char*) calloc(sizeof(char), fileSize + 20);
	fread(data, 1, fileSize, pFile);
	if(ferror(pFile)){
		printf("ERROR reading file\n");
		exit(1);
	}
	fclose(pFile);
	
	/* ENCAPSULATE BYTECODE IN MESSAGE */
	sprintf(message,"%s%s\n",message,"<Maclet>");
	sprintf(message,"%s%s\n",message,"<FileName>");

	char filename[256];
	//printf("BEFORE=%s\n",bytecode_path);
	trim_filename(bytecode_path,filename);
	//printf("AFTER=%s\n",filename);
	/* DEBUG Actually you must specify absolute pathfile*/

	
	
/*
	int i_path,pos;
	char filename[256];
	if(bytecode_path[0]!='/'){
		perror("v0.1 PLEASE INDICATE ABSOLUTE PATHFILE\n");
		exit(0);
	}

	for (i_path=0;i_path<strlen(bytecode_path);i_path++){

// 		if(bytecode_path[i_path]=='.' && (bytecode_path[i_path+1]=='.' || bytecode_path[i_path+1]=='/')){
// 			sprintf(filename,"%s","");
// 			pos=0;
// 			continue;
// 		}
		if(bytecode_path[i_path]=='/'){

			sprintf(filename,"%s","");
			pos=0;
			continue;
		}
		filename[pos]=bytecode_path[i_path];
		printf("-->\n");
		pos++;
	}
	filename[pos]='\0';

*/

	//printf("\n");
	/* update: use only filename without pathfile*/
	sprintf(message,"%s%s\n",message,filename);
	//sprintf(message,"%s%s\n",message,bytecode_path);
	sprintf(message,"%s%s\n",message,"</FileName>");
	sprintf(message,"%s%s\n",message,"<FileContent>");

	sprintf(message,"%s%s\n",message,data);

	sprintf(message,"%s%s\n",message,"</FileContent>");
	sprintf(message,"%s%s\n",message,"</Maclet>");
	
	
	printf("filename sent=%s\n",filename);
}

int forgeMessageCommand(int argc, char ** argv, char * message, struct debugfs_file * df ){
	int resMsg=0; // flag of result
	int i=0;
	
	sprintf(message,"%s\n","");
	sprintf(message,"%s%s\n",message,"<Maclet>");
	sprintf(message,"%s%s\n",message,"<Command>");


	for (i=1;i< argc; i++) {
		if (!strcmp(argv[i],"-v") || !strcmp(argv[i],"-f")){
			resMsg = 1; // toggle in true;
		}
		if (!strcmp(argv[i],"-c") || !strcmp(argv[i],"-p") || !strcmp(argv[i],"-i") || !strcmp(argv[i],"-s"))
			i++;
		else{
			sprintf(message,"%s%s ",message,argv[i]);
			resMsg = 1;
		}

	}

	sprintf(message,"%s\n",message);
	sprintf(message,"%s%s\n",message,"</Command>");
	sprintf(message,"%s%s\n",message,"</Maclet>");
	return resMsg;
}


int TCPClient(char *servIP, unsigned short servPort, char * message){

	int send_status = 0;
        char recvBuffer[1024]="";
	unsigned int messageLen;      
	int sock;                        /* Socket descriptor */
	struct sockaddr_in servAddr; 	/* server address */

	if ((sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0){
		printf("socket() failed");
		exit(1);
	}

	memset(&servAddr, 0, sizeof(servAddr));     // Zero out structure 
	servAddr.sin_family      = AF_INET;             // Internet address family 
	
	    
	    char * ipbuf;
	    struct hostent *hostentry;
/*	    

		char hostbuf[256]="sta10";
		ret = gethostname(hostbuf,sizeof(hostbuf));
		if(-1 == ret){
		      perror("gethostname");
		      exit(1);
		}
*/
//	      printf("Hostname: %s \n", servIP);

	      hostentry = gethostbyname(servIP);
	      if(NULL == hostentry){
		      perror("gethostbyname");
		      exit(1);
	      }
	      ipbuf = inet_ntoa(*((struct in_addr *)hostentry->h_addr_list[0]));
	      if(NULL == ipbuf){
		      perror("inet_ntoa");
		      exit(1);
	      }

	      //printf("Hostname: %s Host IP: %s\n", servIP, ipbuf);
        
	
	

	servAddr.sin_addr.s_addr = inet_addr(ipbuf); // convert string into an integer HOST address;   // Server IP address 
	servAddr.sin_port        = htons(servPort); // Server port 
	// Establish the connection to the echo server 
	//fprintf(stdout,"TCP Connection to server %s PORT %d\n\n\n",servIP, servPort);

	if ((connect(sock, (struct sockaddr *) &servAddr, sizeof(servAddr))) < 0){
		fprintf(stderr, "TCP connection failed to server %s port %u\n",servIP,servPort);
		perror("connect() failed");
		exit(1);
	}


       send_status = write(sock, message, strlen(message));
       shutdown(sock, SHUT_WR); //GARANTISCE L ESCAPE!
       
       // if enable trust the esecution of the command sented
       //read(sock, recvBuffer, MAX_MESSAGE_SIZE);
       //printf("recvBuffer = %s\n",recvBuffer);
       
       
       close(sock);    /* Close client socket */
       return send_status;
}



int TCPServer(unsigned short servPort, struct options * current_options, struct debugfs_file *df)
{
    int servSock;                    /* Socket descriptor for server */
    int clntSock;                    /* Socket descriptor for client */
    struct sockaddr_in servAddr;     /* Local address */
    struct sockaddr_in clntAddr;     /* Client address */
    unsigned int clntLen;            /* Length of client address data structure */
    char buffer[RCVBUFSIZE];         /* Buffer for echo string */
    int recvMsgSize;                 /* Size of received message */
    char message[MAX_MESSAGE_SIZE]="";
    char server_resp_message[MAX_MESSAGE_SIZE]="";



    /* Create socket for incoming connections */
    if ((servSock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0){
        perror("socket() failed");
	exit(1);
    }
    int so_reuseaddr = 1;
    setsockopt(servSock, SOL_SOCKET, SO_REUSEADDR, &so_reuseaddr, sizeof so_reuseaddr);
    
    /* Construct local address structure */
    memset(&servAddr, 0, sizeof(servAddr));   	 /* Zero out structure */
    servAddr.sin_family = AF_INET;                /* Internet address family */
    /** TODO: (forse) getIPByNIC() */
    servAddr.sin_addr.s_addr = htonl(INADDR_ANY); /* Any incoming interface */

    servAddr.sin_port = htons(servPort);          /* Local port */

    /* Bind to the local address */
    if (bind(servSock, (struct sockaddr *) &servAddr, sizeof(servAddr)) < 0){
        perror("bind() failed");
	exit(1);
    }

    /* Mark the socket so it will listen for incoming connections */
    if (listen(servSock, MAXPENDING) < 0){
        perror("listen() failed");
	exit(1);
    }

    
    /* Set the size of the in-out parameter */
    clntLen = sizeof(clntAddr);
    
    for (;;) /* Run forever */
    {
      
        /* Wait for a client to connect */
        if ((clntSock = accept(servSock, (struct sockaddr *) &clntAddr, &clntLen)) < 0){
	    perror("accept() failed");
	    exit(1);
	}
	else{
	    printf("accept() ok\n");
	}

        /* clntSock is connected to a client! */
        printf("Handling client %s\n", inet_ntoa(clntAddr.sin_addr));
	sprintf(message,"%s","");

	
	/* loop listening  for client command up on the message end*/
	for (;;) {
	    recvMsgSize = read(clntSock, buffer, RCVBUFSIZE);	
	    buffer[recvMsgSize]='\0';
	    if (recvMsgSize==0)
		 break;
	    else 
		 sprintf(message,"%s%s",message,buffer);
	
	    sprintf(buffer,"%s","");
	}
	sprintf(message,"%s%s",message,"\0");

	//insert for separate the send of command with execution of the command
	sleep(1);
	
	
	/* NOW HANDLE RECEIVED MESSAGE */
	struct xml_node xml_elements[10];
	int num_of_tags=xmlHandler(message,xml_elements);

	if (isCommand(xml_elements,num_of_tags)){
		char command[1024];
		printf("BYTECODE IS A COMMAND\n");
		int argcCommand = getCommand(xml_elements,num_of_tags,command);
		//executeCommand(command);
		//sprintf(server_resp_message,"");
		executeCommand(command,server_resp_message,df);
		if (!strcmp(server_resp_message,"")){
			sprintf(server_resp_message,"NO RESPONS COMMAND");
		}

		/* if enable SEND OK MESSAGE TO CLIENT */
		//write(clntSock, server_resp_message, strlen(server_resp_message));
	}

	if (isBytecode(xml_elements,num_of_tags)){
		char filename[256];
		char bytecode[4096];

		sprintf(filename,"%s","");
		sprintf(bytecode,"%s","");

		getFilename(xml_elements,num_of_tags,filename);
		getBytecode(xml_elements,num_of_tags,bytecode);

		/* Replace the correct cache path file to save  bytecodes */
		char tmp_path[256]="";
		
		struct passwd *pw = getpwuid(getuid());
		const char *homedir = pw->pw_dir;
		//printf("homedir : %s\n",homedir);
		//printf("cachedir : %s\n",cachedir);
		sprintf(tmp_path,"%s/%s%s",homedir,CACHE_PATH_FILE,filename);
		
		//printf("tmp_path=%s",tmp_path);
		saveBytecode(tmp_path,bytecode);
		printf("bytecode %s SAVED \n",filename);
		
		/* if enable SEND OK MESSAGE TO CLIENT */
		//char * ok= "OK-FIN";
		//write(clntSock, ok, strlen(ok));
	}

	//insert for separate the send of command with execution of the command
	sleep(2);

    }
    close(clntSock);    // Close client socket

}



void viewActiveBytecode(struct debugfs_file * df,char *return_message){
	char ret_msg[1024]="";
	unsigned int read_wmp_value;
	unsigned int gpr_byte_code_value = shmRead16(df,B43_SHM_REGS, 57);
	
	//printf("gpr_byte_code_value \t =0x%X\n",gpr_byte_code_value);
	//sprintf(ret_msg,"\n--------------------------------------\n");
	//sprintf(ret_msg,"%sWMP INFORMATION\n\n",ret_msg);
	int b1,b2 =1;
	b1 = (gpr_byte_code_value == PARAMETER_ADDR_OFFSET_BYTECODE_1) ? sprintf(ret_msg,"%sCURRENT BYTECODE \t\t = %u\n",ret_msg,1):0;
	b2 = (gpr_byte_code_value == PARAMETER_ADDR_OFFSET_BYTECODE_2) ? sprintf(ret_msg,"%sCURRENT BYTECODE \t\t = %u\n",ret_msg,2):0;
	if (!b1 && !b2)
		sprintf(ret_msg,"%s%s\n",ret_msg,NO_MATCH_ADDR_OFFSET_BYTECODE);
	
	//unsigned int gpr_control_value = shmRead16(df,B43_SHM_REGS, GPR_CONTROL); //55 = GPR CONTROL
	//sprintf(ret_msg,"%sControl Value \t\t\t = 0x%04X \n",ret_msg,gpr_control_value);
	//(gpr_control_value & 0x0004) ? 	sprintf(ret_msg,"%sTimer Active \n",ret_msg):sprintf(ret_msg,"%sTimer Not Active \n",ret_msg);
	//(gpr_control_value & 0x0010) ? 	sprintf(ret_msg,"%sDelay Active \n",ret_msg):sprintf(ret_msg,"%sDelay Not Active \n",ret_msg);
	//sprintf(ret_msg,"%s--------------------------------------\n\n",ret_msg);

	//sprintf(ret_msg,"%s--------------------------------------\n",ret_msg);
	//sprintf(ret_msg,"%sREGISTER AND MEMORY INFORMATION\n\n",ret_msg);
	read_wmp_value = shmRead16(df,B43_SHM_REGS, CUR_CONTENTION_WIN);
	sprintf(ret_msg,"%sCurrent contention windows \t = 0x%04X \n",ret_msg,read_wmp_value);
	read_wmp_value = shmRead16(df,B43_SHM_REGS, MAX_CONTENTION_WIN);
	sprintf(ret_msg,"%sMax contention windows \t\t = 0x%04X \n",ret_msg,read_wmp_value);
	read_wmp_value = shmRead16(df,B43_SHM_REGS, MIN_CONTENTION_WIN);
	sprintf(ret_msg,"%sMin contention windows \t\t = 0x%04X \n",ret_msg,read_wmp_value);
	read_wmp_value = shmRead16(df, B43_SHM_REGS, PROCEDURE_REGISTER_1);
	sprintf(ret_msg,"%sRegister 1 \t\t\t = 0x%04X \n",ret_msg,read_wmp_value);
	read_wmp_value = shmRead16(df, B43_SHM_REGS, PROCEDURE_REGISTER_2);
	sprintf(ret_msg,"%sRegister 2 \t\t\t = 0x%04X \n",ret_msg,read_wmp_value);
	
	read_wmp_value = shmRead32_int(df, B43_SHM_SHARED, PROCEDURE_MEMORY_1_LO);
	sprintf(ret_msg,"%sRegister 3 \t\t\t = 0x%08X \n", ret_msg, read_wmp_value);
	
	read_wmp_value = shmRead32_int(df, B43_SHM_SHARED, PROCEDURE_MEMORY_2_LO);
	sprintf(ret_msg, "%sRegister 4 \t\t\t = 0x%08X \n", ret_msg, read_wmp_value);
	
	read_wmp_value = shmRead32_int(df, B43_SHM_SHARED, PROCEDURE_MEMORY_3_LO);
	sprintf(ret_msg,"%sRegister 5 \t\t\t = 0x%08X \n",ret_msg,read_wmp_value);
	//sprintf(ret_msg,"%s--------------------------------------\n",ret_msg);
	
	sprintf(return_message,"%s",ret_msg);
}


void viewDiffMemory(struct debugfs_file * df, struct options * opt){

	unsigned int read_wmp_value_1, read_wmp_value_2;
	
	//unsigned int read_wmp_value_store_register1;
	//unsigned int read_wmp_value_store_register2;

	unsigned int read_wmp_memory_1_1;
	unsigned int read_wmp_memory_1_2;
	unsigned int read_wmp_memory_2_1;
	unsigned int read_wmp_memory_2_2;
	unsigned int read_wmp_memory_3_1;
	unsigned int read_wmp_memory_3_2;

	//unsigned int number_pkt;
	//double idle_time_average;
	//double air_time;
	//int window = 0x1e8480; //2000000
	

/*
	unsigned int gpr_byte_code_value = shmRead16(df,B43_SHM_REGS, 57);
 	sprintf(ret_msg,"%s--------------------------------------\n",ret_msg);
	sprintf(ret_msg,"%sREGISTER AND MEMORY INFORMATION\n\n",ret_msg);
	read_wmp_value = shmRead16(df,B43_SHM_REGS, CUR_CONTENTION_WIN);
	sprintf(ret_msg,"%sCurrent contention windows \t = 0x%04X \n",ret_msg,read_wmp_value);
	read_wmp_value = shmRead16(df,B43_SHM_REGS, MAX_CONTENTION_WIN);
	sprintf(ret_msg,"%sMax contention windows \t\t = 0x%04X \n",ret_msg,read_wmp_value);
	read_wmp_value = shmRead16(df,B43_SHM_REGS, MIN_CONTENTION_WIN);
	sprintf(ret_msg,"%sMin contention windows \t\t = 0x%04X \n",ret_msg,read_wmp_value);
*/	

	 time_t rawtime;
	 struct tm * timeinfo;
  	 char buffer [80];

	 
	 FILE * log_memory_diff;
	 log_memory_diff = fopen(opt->memorydiff, "w+");
	 
	while(1){

		time (&rawtime);
		timeinfo = localtime (&rawtime);
		//2014 01 26 11 17 15
		strftime (buffer,80,"%G%m%d%H%M%S",timeinfo);	

	 	read_wmp_value_1 = shmRead16(df, B43_SHM_REGS, PROCEDURE_REGISTER_1);
		read_wmp_value_2 = shmRead16(df, B43_SHM_REGS, PROCEDURE_REGISTER_2);
		read_wmp_memory_1_1 = shmRead32_int(df, B43_SHM_SHARED, BUSY_TIME_CHANNEL_01_LO);
		read_wmp_memory_2_1 = shmRead32_int(df, B43_SHM_SHARED, PROCEDURE_MEMORY_2_LO);
		read_wmp_memory_3_1 = shmRead32_int(df, B43_SHM_SHARED, PROCEDURE_MEMORY_3_LO);

		printf("Register 1 \t\t\t = %04X \n", read_wmp_value_1);
		printf("Register 2 \t\t\t = %04X \n", read_wmp_value_2);
		printf("BUSY TIME CHANNEL \t\t\t = %u \n", (read_wmp_memory_1_1-read_wmp_memory_1_2) );
		printf("Memory 2 \t\t\t = %u \n", (read_wmp_memory_2_1-read_wmp_memory_2_2) );
		printf("Memory 3 \t\t\t = %u \n", (read_wmp_memory_3_1-read_wmp_memory_3_2));
	
		//printf("csv-row,%s,%u,%u,%u\n", buffer, read_wmp_memory_1_1, read_wmp_memory_2_1, read_wmp_memory_3_1);
		fprintf(log_memory_diff, "csv-row,%s,%u,%u,%u,%04X,%04X\n", buffer, read_wmp_memory_1_1, read_wmp_memory_2_1, read_wmp_memory_3_1, read_wmp_value_1, read_wmp_value_2);
		fflush(log_memory_diff);
		//fprintf(sub_line_out,"%c%c%c%c\n",line_mod[6],line_mod[7],line_mod[4],line_mod[5]);
		//fputs(sub_line_out,current_options->out_file);
						 
		
	//	number_pkt = (read_wmp_memory_2_1-read_wmp_memory_2_2) + (read_wmp_memory_3_1-read_wmp_memory_3_2);
	//	air_time = (double) (read_wmp_memory_1_1-read_wmp_memory_1_2)/window*100;
	//	idle_time_average = (double)(window-(read_wmp_memory_1_1-read_wmp_memory_1_2))/number_pkt;
	//	printf("\nNumber pkt \t\t\t = %u \n", number_pkt );
	//	printf("Average idle time \t\t = %f \n", idle_time_average );
	//	printf("Air_time \t\t\t = %f% \n", air_time);

/*		if ((read_wmp_memory_3_1-read_wmp_memory_3_2) > 500) {
			printf("##########################\n");
			printf("#   FLOW IN THE MIDDLE   #\n");
			printf("##########################\n");
		}
*/
		read_wmp_memory_1_2 = read_wmp_memory_1_1;
		read_wmp_memory_2_2 = read_wmp_memory_2_1;
		read_wmp_memory_3_2 = read_wmp_memory_3_1;
			
		printf("*****************************\n");
		//usleep(500000);
		sleep(1);
	}
	
	fclose(log_memory_diff);
		
}




void setControlDebug(struct debugfs_file * df,  struct options * opt){
	int gpr_control = 55;

	if( !strcmp(opt->state_debug,"on") )
		shmMaskSet16(df, B43_SHM_REGS, gpr_control, 0xBFFF, 0x4000);
		
	if( !strcmp(opt->state_debug,"off") )
		shmMaskSet16(df, B43_SHM_REGS, gpr_control, 0xBFFF, 0x0000);
	
	return;
}


void trim_filename(char * bytecode_path, char * ret_filename){
	int i_path,pos;
	char filename[256];

	/* DEBUG Actually you must specify absolute pathfile*/
	if(bytecode_path[0]!='/'){
		printf("WARNING: v0.0.1 PLEASE INDICATE ABSOLUTE PATHFILE\n");
		exit(1);
	}

	for (i_path=0;i_path<strlen(bytecode_path);i_path++){

		if(bytecode_path[i_path]=='/'){

			sprintf(filename,"%s","");
			pos=0;
			continue;
		}
		filename[pos]=bytecode_path[i_path];
		pos++;
	}
	filename[pos]='\0';
	sprintf(ret_filename,"%s",filename);
}






void write_tamplate_frame(struct debugfs_file * df){
	/* Returns an array of 64 ints. One for each General Purpose register. */
	int offset=0;
	int val_length_ack = 0;
	int val_rate = 0;
	int string_destination_address_0 = 0x12; 
	int string_destination_address_1 = 0x34; 
	int string_destination_address_2 = 0x56;
	int string_destination_address_3 = 0x78; 
	int string_destination_address_4 = 0x9a; 
	int string_destination_address_5 = 0xbc;
	int hex_ack_content;

	
	/* Named definitions for the Transmit Modify Engine VALUE registers 
	#define SPR_TME_V_PLCP0				SPR_TME_VAL0	// PLCP header (low) 
	#define SPR_TME_V_PLCP1				SPR_TME_VAL2	// PLCP header (middle) 
	#define SPR_TME_V_PLCP2				SPR_TME_VAL4	// PLCP header (high) 
	#define SPR_TME_V_FCTL				SPR_TME_VAL6	// Frame control 
	#define SPR_TME_V_DURID				SPR_TME_VAL8	// Duration / ID 
	#define SPR_TME_V_ADDR1_0			SPR_TME_VAL10	// Address 1 (low) 
	#define SPR_TME_V_ADDR1_1			SPR_TME_VAL12	// Address 1 (middle) 
	#define SPR_TME_V_ADDR1_2			SPR_TME_VAL14	// Address 1 (high) 
	#define SPR_TME_V_ADDR2_0			SPR_TME_VAL16	// Address 2 (low) 
	#define SPR_TME_V_ADDR2_1			SPR_TME_VAL18	// Address 2 (middle) 
	#define SPR_TME_V_ADDR2_2			SPR_TME_VAL20	// Address 2 (high) 
	#define SPR_TME_V_ADDR3_0			SPR_TME_VAL22	// Address 3 (low) 
	#define SPR_TME_V_ADDR3_1			SPR_TME_VAL24	// Address 3 (middle) 
	#define SPR_TME_V_ADDR3_2			SPR_TME_VAL26	// Address 3 (high) 
	#define SPR_TME_V_SEQ				SPR_TME_VAL28	// Sequence control 
	#define SPR_TME_V_ADDR4_0			SPR_TME_VAL30	// Address 4 (low) 
	#define SPR_TME_V_ADDR4_1			SPR_TME_VAL32	// Address 4 (middle) 
	#define SPR_TME_V_ADDR4_2			SPR_TME_VAL34	// Address 4 (high) 
	*/
	int plcp_0;
	int plcp_2;
	int plcp_4;
	int fctl;
	int durid;
	int addr_1_0;
	int addr_1_1;
	int addr_1_2;
	
	printf("insert length frame : ");
	scanf("%d", &val_length_ack);
	
	//plcp 0 - plcp 2
	
	printf("[1] - 1Mbps \n[6] - 6Mbps \n[12] - 12Mbps \n[18] - 18Mbps \n[24] - 24Mbps \n[36] - 36Mbps \n[48] - 48Mbps \n[54] - 54Mbps \ninsert rate : ");
	scanf("%d", &val_rate);
	//printf("\n\n%d\n\n", val_rate);
	//3E dipende dalla lunghezza
	switch(val_rate){
	  case 1://valido per cck
		  plcp_0 = 0x040A;
		  plcp_2 = val_length_ack * 8;	//durata trasmissione 1F0 * 8 = 0x0F80 - valore di byte per 8
		  break;
	  case 6:
		  plcp_0 = (val_length_ack << 5) + 0x0B;
	  	  plcp_2 = 0x0002;
		  break;
	  case 12:
		  plcp_0 = (val_length_ack << 5) + 0x0A;
		  plcp_2 = 0x0002;
		  break;
	  case 18:
		  plcp_0 = (val_length_ack << 5) + 0x0E;
		  plcp_2 = 0x0000;
		  break;
	  case 24:
		  plcp_0 = (val_length_ack << 5) + 0x09;
		  plcp_2 = 0x0002;
		  break;
	  case 36:
		  plcp_0 = (val_length_ack << 5) + 0x0D;
		  plcp_2 = 0x0000;
		  break;
	  case 48:
    		  plcp_0 = (val_length_ack << 5) + 0x08;
		  plcp_2 = 0x0000;
		  break;
	  case 54:
		  plcp_0 = (val_length_ack << 5) + 0x0C;
		  plcp_2 = 0x0002;
		  break;
	  default:
		  printf("\nNo valid number insert\n");
		  exit(0);
		  break;
	}
	
	
	//plcp 4
	plcp_4 = 0x0000;
	
	
	// frame control
	fctl = 0x00D4; // set for ack
	
	// duration
	durid = 0x0000;
	
	//destination address
	
	printf("insert destination address[12:34:56:78:9a:bc] = ");
	scanf("%x:%x:%x:%x:%x:%x", &string_destination_address_0, &string_destination_address_1, &string_destination_address_2, &string_destination_address_3, &string_destination_address_4, &string_destination_address_5 );
//	printf("\n \n %x:%x:%x:%x:%x:%x \n\n", string_destination_address_0, string_destination_address_1, string_destination_address_2, string_destination_address_3, string_destination_address_4, string_destination_address_5 );
	
	
	addr_1_0 = (string_destination_address_1 << 8) + string_destination_address_0;
	addr_1_1 = (string_destination_address_3 << 8) + string_destination_address_2;
	addr_1_2 = (string_destination_address_5 << 8) + string_destination_address_4;

	
//	printf("\n%x : %x : %x", addr_1_0, addr_1_1, addr_1_2);


	//content ack
	printf("insert frame string text : ");
	scanf("%x", &hex_ack_content);
//	printf("\n%x",hex_ack_content);

	
//3E0D 0000 0000 d400 0000 aaaa bbbb 1111
//0D3E 0000 0000 00d4 0000 aaaa bbbb 1111	ACK 36Mbps

	
	offset = 0x100;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (plcp_2 << 16 ) + plcp_0);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (fctl << 16) + plcp_4);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (addr_1_0 << 16) + durid);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (addr_1_2 << 16) + addr_1_1);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (hex_ack_content << 16) + 0xAAAA);
	
	

	printf("Write template frame succes");
}

void write_beacon_frame(struct debugfs_file * df){
  
	/* #define SHM_BTL0		SHM(0x018) -- Beacon template length 0 
	   #define SHM_BTL1		SHM(0x01A) -- Beacon template length 1 
	   
	   		    jnzx   	 0, 7, GLOBAL_FLAGS_REG3, 0x000, set_low_tmpl_addr;		// if (GLOBAL_FLAGS_REG3 & BEACON_TMPL_LOW)  
			    mov		0x046A, GP_REG5;
			    jext    	COND_TRUE, load_plcp_beacon;
		    set_low_tmpl_addr:
			    mov		0x006A, GP_REG5;
	*/

	#define SHM_BTL1			0x01A
	#define SHM_LEN_BEACON_PARAM 		0x530
	#define BEACON_TEMPLATE_POSITION 	0x46A
	
  
	int offset=0;
	int addr_1_0=0;
	int addr_1_1=0;
	int addr_1_2=0;
	
	int beacon_template_length = 0;
	int beacon_param_length = 0;
	int beacon_write_position = 0;
		
	uint8_t 	mac_addr_1[6];
	uint8_t 	mac_addr_2[6];
	uint16_t 	backoff_param_1;
	uint16_t	param_channel;
	uint16_t 	timer_0_0[2];
	uint16_t 	timer_0_1[2];
	uint16_t 	timer_1_0[2];
	uint16_t 	timer_1_1[2];
	
	
	// ----------- insert length
	
	printf("insert length beacon param [B]: ");
	scanf("%d", &beacon_param_length);
	
	
	
	
	// ------------ init param -------------------
//00:14:A4:62:C8:1B
	
	mac_addr_1[0] = 0x00; mac_addr_1[1] = 0x14; mac_addr_1[2] = 0xa4; mac_addr_1[3] = 0x62;mac_addr_1[4] = 0xc8; mac_addr_1[5] = 0x1B;
	mac_addr_2[0] = 0x77; mac_addr_2[1] = 0x88; mac_addr_2[2] = 0x99; mac_addr_2[3] = 0xAA;mac_addr_2[4] = 0xBB; mac_addr_2[5] = 0xCC;
	
	backoff_param_1 = 0xF;
	param_channel = 0x6;
	
	timer_0_0[0] = 0x1122; timer_0_0[1] = 0x3344;
	timer_0_1[0] = 0x5566; timer_0_1[1] = 0x7788;
	timer_1_0[0] = 0x99AA; timer_1_0[1] = 0xBBCC;
	timer_1_1[0] = 0xDDEE ; timer_1_1[1] = 0xFF00 ;
	
	
	timer_0_0[0] = (timer_0_0[0] << 8) | (timer_0_0[0] >> 8);
	timer_0_0[1] = (timer_0_0[1] << 8) | (timer_0_0[1] >> 8);
	timer_0_1[0] = (timer_0_1[0] << 8) | (timer_0_1[0] >> 8);  timer_0_1[1] = (timer_0_1[1] << 8) | (timer_0_1[1] >> 8);
	timer_1_0[0] = (timer_1_0[0] << 8) | (timer_1_0[0] >> 8);  timer_1_0[1] = (timer_1_0[1] << 8) | (timer_1_0[1] >> 8);
	timer_1_1[0] = (timer_1_1[0] << 8) | (timer_1_1[0] >> 8);  timer_1_1[1] = (timer_1_1[1] << 8) | (timer_1_1[1] >> 8);
	
	// ------------ end init param ---------------------------------------
	
	
	
	// ------------ get dimension ---------------------------
	beacon_template_length = shmRead16(df, B43_SHM_SHARED, SHM_BTL1);
	//printf("\n \n beacon length : %x \n\n", beacon_template_length);
	beacon_write_position = BEACON_TEMPLATE_POSITION + beacon_template_length;
	
		
	
	// ------------ write length beacon ---------------------
	
	shmWrite16(df, B43_SHM_SHARED, SHM_LEN_BEACON_PARAM, beacon_param_length);
	
	// ------------ write beacon ----------------------------
	
	offset = beacon_write_position;
	//write mac addres
	addr_1_0 = (mac_addr_1[1] << 8) + mac_addr_1[0];
	addr_1_1 = (mac_addr_1[3]  << 8) + mac_addr_1[2] ;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (addr_1_1 << 16) + addr_1_0);
	offset=offset+4;
		
	addr_1_2 = (mac_addr_1[5]  << 8) + mac_addr_1[4] ;
	addr_1_0 = (mac_addr_2[1] << 8) + mac_addr_2[0];
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (addr_1_0 << 16) + addr_1_2);
	offset=offset+4;
	
	addr_1_1 = (mac_addr_2[3]  << 8) + mac_addr_2[2] ;
	addr_1_2 = (mac_addr_2[5]  << 8) + mac_addr_2[4] ;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (addr_1_2 << 16) + addr_1_1);
	offset=offset+4;
	
	//write channel and timer
	
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (param_channel << 16) + backoff_param_1);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (timer_0_0[1] << 16) +  timer_0_0[0]);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, ( timer_0_1[1] << 16) +timer_0_1[0]);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, ( timer_1_0[1] << 16) + timer_1_0[0]);
	offset=offset+4;
	write32(df, B43_MMIO_RAM_CONTROL, offset);
	write32(df, B43_MMIO_RAM_DATA, (timer_1_1[1] << 16) + timer_1_1[0]);
	offset=offset+4;
	

	printf("Write beacon frame succes");
}


void managed_other_information(struct debugfs_file * df){
	/* Returns an array of 64 ints. One for each General Purpose register. */
	int val_to_set = 0;
	int val_param = 0;
	int val_operation = 0;

	printf("SET or RESET value for register and memory \n");
	
	printf("[1] - REGISTER_1 \n[2] - REGISTER_2 \n[3] - MEMORY_1 \n[4] - MEMORY_2 \n[5] - MEMORY_3 \n");
	printf("insert option for set or reset : ");
	scanf("%d", &val_param);
	//printf("\n\n%d\n\n", val_param);
	
	printf("[1] - RESET \n[2] - SET\n");
	printf("insert operation : ");
	//	printf("\n \n %x:%x:%x:%x:%x:%x \n\n", string_destination_address_0, string_destination_address_1, string_destination_address_2, string_destination_address_3, string_destination_address_4, string_destination_address_5 );
	scanf("%d", &val_operation);
	
	if (val_operation == 2){
		printf("insert value to set : ");
		scanf("%d", &val_to_set);
		//	printf("\n%x",hex_ack_content);
	}
	else{
		val_to_set = 0;
	}
	
	
	switch(val_param){
	  case 1:
		  shmWrite16(df, B43_SHM_REGS, PROCEDURE_REGISTER_1, val_to_set);
		  break;
	  case 2:
		  shmWrite16(df, B43_SHM_REGS, PROCEDURE_REGISTER_2, val_to_set);
		  break;
	  case 3:
		  shmWrite32(df, B43_SHM_SHARED, PROCEDURE_MEMORY_1_HI, val_to_set);
		  break;
	  case 4:
		  shmWrite32(df, B43_SHM_SHARED, PROCEDURE_MEMORY_2_HI, val_to_set);
		  break;
	  case 5:
		  shmWrite32(df, B43_SHM_SHARED, PROCEDURE_MEMORY_3_HI, val_to_set);
		  break;
	  default:
		  printf("\nNo valid number insert - check insert data\n");
		  exit(0);
		  break;
	}
	
	
	printf("Write register or memory frame succes");
}




static const int b43_radio_channel_codes_bg[] = {
	12, 17, 22, 27,
	32, 37, 42, 47,
	52, 57, 62, 67,
	72, 84,
};

/* Get the freq, as it has to be written to the device. */
static inline int channel2freq_bg( int channel)
{
	return b43_radio_channel_codes_bg[channel - 1];
}




void change_channel(struct debugfs_file * df, int channel){
	//printf("\ninto change channel : %d \n", channel);
	//b43_write16(dev, B43_MMIO_CHANNEL, channel2freq_bg(channel));
	if(channel > 0 & channel <15){
	  write16(df, B43_MMIO_CHANNEL, channel2freq_bg(channel) | 0x8000);
//	  if(channel == 11)
//	    write16(df, B43_MMIO_CHANNEL, 0x803E);
//	  int read_val = read16(df, B43_MMIO_CHANNEL);
//	  printf("\nval read of channel : %x \n", read_val);
	  if (channel == 14) {
 		  write16(df, B43_MMIO_CHANNEL_EXT, read16(df, B43_MMIO_CHANNEL_EXT) | (1 << 11));
 	  } 
 	  else {
 		  write16(df, B43_MMIO_CHANNEL_EXT, read16(df, B43_MMIO_CHANNEL_EXT) & 0xF7BF);
	  }
	}
	else{
	    printf("ERROR: Channel must been a number between 1 and 14" );  
	}
	
}


