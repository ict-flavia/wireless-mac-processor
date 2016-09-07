#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <net/if.h>
#include <sys/socket.h>
#include <pcap/pcap.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#ifdef __APPLE__
#include <net/ethernet.h>
#else
#include <netinet/ether.h>
#endif
#include <string.h>
#include <sys/stat.h>

#include "wmp4warp.h"

#define MAX_BC_LENGTH 1500

char* print_fsm_bin(const char *filename);

void static usage()
{
        fprintf(stdout, "----------------------\n");
        fprintf(stdout, "wmp4warp -i <int_name> -1 <MAC addr int> [-ewlxdtra]\n");
        fprintf(stdout, "       -h    		: Print this help text\n");
        fprintf(stdout, "       -i <int_name>   : int_name is the name of the output interface\n");
        fprintf(stdout, "       -1 <MAC addr>   : source MAC address\n");
        fprintf(stdout, "       -e              : send WARP discover message (requires manual stop)\n");
        fprintf(stdout, "       -w <warpid>     : WARP identifier. required fon any command different from -e\n");
        fprintf(stdout, "       -m <fsmfile>    : load on warpid the FSM in fsmfile\n");
        fprintf(stdout, "       -l <fsmid>      : ID for fsm in fsmfile (identifier 0 is for the default fsm)\n");
        fprintf(stdout, "       -d <fsmid>      : delete FSM whose id is fsmid from warpid\n");
        fprintf(stdout, "       -t              : require timestamp to warpid\n");
	fprintf(stdout, "       -a <us>         : active fsmid after 0 us\n");
        fprintf(stdout, "       -r <us>         : require to active fsmid after us us\n");
        fprintf(stdout, "       -s <ts>         : require to run fsmid at ts\n");
        fprintf(stdout, "       -v <var_id>     : read variable identified by var_id\n");
        fprintf(stdout, "----------------------\n");
}

