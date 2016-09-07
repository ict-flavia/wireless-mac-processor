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

#include "HandleTCP.h"
#include "messageHandler.h"


#define RCVBUFSIZE 1500
#define MAX_MESSAGE_SIZE 4096

#define MAXPENDING 5    /* Maximum outstanding connection requests */





