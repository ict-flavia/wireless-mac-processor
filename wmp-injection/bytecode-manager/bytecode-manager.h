/****************
* bytecode-manager.h
*****************/
#define STARTUP_LOGO "\
--------------------------------------------\n\
WMP Bytecode Manager V 2.49 - 2015\n\
--------------------------------------------\n"

#define usageMenu "WMP bytecode-manager byte-code injection \n\
Usage: bytecode-manager [OPTIONS]\n\
\t -h \t\t\t\t Print this help text\n\
\t -l <#> \t\t\t LOAD Bytecode in specified # value (1 or 2) \n\
\t -m <name-file> \t\t LOAD Bytecode state-machine bytecode file \n\
\t -n <name-file> \t\t LOAD ottimized for params \n\
\t -u \t\t\t\t used with the options -a -l and -m force the load of bytecode\n\
\t -a <#> \t\t\t Activate specified bytecode (1 or 2)\n\
\t -t <time> \t\t\t Timed Bytecode Activation [value in sec]\n\
\t -d <delay> \t\t\t Delayed Bytecode Activation in microsecond\n\
\t -f <time> \t\t\t Return the absolut time for precise \n \t\t\t\t\t equal activation [value in sec] \n\
\t -r \t\t\t\t reset activate and deactive condition Bytecode\n\
\t -v \t\t\t\t view active and deactive condition Bytecode\n\
\t -c <ip address> \t\t IP address to server station Start in client mode \n\
\t -g <name-file> \t\t bytecode to send \n\
\t -s <interface to listen> \t SERVER MODE\n\
\t -p <port number> \t\t In server mode or client mode select specific port, \n \t\t\t\t\t if not use default port is 9898\n\
\t -e <on><off> \t\t\t active or deactive state debug\n\
\t -x <1,2,3> \t\t\t Show Registers (1), Share Memory(2) or both(3)\n\
\t -w \t\t\t\t Write a frame in tamplate ram to send with specific action in the wmp; \n \t\t\t\t\t frame can be 'date' or 'ack' with different rate to the trasmissn, and string conteined in the frame \n\
\t --input \t <input-file> \n\
\t --output \t <output-file> \n\
\t --timeslot \t <timeslot ms > \n\
\t --position \t <position ms> \n\
\t --macaddress \t <mac_address> \n\
\t --channel \t <channel> \n\
\t --timer \t  <timer values ms> \n\
\t --modify-parameter \t <parameter num> \n"


//\t --write-reg-mem \t\t\t\t Other options, set or reset values information for the wmp register and memory;  \t\t\t\t\t \n"
//\t --channel \t\t\t Change the channel of the WMP work; \n \t\t\t\t\t \n"
//\t -i <wiphy> \t\t\t WIPHY to use. (For example phy0) \n\


#define usageExamples "\
\nEXAMPLES:\n\
--------\n\
1. bytecode-manager -a 2 \t\t\t Active the byte-code in the position 2\n\
2. bytecode-manager -l 2 -m dcf-standard \t Load the byte-code conteined in the file \n \t\t\t\t\t\t dcf-standard in the position 2. \n\
3. bytecode-manager -s \t\t\t\t Set the tool in server mode, in this mode the \n \t\t\t\t\t\t tool listen for new byte-code and ommand.\n\
4. bytecode-manager -c 192.168.1.2 -a 2 \t Set the tool in client mode and send the command \n \t\t\t\t\t\t to active the byte-code in he position 2 for server 192.168.1.2\n\
5. bytecode-manager -c 192.168.1.2 -g dcf-stan \t Set the tool in client mode and send the byte-code dcf-stan to server 192.168.1.2\n\
\n\n\n"


//#define PARAMETER_ADDR_OFFSET_BYTECODE_1 	0x0418
//#define PARAMETER_ADDR_BYTECODE_1 		0x0830
//#define PARAMETER_ADDR_OFFSET_BYTECODE_2 	0x0610
//#define PARAMETER_ADDR_BYTECODE_2 		0x0C20
//#define LENGTH_PARAMETER_REGION 		0x0020



#define NO_MATCH_ADDR_OFFSET_BYTECODE		"WARNING: No Bytecode Parameter Match, probably you're not using an appropriate firmware"

#define DEFAULT_SERVER_PORT "9898"
void usage(void);
void check_association(void);
void init_options(struct options *);

void parseArgs(int, char **, struct options *);
void setStartState(struct debugfs_file * );
void to_byte_code(void);
void resetServerOpt(struct options *);
void forgeMessageBytecode(char * bytecode_path, char *);
int forgeMessageCommand(int argc, char ** argv, char * message,  struct debugfs_file *df);

int TCPServer(unsigned short servPort, struct options * current_options, struct debugfs_file *df);
int TCPClient(char *servIP, unsigned short servPort,char *);

void setControlDebug(struct debugfs_file * df,  struct options * opt);


void viewActiveBytecode(struct debugfs_file * df,char *return_message);
void viewDiffMemory(struct debugfs_file * df, struct options * opt);

void trim_filename(char * bytecode_path, char * ret_filename);



// write frame into tamplateram
void write_tamplate_frame(struct debugfs_file * df);
// write beacon into tamplateram
void write_beacon_frame(struct debugfs_file * df);
// managed other options
void managed_other_information(struct debugfs_file * df);
//change channel wmp
void change_channel(struct debugfs_file * df, int channel);