`timescale 1ns / 1ps

(* dont_touch = "yes" *)
module arbiter_puf
#(parameter C_LENGTH=32, ID = 0)(
input ipulse,
input [C_LENGTH-1:0] challenge,
output response

    );
    wire delay_line_out_1; 
    wire delay_line_out_2; 
    
    (* dont_touch = "yes" *)
    delay_line  #(
        .C_LENGTH(C_LENGTH)
    ) inst_delay_line (
    .ipulse(ipulse),
    .challenge(challenge),
    .out_1(delay_line_out_1),
    .out_2(delay_line_out_2)
    );
   (* dont_touch = "yes" *)
    dff inst_dff1 (
    .id(odelay_line_out_1),
    .clk(odelay_line_out_2),
    .oq(response)
    );    
endmodule
