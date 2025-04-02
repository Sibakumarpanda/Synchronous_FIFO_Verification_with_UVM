//----------------------------------------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : design.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : RTL/DUT file
// Author  : Siba Kumar Panda
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Synchronous FIFO Design Specification Details :
// data input width = 32 bit, data output width = 32bit 
// address width = 3, Hence FIFO Depth=2^(address width)= 8
// The width of the write and read pointer = log2(Depth of FIFO)= log2(8)=3bits
// Hence FIFO Memory will be 32x8
// synchronous with clk
// rdn_wr signal -> when rdn_wr=0 means read rdn_wr=1 means write
// reset signal used -> active low reset, means when reset=1, dut will be in functional , reset=0, dut will be reset
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module synch_fifo_dut(clk,reset,re,we,data_in,data_out,full,empty);
  
  parameter DATA_WIDTH=32;
  parameter ADDR_WIDTH=3;
  
  input clk,reset;
  input re, we;
  //input [31:0]data_in; //32bit
  input [DATA_WIDTH-1:0]data_in;
  output full,empty;  
  //output reg [31:0]data_out; //32bit
  output reg [DATA_WIDTH-1:0]data_out; 
  
  reg [ADDR_WIDTH-1:0] waddr; //3bit-write pointer address
  reg [ADDR_WIDTH-1:0] raddr; //3bit-read pointer address
  //reg [31:0] mem [8];
  reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH-1):0];  //Memory= width x Depth=32 x8
  
    
always @ (posedge clk, negedge reset)  begin
  if (reset == 0) begin //active low reset
      mem[0] <= 16'bx;
      mem[1] <= 16'bx;
      mem[2] <= 16'bx;
      mem[3] <= 16'bx;
      mem[4] <= 16'bx;
      mem[5] <= 16'bx;
      mem[6] <= 16'bx;
      mem[7] <= 16'bx;
      waddr <= 0;
    end 
  else if(we == 1 && !full) begin    //To write data to FIFO
      mem[waddr] <= data_in;
      waddr <= waddr + 1;
    end

end

always @ (posedge clk, negedge reset)  begin
    if (reset == 0) begin
      mem[0] <= 16'bx;
      mem[1] <= 16'bx;
      mem[2] <= 16'bx;
      mem[3] <= 16'bx;
      mem[4] <= 16'bx;
      mem[5] <= 16'bx;
      mem[6] <= 16'bx;
      mem[7] <= 16'bx;
      raddr <= 0;
    end 
   else if(re == 1 && !empty) begin  // To read data from FIFO
      data_out <= mem[raddr];
      raddr <= raddr + 1;
    end
end

assign full=(waddr-raddr==7 || waddr-raddr==(-7))?1:0;
assign empty=(waddr-raddr==0)?1:0; //FIFO will be empty when write pointer address is equals to Read pointer address
                                   //Means, w_ptr == r_ptr i.e. write and read pointers/address has the same value.

endmodule :synch_fifo_dut