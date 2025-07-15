`timescale 1ns / 1ps

(* dont_touch = "yes" *)
module Multi_instance_APUF
#(parameter C_LENGTH=64,
  parameter R_LENGTH=64)(
    input ipulse,
    input [C_LENGTH-1 : 0] challenge,
    output [R_LENGTH - 1 : 0] response
    );
    
 //   (* dont_touch = "yes" *) wire temp;
    
    generate
    genvar i;
    for (i =0; i < R_LENGTH; i = i +1) 
    begin
    (* dont_touch = "yes" *)
    arbiter_puf #(.ID(i),.C_LENGTH(C_LENGTH)) inst_arbiter_puf(
        .ipulse(ipulse),
        .challenge(challenge),
        .response(response[i])
    );
    
    end
           
    endgenerate
 
endmodule
