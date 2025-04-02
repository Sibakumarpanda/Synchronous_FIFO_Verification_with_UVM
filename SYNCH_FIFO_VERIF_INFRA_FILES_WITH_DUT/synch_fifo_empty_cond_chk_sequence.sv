//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_empty_cond_chk_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_EMPTY_COND_CHK_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_EMPTY_COND_CHK_SEQUENCE_SV

class synch_fifo_empty_cond_chk_sequence extends synch_fifo_base_sequence;
  
  `uvm_object_utils(synch_fifo_empty_cond_chk_sequence)      
  
   synch_fifo_transaction trans;
  
   extern function new(string name="synch_fifo_empty_cond_chk_sequence");
  
   extern task body();
  
endclass: synch_fifo_empty_cond_chk_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_empty_cond_chk_sequence::new(string name="synch_fifo_empty_cond_chk_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_empty_cond_chk_sequence::body();
  
  trans=synch_fifo_transaction::type_id::create("trans");
  
  repeat(10) begin
     start_item(trans);
    
        trans.randomize with {
                              re==1;
                              we==0;
                                 };
  
     finish_item(trans);
    `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
  end
  
  repeat(20) begin
     start_item(trans);
    
         trans.randomize with {
                              re==1;
                              we==1;
                                 };
  
     finish_item(trans);
    `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
  end
  
endtask:body

`endif //GUARD_SYNCH_FIFO_EMPTY_COND_CHK_SEQUENCE_SV
     
 