static void print_mac(uint8_t *mac)
{
    fprintf(stdout, "%02X:%02X:%02X:%02X:%02X:%02X\n",
        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
}

static uint32_t get_wmp_packet_l(uint16_t cmd)
{
        int ret = 0;

        switch (cmd) {
        case WMP4WARP_ECHO_REQ_CMD:
                ret = WMP4WARP_ECHO_REQ_L;
        break;

        case WMP4WARP_FSM_LOAD:
                ret = WMP4WARP_FSM_LOAD_L;
        break;

        case WMP4WARP_FSM_DEL:
                ret = WMP4WARP_FSM_DEL_L;
        break;

        case WMP4WARP_TS_REQ:
                ret = WMP4WARP_TS_REQ_L;
        break;

        case WMP4WARP_RUN:
                ret = WMP4WARP_RUN_L;
        break;

        case WMP4WARP_RUN_ABS:
                ret = WMP4WARP_RUN_ABS_L;
        break;

        case WMP4WARP_READ_VAR:
                ret = WMP4WARP_READ_VAR_L;
        break;
        }

        return ret;
}

static void handle_echo_reply(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp *w4w = (struct wmp4warp *) user;
    FILE *warp_list_file;

    warp_list_file = fopen(WARP_LIST_FILE_NAME, "a+");

    w4w->warp_counter++;

    fprintf(stdout, "warp%d:%02X:%02X:%02X:%02X:%02X:%02X\n",
        w4w->warp_counter,
        w4w_hdr_cmn->mac_addr[0], w4w_hdr_cmn->mac_addr[1],
        w4w_hdr_cmn->mac_addr[2], w4w_hdr_cmn->mac_addr[3],
        w4w_hdr_cmn->mac_addr[4], w4w_hdr_cmn->mac_addr[5]);

    fprintf(warp_list_file, "warp%d:%02X:%02X:%02X:%02X:%02X:%02X\n",
        w4w->warp_counter,
        w4w_hdr_cmn->mac_addr[0], w4w_hdr_cmn->mac_addr[1],
        w4w_hdr_cmn->mac_addr[2], w4w_hdr_cmn->mac_addr[3],
        w4w_hdr_cmn->mac_addr[4], w4w_hdr_cmn->mac_addr[5]);

    fclose(warp_list_file);

}

static void handle_fsm_load_conf(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp_header_fsm_load *fsm_load_hdr =
                (struct wmp4warp_header_fsm_load *) (bytes + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

    struct wmp4warp *w4w = (struct wmp4warp *) user;

    if (!memcmp(mac_header->mac_src, w4w->warp_mac_addr, sizeof(w4w->warp_mac_addr))) {
        fprintf(stdout, "%s has loaded FSM whose ID is %d\n", w4w->warp_name, fsm_load_hdr->fsm_id);
    }

}

static void handle_fsm_del_conf(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp_header_fsm_del *fsm_del_hdr =
                (struct wmp4warp_header_fsm_del *) (bytes + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

    struct wmp4warp *w4w = (struct wmp4warp *) user;

    if (!memcmp(mac_header->mac_src, w4w->warp_mac_addr, sizeof(w4w->warp_mac_addr))) {
        fprintf(stdout, "%s has deleted FSM whose ID is %d\n", w4w->warp_name, fsm_del_hdr->fsm_id);
    }

}

static void handle_ts_rep(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp_header_ts_rep *ts_rep_hdr =
                (struct wmp4warp_header_ts_rep *) (bytes + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

    struct wmp4warp *w4w = (struct wmp4warp *) user;

    if (!memcmp(mac_header->mac_src, w4w->warp_mac_addr, sizeof(w4w->warp_mac_addr))) {
        fprintf(stdout, "%s timestamp: %llu\n", w4w->warp_name, (unsigned long long)ts_rep_hdr->ts);
    }

}

static void handle_run(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp_header_run*run_hdr =
                (struct wmp4warp_header_run *) (bytes + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

    struct wmp4warp *w4w = (struct wmp4warp *) user;

    if (!memcmp(mac_header->mac_src, w4w->warp_mac_addr, sizeof(w4w->warp_mac_addr))) {
        fprintf(stdout, "%s is going to switch to FSM %d in %llu us\n", w4w->warp_name, run_hdr->fsm_id, (unsigned long long)run_hdr->ts);
    }

}

static void handle_run_abs(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp_header_run_abs *run_hdr =
                (struct wmp4warp_header_run_abs *) (bytes + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

    struct wmp4warp *w4w = (struct wmp4warp *) user;

    if (!memcmp(mac_header->mac_src, w4w->warp_mac_addr, sizeof(w4w->warp_mac_addr))) {
        fprintf(stdout, "%s is going to switch to FSM %d in %llu us\n", w4w->warp_name, run_hdr->fsm_id, (unsigned long long)run_hdr->ts);
    }

}

static void handle_read_var(u_char *user, const u_char *bytes)
{
    struct packet_header *mac_header = (struct packet_header *) (bytes);
    struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
    struct wmp4warp_header_read_var_rep *read_hdr =
                (struct wmp4warp_header_read_var_rep *) (bytes + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

    struct wmp4warp *w4w = (struct wmp4warp *) user;

    if (!memcmp(mac_header->mac_src, w4w->warp_mac_addr, sizeof(w4w->warp_mac_addr))) {
        fprintf(stdout, "Register %d: %05hu\n", read_hdr->var_id + 1, read_hdr->var_value);
    }

}

void resp_handler(u_char *user, const struct pcap_pkthdr *h, const u_char *bytes)
{
        struct packet_header *mac_header = (struct packet_header *) (bytes);
        struct wmp4warp_header_common *w4w_hdr_cmn =
            (struct wmp4warp_header_common *) (bytes + sizeof(struct packet_header));
        struct wmp4warp *w4w = (struct wmp4warp *) user;


        if (w4w_hdr_cmn->cmd_id != w4w->cmd_wait) {
            fprintf(stderr, "Unexpected command: (waiting for %x, received %x)\n", w4w->cmd_wait, w4w_hdr_cmn->cmd_id);
            return;
        }

        switch (w4w_hdr_cmn->cmd_id) {
        case WMP4WARP_ECHO_REP_CMD:
             handle_echo_reply(user, bytes);
        break;
        case WMP4WARP_FSM_LOAD_CONF:
            handle_fsm_load_conf(user, bytes);
        break;
        case WMP4WARP_FSM_DEL_CONF:
            handle_fsm_del_conf(user, bytes);
        break;
        case WMP4WARP_TS_REP:
            handle_ts_rep(user, bytes);
        break;
        case WMP4WARP_RUN_CONF:
            handle_run(user, bytes);
        break;
        case WMP4WARP_RUN_ABS_CONF:
            handle_run_abs(user, bytes);
        case WMP4WARP_READ_VAR_REP:
            handle_read_var(user, bytes);
        break;
        }

        fflush(stdout);

       // if ((w4w_hdr_cmn->cmd_id != WMP4WARP_ECHO_REP_CMD) || (w4w_hdr_cmn->cmd_id != WMP4WARP_READ_VAR_REP))
       //     exit(1);
}

int main (int argc, char **argv)
{
        int c, i;
        struct ifreq ioreq;
        pcap_if_t *alldevs, *d;
        int rawsoc = -1;
        char errbuf[PCAP_ERRBUF_SIZE];
        struct ether_addr *macaddr;
        uint8_t buffer[MAX_FRAME_LENGTH] = {0,};
        pcap_t* pcap;
        struct bpf_program fp;
        uint32_t length;
        int load_file_set = 0;
        int fsm_id_set = 0;
	int var_tot = 0;
	int count = 1;
        char *warp_dest_id_str = NULL;
	char *in_file_name = NULL;
	char *out_name = NULL;
        struct packet_header *mac_header;
        struct wmp4warp_header_common *w4w_hdr_cmn;
        struct wmp4warp w4w = {
                .out_interface_name = NULL,
                .local_mac_addr = {0,},
                .warp_mac_addr = {0,},
                .broadcast_mac_addr =
                        {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF},
                .warp_counter = 0,
                .warplist = NULL,

                .fsm_file_name = NULL,
                .fsm_id = 0,
                .fsm_size = 0,
                .fsm = {0,},
        };
        static char pcap_filter_str[1024];

        errbuf[0]='\0';

	w4w.out_interface_name = "eth1";
        while ((c = (char)getopt(argc, argv, "i:1:w:l:m:d:a:u:s:r:tevh")) != EOF) {
                switch (c) {
                case 'i':
                        w4w.out_interface_name = optarg;
                break;

                case '1':
                        macaddr = ether_aton(optarg);
                        memcpy(w4w.local_mac_addr, macaddr->ether_addr_octet,
                                sizeof(w4w.local_mac_addr));
                break;

                case 'e':
                        remove(WARP_LIST_FILE_NAME);
                        w4w.cmd = WMP4WARP_ECHO_REQ_CMD;
                        w4w.cmd_wait = WMP4WARP_ECHO_REP_CMD;
                break;

                case 'w':
                        warp_dest_id_str = optarg;
                        w4w.warp_name = optarg;
                break;

                case 'm':
                        in_file_name = optarg;
			out_name = print_fsm_bin(in_file_name);
                        w4w.fsm_file_name = out_name;
			load_file_set = 1;
                        w4w.cmd = WMP4WARP_FSM_LOAD;
                        w4w.cmd_wait = WMP4WARP_FSM_LOAD_CONF;
                break;

                case 'l':
                        w4w.fsm_id = atoi(optarg) - 1;
                        fsm_id_set = 1;
                break;

                case 'd':
                        w4w.fsm_id = atoi(optarg);
                        w4w.cmd = WMP4WARP_FSM_DEL;
                        w4w.cmd_wait = WMP4WARP_FSM_DEL_CONF;
                break;

                case 'r':
                        w4w.var_id = atoi(optarg) - 1;
                        w4w.cmd = WMP4WARP_READ_VAR;
                        w4w.cmd_wait = WMP4WARP_READ_VAR_REP;
                break;

                case 't':
                        w4w.cmd = WMP4WARP_TS_REQ;
                        w4w.cmd_wait = WMP4WARP_TS_REP;
                break;

                case 'u':
                        w4w.run_ts = strtoull(optarg, NULL, 10);
                        w4w.cmd = WMP4WARP_RUN;
                        w4w.cmd_wait = WMP4WARP_RUN_CONF;
                break;
		
		case 'a':
			w4w.fsm_id = atoi(optarg) - 1;
                        fsm_id_set = 1;
                        w4w.run_ts = 0;
                        w4w.cmd = WMP4WARP_RUN;
                        w4w.cmd_wait = WMP4WARP_RUN_CONF;
                break;

                case 's':
                        w4w.run_ts = strtoull(optarg, NULL, 10);
                        w4w.cmd = WMP4WARP_RUN_ABS;
                        w4w.cmd_wait = WMP4WARP_RUN_ABS_CONF;
                break;

		case 'v':
			var_tot = 1;
	   		w4w.var_id = 0;
                        w4w.cmd = WMP4WARP_READ_VAR;
                        w4w.cmd_wait = WMP4WARP_READ_VAR_REP;
                break;
                
                case 'h':
			usage();
                        exit(1);
                break;

                default:
                        fprintf(stderr, "Unknown option %c\n", c);
                        usage();
                        exit(1);
                break;
                }
        }

        if (!w4w.out_interface_name) {
                fprintf(stderr, "Output interface name is mandatory\n");
                usage();
                exit(1);
        }

        if ((w4w.cmd != WMP4WARP_ECHO_REQ_CMD) && !warp_dest_id_str) {
                fprintf(stderr, "WARP identifier required for any option different from -e\n");
                usage();
                exit(1);
        }

        if (load_file_set && !fsm_id_set) {
                fprintf(stderr, "Options -l and -m must be used together.\n");
                usage();
                exit(1);
        }

        if (((w4w.cmd == WMP4WARP_RUN) || (w4w.cmd == WMP4WARP_RUN_ABS)) && !fsm_id_set) {
                fprintf(stderr, "Options -l and (-r or -s) must be used together.\n");
                usage();
                exit(1);
        }

        if (w4w.cmd == WMP4WARP_FSM_LOAD) {
            FILE *fsm_file = fopen(w4w.fsm_file_name, "rb");
            struct stat st;

            if (!fsm_file) {
                fprintf(stderr, "Error opening file %s\n", w4w.fsm_file_name);
            }

            stat(w4w.fsm_file_name, &st);
            w4w.fsm_size = st.st_size;

            fread(w4w.fsm, sizeof(w4w.fsm[0]), w4w.fsm_size, fsm_file);

            fclose(fsm_file);
	    remove(out_name);
        }

        if (w4w.cmd != WMP4WARP_ECHO_REQ_CMD) {
            char *file_buf = NULL;
            char warpname[1024];
            uint32_t warpid;
            uint32_t c = 0;
            size_t len = 0;
            ssize_t read = 0;
            FILE *warp_list_file = fopen(WARP_LIST_FILE_NAME, "r");

            if (!warp_list_file) {
                fprintf(stderr, "%s does not exist (run command -e first)\n", WARP_LIST_FILE_NAME);
            }

            while ((read = getline(&file_buf, &len, warp_list_file)) != -1) {
                w4w.warp_counter++;
            }

            w4w.warplist = malloc(sizeof(struct warpinfo) * w4w.warp_counter);

            if (!w4w.warplist) {
                fprintf(stderr, "Memory allocation error\n");
                exit(-1);
            }

            fseek(warp_list_file, 0, SEEK_SET);

            while ((read = getline(&file_buf, &len, warp_list_file)) != -1) {
                sscanf(file_buf, "warp%d:%02X:%02X:%02X:%02X:%02X:%02X\n",
                    &warpid,
                    (unsigned int *)&w4w.warplist[c].mac_addr[0], (unsigned int *)&w4w.warplist[c].mac_addr[1],
                    (unsigned int *)&w4w.warplist[c].mac_addr[2], (unsigned int *)&w4w.warplist[c].mac_addr[3],
                    (unsigned int *)&w4w.warplist[c].mac_addr[4], (unsigned int *)&w4w.warplist[c].mac_addr[5]);

                sprintf(warpname, "warp%d", warpid);
                w4w.warplist[c].name = malloc(strlen(warpname) + 1);
                strcpy(w4w.warplist[c].name, warpname);

                c++;
            }

            fclose(warp_list_file);

            for (c = 0; c <  w4w.warp_counter; c++) {
                if (!(strcmp(warp_dest_id_str, w4w.warplist[c].name))) {
                    memcpy(w4w.warp_mac_addr, w4w.warplist[c].mac_addr, sizeof(w4w.warp_mac_addr));
                }
            }

        }

        if (!pcap_findalldevs(&alldevs, errbuf)) {
                for (d = alldevs; d; d = d->next) {
                        if (memcmp(d->name, w4w.out_interface_name, strlen(w4w.out_interface_name)) == 0) {
                                fprintf(stdout, "Listening on %s\n", d->name);
                        }
                }
        } else {
              fprintf(stderr, "Impossible to retrieve output interface info\n");
              exit(1);
        }


        pcap = pcap_open_live(w4w.out_interface_name, MAX_FRAME_LENGTH, 1, 10, errbuf);

        if (!pcap) {
                fprintf(stderr,"%s\n",errbuf);
                exit(1);
        }

        sprintf(pcap_filter_str, "(ether proto " WMP4WARP_ETHER_TYPE_STR ") and (ether dst %02x:%02x:%02x:%02x:%02x:%02x)",
            w4w.local_mac_addr[0], w4w.local_mac_addr[1], w4w.local_mac_addr[2],
            w4w.local_mac_addr[3], w4w.local_mac_addr[4], w4w.local_mac_addr[5]);

        if (pcap_compile(pcap, &fp, pcap_filter_str, 0, PCAP_NETMASK_UNKNOWN) == -1) {
            fprintf(stderr, "Error calling pcap_compile\n");
            exit(-1);
        }

        if(pcap_setfilter(pcap,&fp) == -1) {
            fprintf(stderr, "Error calling pcap_setfilter\n");
            exit(-1);
        }

        mac_header = (struct packet_header *) buffer;
        if (w4w.cmd == WMP4WARP_ECHO_REQ_CMD) {
            memcpy(mac_header->mac_dst, w4w.broadcast_mac_addr, sizeof(w4w.broadcast_mac_addr));
        } else {
            memcpy(mac_header->mac_dst, w4w.warp_mac_addr, sizeof(w4w.warp_mac_addr));
        }
        memcpy(mac_header->mac_src, w4w.local_mac_addr, sizeof(w4w.local_mac_addr));
        mac_header->ether_type = htons(WMP4WARP_ETHER_TYPE);
        w4w_hdr_cmn = (struct wmp4warp_header_common *) (buffer + sizeof(struct packet_header));
        w4w_hdr_cmn->cmd_id = w4w.cmd;
        memcpy(w4w_hdr_cmn->mac_addr, w4w.local_mac_addr, sizeof(w4w_hdr_cmn->mac_addr));

        length = get_wmp_packet_l(w4w.cmd);

        if (w4w.cmd == WMP4WARP_FSM_LOAD) {
            struct wmp4warp_header_fsm_load *fsm_load_hdr =
                (struct wmp4warp_header_fsm_load *) (buffer + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

            fsm_load_hdr->fsm_id = w4w.fsm_id;
            fsm_load_hdr->fsm_l = w4w.fsm_size;
            length += w4w.fsm_size;

            memcpy((buffer + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common) + sizeof(struct wmp4warp_header_fsm_load)),
                w4w.fsm, w4w.fsm_size);
        }

        if (w4w.cmd == WMP4WARP_FSM_DEL) {
            struct wmp4warp_header_fsm_del *fsm_del_hdr =
                (struct wmp4warp_header_fsm_del *) (buffer + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

            fsm_del_hdr->fsm_id = w4w.fsm_id;
        }

        if (w4w.cmd == WMP4WARP_RUN) {
            struct wmp4warp_header_run *run_hdr =
                (struct wmp4warp_header_run *) (buffer + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

            run_hdr->fsm_id = w4w.fsm_id;
            run_hdr->ts = w4w.run_ts;
        }
        if (w4w.cmd == WMP4WARP_READ_VAR) {
            struct wmp4warp_header_read_var *read_hdr =
                (struct wmp4warp_header_read_var *) (buffer + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));
	  if(var_tot == 0) 
            read_hdr->var_id = w4w.var_id;
	  else{
	    read_hdr->var_id = w4w.var_id;
	fprintf(stdout, "--------------------------------------\nREGISTER INFORMATION\n\n");
	    if (pcap_inject(pcap, buffer, length) == -1) {
                pcap_perror(pcap,0);
                pcap_close(pcap);
                exit(1);
        }
	read_hdr->var_id = w4w.var_id + 1;

	if (pcap_inject(pcap, buffer, length) == -1) {
                pcap_perror(pcap,0);
                pcap_close(pcap);
                exit(1);
        }

	read_hdr->var_id = w4w.var_id + 2;

	if (pcap_inject(pcap, buffer, length) == -1) {
                pcap_perror(pcap,0);
                pcap_close(pcap);
                exit(1);
        }

	read_hdr->var_id = w4w.var_id + 3;

	if (pcap_inject(pcap, buffer, length) == -1) {
                pcap_perror(pcap,0);
                pcap_close(pcap);
                exit(1);
        }

	read_hdr->var_id = w4w.var_id + 4;

	if (pcap_inject(pcap, buffer, length) == -1) {
                pcap_perror(pcap,0);
                pcap_close(pcap);
                exit(1);
        }
	pcap_loop(pcap, 5, resp_handler, (u_char *)&w4w); 
	fprintf(stdout, "--------------------------------------\n");
	exit(1);
	   }
	}
        if (w4w.cmd == WMP4WARP_RUN_ABS) {
            struct wmp4warp_header_run_abs *run_hdr =
                (struct wmp4warp_header_run_abs *) (buffer + sizeof(struct packet_header) + sizeof(struct wmp4warp_header_common));

            run_hdr->fsm_id = w4w.fsm_id;
            run_hdr->ts = w4w.run_ts;
        }


        if (pcap_inject(pcap, buffer, length) == -1) {
                pcap_perror(pcap,0);
                pcap_close(pcap);
                exit(1);
        }
        
        if (w4w.cmd == WMP4WARP_ECHO_REQ_CMD){
        	pcap_loop(pcap, -1, resp_handler, (u_char *)&w4w);
        }
        else{
        	pcap_loop(pcap, 1, resp_handler, (u_char *)&w4w);
        }
	
        return 0;
}

char* print_fsm_bin(const char *filename)
{

        char *buffer = NULL;
        size_t len = 0;
        ssize_t read = 0;
        int counter = 0;
        int k, c;
        FILE *of = NULL;
	FILE *in_f = NULL;
        uint8_t bc[MAX_BC_LENGTH] = {0,};
        char next_byte_str[5];
	char buff[50];
	char *out_file_name = NULL;

        sprintf(buff, "warp_%s", filename);
	out_file_name = buff;
	
        of = fopen(out_file_name, "wb");
	clear(filename);
	in_f = fopen("tmp.txt", "r");

        if (!of) {
                fprintf(stderr, "Error while opening %s\n", out_file_name);
                exit(-1);
        }

	if (!in_f) {
                fprintf(stderr, "Error while opening input_file\n");
                exit(-1);
        }
        while ((read = getline(&buffer, &len, in_f)) != -1) {
                if ((strlen(buffer) - 1) % 2) {
                        printf("OPSSSSS %s\n\n", buffer);
                        exit(1);
                }

                for (k = 0; k < (strlen(buffer) - 1); k += 2) {
//                        printf(" 0x%c%c,", buffer[k], buffer[k + 1]);
                        sprintf(next_byte_str, "0x%c%c", buffer[k], buffer[k + 1]);
                        sscanf(next_byte_str, "%x", (unsigned int *)&bc[counter]);
                        counter++;
                        if (!(counter % 10)) {
//                                printf("\n");
                        }
                }


        }

        fwrite(bc, sizeof(bc[0]), counter, of);

//        printf("\n\nTot byte: %d\n", counter);

        fclose(of);
	remove("tmp.txt");
        return out_file_name;
}

int clear(const char *filename){


	char line[256];
	char sub_line[256];
	char save_state[4];
	int i;

        FILE *file_input = fopen (filename, "r");
        FILE *file_output = fopen ("tmp.txt", "w+");
    
	if (file_input == NULL){
	printf("Error\n");
	exit(1);
	}

	if (file_output == NULL){
	printf("Error2\n");
	exit(1);
	}

	while(!feof(file_input)){
	 fgets(line, 256, file_input);
	 strncpy(sub_line, line, 6);
	 sub_line[6]='\0';

	 if (line[0]=='#'||line[0]=='\n')
		continue;
	  else{
	   fprintf(file_output,"%s", line);
	   if(!strcmp(sub_line, "000004")){
		fgets(line, 256, file_input);
		strncpy(save_state, line, 4);
		save_state[4]='\0';
		fprintf(file_output, "%s\n", save_state);
		}
	   else if(!strcmp(sub_line, "000010")){
		fgets(line, 256, file_input);
		strncpy(save_state, line, 4);
		save_state[4]='\0';
		fprintf(file_output, "%s\n", save_state);
		}
	   else if(!strcmp(sub_line, "000006")){
		fgets(line, 256, file_input);
		for(i=0; i<256; i++){
			if (line[i]=='$'){
			line[i]='\0';
			continue;
			}
		}
		fprintf(file_output, "%s\n", line);
	   }
	  }	
	}
	fclose(file_output);
    return 0;
}

