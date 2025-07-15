#ifndef PUF_DRIVER_H
#define PUF_DRIVER_H

#include <stdint.h>

#define PUF_BASEADDR XPAR_MULTI_INSTANCE_APUF_0_BASEADDR  // Replace with the correct base address

#define PUF_PULSE_REG_OFFSET 0x0000
#define PUF_CHALLENGE_REG_OFFSET1 0x0010
#define PUF_CHALLENGE_REG_OFFSET2 0x0020
#define PUF_CHALLENGE_REG_OFFSET3 0x0030
#define PUF_CHALLENGE_REG_OFFSET4 0x0040
#define PUF_RESPONSE_REG_OFFSET1  0x10
#define PUF_RESPONSE_REG_OFFSET2  0x20

typedef unsigned long u32;
typedef unsigned long long u64;


void write_challenge(u64 challenge1,u64 challenge2);
u64 read_response();

#endif  // PUF_DRIVER_H
