#define CACHE_PATH_FILE "cache/"

struct options{
	char * phy;
	char * load; 		/* quale bytecode caricare */
	char * active; 		// quale bytecode attivare
	char * auto_active;
	char * binary; 		//= None # No instruction dump
	char * time; 
	char * dasmopt;
	char * dumpShm;
	char * dumpShmBin;
	char * name_file;
	char * delay;
	char * calculation;
	char * reset;
	char * timer_delay;
	int    view;
	char * HOST;
	char * PORT;
	int    OP_MODE; 	// OFFLINE=0 ; CLIENT=1; SERVER=2
	char * give_file;
	char * nic;
	char * do_up;
	char * byte_code;
	char * state_debug;
	char * reg_share;
	char * write_frame;
	char * write_beacon_frame;
	char * other_option;
	char * change_param_file;
	char * memorydiff;
	char * time_state_measure;
	char * time_activate_measure;
	char * zigbee_rx;
	char * slot_time_value;
	char * change_param;
	char * get_parameter;
	char * get_interface_name;
	
//autobytecode option	
	int enable_autobytecode;
	
	char* output_file_name;
	FILE *out_file;
	char* input_file_name;
	FILE *in_file;
	
	int enable_mac_address;
	unsigned char mac_addr[6];
	int channel; 
	int timeslot;
	int position;
	int enable_timer;
	unsigned int timer[4];
};


