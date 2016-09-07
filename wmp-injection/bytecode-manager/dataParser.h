
#define ADDRESS_CONDITION_PROCEDURE  0x770

//settaggio indirizzi per la sezione che contiene i parametri di stato
//parametri bytecode

#define PARAMETER_ADDR_OFFSET_BYTECODE_1		0x0418
#define PARAMETER_ADDR_BYTECODE_1			0x0830
#define PARAMETER_ADDR_OFFSET_BYTECODE_2		0x0610
#define PARAMETER_ADDR_BYTECODE_2			0x0C20
#define LENGTH_PARAMETER_REGION				0x0028
		
//descrittori di stato
#define COMBINATION_ADDR_BYTECODE_1			PARAMETER_ADDR_BYTECODE_1 + (LENGTH_PARAMETER_REGION * 2)
#define COMBINATION_ADDR_BYTECODE_2			PARAMETER_ADDR_BYTECODE_2 + (LENGTH_PARAMETER_REGION * 2)
#define LENGTH_PARAMETER_AND_COMBINATION_REGION		0x01B8
	
	
//stati
#define STATE_ADDR_BYTECODE_1			( PARAMETER_ADDR_BYTECODE_1 + (LENGTH_PARAMETER_AND_COMBINATION_REGION * 2) )
#define STATE_ADDR_BYTECODE_2			( PARAMETER_ADDR_BYTECODE_2 + (LENGTH_PARAMETER_AND_COMBINATION_REGION * 2) )



#define GPR_CONTROL		55
#define GPR_BYTECODE_ADDRESS 	57
#define GPR_CURRENT_STATE	48

#define	SHM_RX_TIME_WORD3	0x078
#define	SHM_RX_TIME_WORD2	0x07A
#define SHM_RX_TIME_WORD1	0x07C
#define	SHM_RX_TIME_WORD0	0x07E

#define	REG_TIMER_DELAY_2	30
#define	REG_TIMER_DELAY_1	31

#define	TIMER_DELAY_2_TIME_OUT	 0x00C0
#define	TIMER_DELAY_1_TIME_OUT	 0x00C2
	
#define MIN_CONTENTION_WIN	6
#define MAX_CONTENTION_WIN	7
#define CUR_CONTENTION_WIN	8

#define	PROCEDURE_REGISTER_1	44
#define	PROCEDURE_REGISTER_2	46
	

#define BUSY_TIME			
	
#define PROCEDURE_MEMORY_1_LO 	0x00C8
#define PROCEDURE_MEMORY_1_HI 	0x00CA

#define	BUSY_TIME_CHANNEL_01_HI 	0x00E0
#define	BUSY_TIME_CHANNEL_01_LO 	0x00DE


#define PROCEDURE_MEMORY_2_LO 	0x00CC
#define PROCEDURE_MEMORY_2_HI 	0x00CE
#define PROCEDURE_MEMORY_3_LO 	0x00D0
#define PROCEDURE_MEMORY_3_HI 	0x00D2

//#define 	SLOT_PARAM_AREA_POINT_OFFSET 	SHM(0x00F0) 
//#define 	SLOT_PARAM_AREA_POINT_OFFSET_LO	 0x00F0 
//#define 	SLOT_PARAM_AREA_POINT_OFFSET_HI  0x0100 
		
#define 	PACKET_TO_TRANSMIT		0xF0
#define 	MY_TRANSMISSION			0xF4
#define 	SUCCES_TRANSMISSION		0xF8
#define 	OTHER_TRANSMISSION		0xFC
#define 	START_TRANSMISSION		0x100
#define 	BAD_RECEPTION			0x104
#define 	BUSY_SLOT			0x108

#define		NEAR_SLOT		43
#define		COUNT_SLOT		43
#define		SINC_SLOT_2		40
#define		SINC_SLOT_1		41
#define		SINC_SLOT_0		42	



void parser(struct debugfs_file * df, struct options * opt);
void load_params(struct debugfs_file * df, struct options * opt);

void bytecodeSharedWrite(struct debugfs_file * df, struct options * opt);
void putInWaitMode(struct debugfs_file * df);
void returnFromWaitMode(struct debugfs_file * df);

void setStartState(struct debugfs_file * df);
void writeAddressBytecode(struct debugfs_file * df, struct options * opt);
void activeBytecode(struct debugfs_file * df, struct options * opt);
void autoActiveBytecode(struct debugfs_file * df, struct options * opt);



void setTimer2(struct debugfs_file * df, struct options * opt);
int calculateDelay(struct debugfs_file * df, struct options * opt);
void setDelay(struct debugfs_file * df, struct options * opt);
void setDelayTimer(struct debugfs_file * df, struct options * opt);
void resetControl(struct debugfs_file * df);



