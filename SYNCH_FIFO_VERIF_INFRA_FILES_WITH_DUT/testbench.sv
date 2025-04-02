//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : testbench.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : tb_top file
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "synch_fifo_interface.sv"
`include "synch_fifo_package.sv"
`include "synch_fifo_assertion.sv"

module tb_top;
  
  import uvm_pkg::*;
  import synch_fifo_package::*;

  bit clk;
  bit reset;

  synch_fifo_interface intf_h(.clk(clk),.reset(reset));

  synch_fifo_dut DUT(
     .clk(clk),
     .reset(reset),
     .re(intf_h.re),
     .we(intf_h.we),
     .data_in(intf_h.data_in),
     .data_out(intf_h.data_out),
     .full(intf_h.full),
     .empty(intf_h.empty)
   );
  
  

  initial begin
     uvm_config_db#(virtual synch_fifo_interface)::set(null,"*","vintf",intf_h);
  end


  initial begin
     clk=0;
     forever #5 clk=~clk;
  end

 initial begin
    reset=0;
    #20
    reset=1;
  end 

  initial begin
    //run_test("synch_fifo_base_test");
    run_test("synch_fifo_wr_rd_data_test");
    //run_test("synch_fifo_full_cond_chk_test");
    //run_test("synch_fifo_empty_cond_chk_test");
    //run_test("synch_fifo_wr_data_to_full_fifo_test");
    //run_test("synch_fifo_rd_data_from_empty_fifo_test");
    //run_test("synch_fifo_simultaneous_wr_rd_data_test");
    //run_test("synch_fifo_with_diff_datawidth_depth_test");
    //run_test("synch_fifo_op_chk_single_clock_domain_test");
    
    
  end
  
  initial begin
  	$dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  // bind assertions inside tb_top file as like below format
  // Syntax : bind DUT_modulename assertion_modulename assertion_instant (all input variables);
  
  //bind synch_fifo_dut synch_fifo_assertion assert_inst (clk,reset,re,we,data_in,full,empty);




endmodule :tb_top