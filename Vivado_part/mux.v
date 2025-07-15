`timescale 1ns / 1ps

(* dont_touch = "yes" *)
module mux
#(parameter ID = 0)(
    input ia,
    input ib,
    input sel,
    output out
    );
    assign out = (sel) ? ia : ib;
endmodule

