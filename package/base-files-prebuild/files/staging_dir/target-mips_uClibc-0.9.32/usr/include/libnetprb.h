
#include "netprb_file_path.h"

typedef struct netmap_rec_s {
	char mac[18];
	char name[33];
	char type[5];
} netmap_rec_t;

#define CHANGE_NAME 1 << 1
#define CHANGE_TYPE 1 << 2

void netprb_updtae_netmap_record(char *mac, int option, char *devname, char *hosttype);
int netprb_value_from_record(char *mac, char *name, int *hosttype);
bool netprb_record_exist(char *mac);
