//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_interface.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_INTERFACE_SV
`define GUARD_SYNCH_FIFO_INTERFACE_SV

interface synch_fifo_interface(input logic clk,reset);
   
   parameter DATA_WIDTH=32;
   parameter ADDR_WIDTH=3;
  
   logic re;
   logic we;
   logic [DATA_WIDTH-1:0]data_in;
   logic [DATA_WIDTH-1:0]data_out;
   logic full;
   logic empty;

   clocking driver_cb@(posedge clk);
      input data_out;
      input full;
      input empty;
      output re;
      output we;
      output data_in;
   endclocking
  
   modport driver_mp(clocking driver_cb,input clk,reset);

   clocking monitor_cb@(posedge clk);
      input data_out;
      input full;
      input empty;
      input re;
      input we;
      input data_in;
   endclocking
     
   modport monitor_mp(clocking monitor_cb,input clk,reset);

endinterface :synch_fifo_interface
     
`endif //GUARD_SYNCH_FIFO_INTERFACE_SV