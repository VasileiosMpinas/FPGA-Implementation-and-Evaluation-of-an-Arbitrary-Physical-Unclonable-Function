#ifndef PUF_DRIVER_H
#define PUF_DRIVER_H

#include <stdint.h>

#define PUF_BASEADDR XPAR_MULTI_INSTANCE_APUF_0_BASEADDR  // Replace with the correct base address

#define PUF_PULSE_REG_OFFSET 0x00
#define PUF_CHALLENGE_REG_OFFSET1 0x04
#define PUF_CHALLENGE_REG_OFFSET2 0x18
#define PUF_RESPONSE_REG_OFFSET1  0x08
#define PUF_RESPONSE_REG_OFFSET2  0x20

typedef unsigned long u32;
typedef unsigned long long u64;


void write_challenge(u32 challenge);
u32 read_response();

#endif  // PUF_DRIVER_H
