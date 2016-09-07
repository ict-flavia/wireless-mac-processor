# build helloworld executable when user executes "make"
OBJECTS = bytecode-manager.o libb43.o hex2int.o dataParser.o messageHandler.o auto-bytecode.o bytecode-work.o bytecode-upis.o

# CFLAGS are the flags to use when *compiling*
CFLAGS= -m32 
# LFLAGS are the flags to use when *linking*
#LFLAGS=-ldl


#bytecode-manager: bytecode-manager.o
bytecode-manager: $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -m32 -o bytecode-manager

bytecode-manager.o: bytecode-manager.c
	$(CC) $(CFLAGS) -c bytecode-manager.c
libb43.o: libb43.c
	$(CC) $(CFLAGS) -c libb43.c
hex2int.o: hex2int.c
	$(CC) $(CFLAGS) -c hex2int.c
dataParser.o: dataParser.c
	$(CC) $(CFLAGS) -c dataParser.c
messageHandler.o: messageHandler.c
	$(CC) $(CFLAGS) -c messageHandler.c
auto-bytecode.o: auto-bytecode.c
	$(CC) $(CFLAGS) -c auto-bytecode.c
bytecode-work.o: bytecode-work.c
	$(CC) $(CFLAGS) -c bytecode-work.c
bytecode-upis.o: bytecode-upis.c
	$(CC) $(CFLAGS) -c bytecode-upis.c
	
# remove object files and executable when user executes "make clean"
clean:
	rm *.o bytecode-manager int-aloha
	
int-aloha: int-aloha.h int-aloha.c bytecode-work.h bytecode-work.c libb43.h libb43.c dataParser.h dataParser.c hex2int.h hex2int.c
	#gcc -std=gnu99 -o int-aloha dataParser.c int-aloha.c protocols.c libb43.c hex2int.c -lm
	$(CC) -std=gnu99 -m32 -o int-aloha int-aloha.c protocols.c libb43.c dataParser.c hex2int.c bytecode-work.c -lm
	

