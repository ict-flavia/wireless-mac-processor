# build helloworld executable when user executes "make"
OBJECTS = bytecode-manager.o libb43.o hex2int.o dataParser.o messageHandler.o auto-bytecode.o

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
	
# remove object files and executable when user executes "make clean"
clean:
	rm *.o bytecode-manager

