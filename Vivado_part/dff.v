`timescale 1ns / 1ps

(* dont_touch = "yes" *)
module dff(
    input id,
    input clk,
    output reg oq
    );
    

    always @ (posedge clk)  
    begin 
        oq <= id;
    end
endmodule

