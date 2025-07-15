`timescale 1ns / 1ps

(* dont_touch = "yes" *)
module delay_line
#(parameter C_LENGTH=32)(
input ipulse,
input [C_LENGTH - 1 : 0] challenge,
output out_1,
output out_2

    );

    wire  [C_LENGTH - 1 : 0] net; 
    wire  [C_LENGTH - 1 : 0] net2;
    assign net [0] =ipulse;
    assign net2 [0] =ipulse;
      
    generate
    genvar i;
    for (i =0; i < C_LENGTH-1; i = i +1)
    begin
    
    (* dont_touch = "yes" *) 
     mux inst_mux_1(
    .ia(net[i]),
    .ib(net2[i]),
    .sel(challenge[i]),
    .out(net[i+1])
    );
    

    (* dont_touch = "yes" *) 
     mux inst_mux_2(
    .ia(net2[i]),
    .ib(net[i]),
    .sel(challenge[i]),
    .out(net2[i+1])
    );
    // Fake XOR operation
   (* dont_touch = "yes" *) wire temp;
    assign temp = net[i] ^ net2[i];
    end
           
    endgenerate
     
    generate
    (* dont_touch = "yes" *) 
    mux inst_mux_1(
    .ia(net[C_LENGTH-1]),
    .ib(net2[C_LENGTH-1]),
    .sel(challenge[C_LENGTH-1]),
    .out(out_1)
    );
    
    (* dont_touch = "yes" *) 
     mux inst_mux_2(
    .ia(net2[C_LENGTH-1]),
    .ib(net[C_LENGTH-1]),
    .sel(challenge[C_LENGTH-1]),
    .out(out_2)
    );
     // Fake XOR operation
   (* dont_touch = "yes" *) wire temp1;
   (* dont_touch = "yes" *) wire temp2;
   assign temp1 = net[C_LENGTH-1] ^ net2[C_LENGTH-1];
   assign temp2 = out_1 ^ out_2;
    endgenerate
   
endmodule
