

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
    u32 challenge_array[chall_number]={
    		}; //=0x12A1265E41111472;// 0x6F30BBF444111454;  12A1165E// Example 32-bit challenge

 //   */
    //    u64 ichallenge;
//    u64 challenge_array=0xA427C40A300E0F92;
    u32 oresponse;              // Output response 64-64:0x72FDFE47


    for (int i=0; i<chall_number ; i++) {

    	write_challenge(challenge_array[i]);

    	oresponse = read_response();

   // 	printf("Challenge: 0x%016llX\n", challenge_array[i]);
    	printf(" 0x%08X\n", oresponse);
    	for (volatile int delay = 0; delay < 500000; delay++);

    }


   // printf("\n\n");
    cleanup_platform();
    return 0;
}
