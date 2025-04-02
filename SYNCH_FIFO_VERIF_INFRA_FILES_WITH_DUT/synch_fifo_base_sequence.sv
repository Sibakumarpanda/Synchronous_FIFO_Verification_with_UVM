//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_base_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_BASE_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_BASE_SEQUENCE_SV

class synch_fifo_base_sequence extends uvm_sequence#(synch_fifo_transaction);
 
  `uvm_object_utils(synch_fifo_base_sequence)            
  
   synch_fifo_transaction trans;
  
   // constructor
   extern function new(string name="synch_fifo_base_sequence");
   // task
   extern virtual task body();  
  
endclass:synch_fifo_base_sequence

//===================================================================================
// New
//===================================================================================

function synch_fifo_base_sequence::new(string name="synch_fifo_base_sequence");  
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_base_sequence::body();
    
endtask:body


`endif //GUARD_SYNCH_FIFO_BASE_SEQUENCE_SV