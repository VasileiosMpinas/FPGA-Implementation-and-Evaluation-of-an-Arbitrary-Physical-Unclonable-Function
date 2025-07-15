

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "puf_driver.h"

#define chall_number 400


int main()
{
    init_platform();
    u64 challenge_array[chall_number]={0xA7808D288B771F80,
    		0x4FAD8CD61663915A,
    		0x20D14C52E36B21F6,
    		0xC41F19EAC4840167,
    		0x953553131A09D648,
    		0x04116CB50A1A033F,
    		};

    u64 oresponse;


    for (int i=0; i<chall_number ; i++) {

    	write_challenge(challenge_array[i]);

    	oresponse = read_response();

    	printf(" 0x%016llX\n", oresponse);
    	for (volatile int delay = 0; delay < 500000; delay++);

    }


    cleanup_platform();
    return 0;
}
