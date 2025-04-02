//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_wr_rd_data_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : Write data and read them back from FIFO
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_WR_RD_DATA_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_WR_RD_DATA_SEQUENCE_SV

class synch_fifo_wr_rd_data_sequence extends synch_fifo_base_sequence;
  
  `uvm_object_utils(synch_fifo_wr_rd_data_sequence)      
  
   synch_fifo_transaction trans;
  
   extern function new(string name="synch_fifo_wr_rd_data_sequence");
  
   extern task body();
  
endclass: synch_fifo_wr_rd_data_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_wr_rd_data_sequence::new(string name="synch_fifo_wr_rd_data_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_wr_rd_data_sequence::body();
  
  trans=synch_fifo_transaction::type_id::create("trans");
  repeat(30) begin
  start_item(trans);
    
     trans.randomize with {
                              re==1;
                              we==1;
                                 };
  
  finish_item(trans);
  end
  
endtask:body

`endif //GUARD_SYNCH_FIFO_WR_RD_DATA_SEQUENCE_SV