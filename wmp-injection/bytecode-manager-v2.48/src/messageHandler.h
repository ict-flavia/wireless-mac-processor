#define MAX_TAG_SIZE 256
#define MAX_VAL_SIZE 4096

struct xml_node {
 char id[MAX_TAG_SIZE];
 char value[MAX_VAL_SIZE];
};


int xmlHandler(char * ,struct xml_node* );
int isCommand(struct xml_node* ,int);
int isBytecode(struct xml_node* ,int);
void saveBytecode(char *,char *);
void getFilename(struct xml_node* xml_data,int num_of_tags,char *filename);
void getBytecode(struct xml_node* xml_data,int num_of_tags,char *bytecode);
int getCommand(struct xml_node* xml_data,int num_of_tags,char *command);
void executeCommand(char *comand, char *, struct debugfs_file *);
