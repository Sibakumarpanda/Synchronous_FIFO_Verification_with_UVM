//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_with_diff_datawidth_depth_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : Sequence to Write data and read them back from FIFO with different Datawidth (64) and FIFO Depth (16). SO ADDR_WIDTH=4
// NOTE    : To check this scenario -> at present the FIFO RTL/DUT is parameterized with a data width of 32 bits, so it is hardcoded to handle 32-bit data. 
//           If you want to test the FIFO with 64-bit data width, the RTL design would also need to be updated to support a 64-bit data width
// Author  : Siba Kumar Panda
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_WITH_DIFFERENT_DATAWIDTH_AND_FIFO_DEPTH_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_WITH_DIFFERENT_DATAWIDTH_AND_FIFO_DEPTH_SEQUENCE_SV

class synch_fifo_with_diff_datawidth_depth_sequence #(int DATA_WIDTH = 64 ,ADDR_WIDTH = 4) extends synch_fifo_base_sequence;
  
  `uvm_object_utils(synch_fifo_with_diff_datawidth_depth_sequence)      
  
   synch_fifo_transaction #(DATA_WIDTH ,ADDR_WIDTH) trans;   // Parameterize the transaction with data width
  
   extern function new(string name="synch_fifo_with_diff_datawidth_depth_sequence");
  
   extern task body();
  
endclass: synch_fifo_with_diff_datawidth_depth_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_with_diff_datawidth_depth_sequence::new(string name="synch_fifo_with_diff_datawidth_depth_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_with_diff_datawidth_depth_sequence::body();
  
  trans=synch_fifo_transaction #(DATA_WIDTH , ADDR_WIDTH)::type_id::create("trans");
  repeat(30) begin
  start_item(trans);
    
     trans.randomize with {
                              re==1;
                              we==1;
                                 };
  
  finish_item(trans);
  end
  
endtask:body

`endif //GUARD_SYNCH_FIFO_WITH_DIFFERENT_DATAWIDTH_AND_FIFO_DEPTH_SEQUENCE_SV
     

     