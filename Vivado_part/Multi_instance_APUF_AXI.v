module Multi_instance_APUF_AXI #(
    parameter C_LENGTH = 64,  // Length of challenge in bits
    parameter R_LENGTH = 64
)(
    input wire        S_AXI_ACLK,      // AXI Clock
    input wire        S_AXI_ARESETN,   // AXI Reset 
    input wire [31:0] S_AXI_AWADDR,    // Write Address
    input wire        S_AXI_AWVALID,   // Write Address Valid
    output reg        S_AXI_AWREADY,   // Write Address Ready  
    input wire [31:0] S_AXI_WDATA,     // Write Data
    input wire [3:0]  S_AXI_WSTRB,     // Write Strobes
    input wire        S_AXI_WVALID,    // Write Data Valid
    output reg        S_AXI_WREADY,    // Write Data Ready
    output reg [1:0]  S_AXI_BRESP,     // Write Response
    output reg        S_AXI_BVALID,    // Write Response Valid
    input wire        S_AXI_BREADY,    // Write Response Ready
    input wire [31:0] S_AXI_ARADDR,    // Read Address
    input wire        S_AXI_ARVALID,   // Read Address Valid
    output reg        S_AXI_ARREADY,   // Read Address Ready
    output reg [31:0] S_AXI_RDATA,     // Read Data
    output reg [1:0]  S_AXI_RRESP,     // Read Response
    output reg        S_AXI_RVALID,    // Read Data Valid
    input wire        S_AXI_RREADY     // Read Data Ready
);

    // Internal Registers
    reg reg_ipulse;                         // Pulse signal to trigger the PUF
    reg [C_LENGTH-1:0] reg_challenge;      // Challenge register
    reg [R_LENGTH-1:0] reg_response;       // Response register
    
    wire [R_LENGTH - 1:0] wire_response;
    wire [R_LENGTH - 1:0] wire_responsen;

    // AXI Write Address Ready
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_AWREADY <= 1'b0;
        end else begin
            S_AXI_AWREADY <= S_AXI_AWVALID && !S_AXI_AWREADY;
        end
    end

    // AXI Write Data Ready
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_WREADY <= 1'b0;
        end else begin
            S_AXI_WREADY <= S_AXI_WVALID && !S_AXI_WREADY;
        end
    end

    // AXI Write Operation
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            reg_ipulse <= 1'b0;
            reg_challenge <= 0;
        end  else if (S_AXI_WVALID && S_AXI_AWVALID && S_AXI_WREADY & C_LENGTH<=32) begin
            case (S_AXI_AWADDR[3:0])
                4'h0: reg_ipulse <= S_AXI_WDATA[0]; 
                4'h4: reg_challenge[C_LENGTH-1:0] <= S_AXI_WDATA[C_LENGTH-1:0];
                default: ;
            endcase 
        end else if (S_AXI_WVALID && S_AXI_AWVALID && S_AXI_WREADY & C_LENGTH==64) begin
            case (S_AXI_AWADDR[7:0])
                8'h00: reg_ipulse <= S_AXI_WDATA[0];
                8'h08: reg_challenge[31:0] <= S_AXI_WDATA;
                8'h18: reg_challenge[63:32] <= S_AXI_WDATA;
                default: ;
            endcase
        end else if (S_AXI_WVALID && S_AXI_AWVALID && S_AXI_WREADY & C_LENGTH==128) begin
            case (S_AXI_AWADDR[15:0])
                16'h0000: reg_ipulse <= S_AXI_WDATA[0]; 
                16'h0010: reg_challenge[31:0] <= S_AXI_WDATA;
                16'h0020: reg_challenge[63:32] <= S_AXI_WDATA;
                16'h0030: reg_challenge[95:64] <= S_AXI_WDATA;
                16'h0040: reg_challenge[127:96] <= S_AXI_WDATA;
                default: ;
            endcase
        end
    end

    // AXI Write Response
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_BVALID <= 1'b0;
            S_AXI_BRESP <= 2'b00; // OKAY
        end else if (S_AXI_WREADY && S_AXI_WVALID && !S_AXI_BVALID) begin
            S_AXI_BVALID <= 1'b1;
            S_AXI_BRESP <= 2'b00; // OKAY
        end else if (S_AXI_BREADY) begin
            S_AXI_BVALID <= 1'b0;
        end
    end

    // AXI Read Address Ready
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_ARREADY <= 1'b0;
        end else begin
            S_AXI_ARREADY <= S_AXI_ARVALID && !S_AXI_ARREADY;
        end
    end

    // AXI Read Data
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_RVALID <= 1'b0;
            S_AXI_RRESP <= 2'b00; // OKAY
        end  else if (S_AXI_ARVALID && S_AXI_ARREADY && !S_AXI_RVALID & R_LENGTH<=32) begin
            S_AXI_RVALID <= 1'b1;
            case (S_AXI_ARADDR[3:0])
                4'h8: S_AXI_RDATA[R_LENGTH-1:0] <= reg_response[R_LENGTH-1:0]; 
                default: S_AXI_RDATA <= 32'h0;
            endcase
        end else if (S_AXI_ARVALID && S_AXI_ARREADY && !S_AXI_RVALID & R_LENGTH==64) begin
            S_AXI_RVALID <= 1'b1;
            case (S_AXI_ARADDR[7:0])
                8'h10: S_AXI_RDATA <= reg_response[31:0];
                8'h20: S_AXI_RDATA <= reg_response[63:32]; 
                default: S_AXI_RDATA <= 32'h0;
            endcase
        end else if (S_AXI_ARVALID && S_AXI_ARREADY && !S_AXI_RVALID & R_LENGTH==128) begin
            S_AXI_RVALID <= 1'b1;
            case (S_AXI_ARADDR[7:0])
                16'h0050: S_AXI_RDATA <= reg_response[31:0]; 
                16'h0060: S_AXI_RDATA <= reg_response[63:32]; 
                16'h0070: S_AXI_RDATA <= reg_response[95:64]; 
                16'h0080: S_AXI_RDATA <= reg_response[127:96]; 
                default: S_AXI_RDATA <= 32'h0;
            endcase
        end else if (S_AXI_RREADY) begin
            S_AXI_RVALID <= 1'b0;
        end
    end
    
    
    always @(posedge S_AXI_ACLK) begin
    if (!S_AXI_ARESETN) begin
        reg_response <= 0;
    end else begin
        reg_response <= wire_response;
    end
    end

    // Instantiate PUF Module
    Multi_instance_APUF #(
        .C_LENGTH(C_LENGTH),
        .R_LENGTH(R_LENGTH)
    ) puf_instance (
        .ipulse(reg_ipulse), 
        .challenge(reg_challenge),
        .response(wire_response)
    );

endmodule
