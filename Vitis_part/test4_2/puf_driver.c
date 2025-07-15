#include "puf_driver.h"
#include "xil_io.h"  // Xilinx I/O functions
#include "xparameters.h"  // For PUF base address definition

void write_challenge(u32 challenge) {
	u32 challenge_low, challenge_high;
	challenge_low=challenge;
//	challenge_high=challenge>>32;

    Xil_Out32(PUF_BASEADDR + PUF_CHALLENGE_REG_OFFSET1, challenge_low);
//    Xil_Out32(PUF_BASEADDR + PUF_CHALLENGE_REG_OFFSET2, challenge_high);
    Xil_Out32(PUF_BASEADDR + PUF_PULSE_REG_OFFSET, 1);
    for (volatile int delay = 0; delay < 10000; delay++);
    Xil_Out32(PUF_BASEADDR + PUF_PULSE_REG_OFFSET, 0);
}

u32 read_response() {
	u64 response_low, response_high;

	response_low = Xil_In32(PUF_BASEADDR + PUF_RESPONSE_REG_OFFSET1);
//	response_high= Xil_In32(PUF_BASEADDR + PUF_RESPONSE_REG_OFFSET2);
	//   printf("OResponse:  0x%016llX\n", oresponse);

    return response_low;//(response_high<<32) | response_low;
}





