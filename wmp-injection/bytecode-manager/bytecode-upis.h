

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>

#include <ifaddrs.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/wireless.h>
#include <time.h>       /* time_t, struct tm, time, localtime, strftime */


//void getParameterLowerLayer(struct debugfs_file * df, struct options * opt, char *return_message);
void get_interface_name();
