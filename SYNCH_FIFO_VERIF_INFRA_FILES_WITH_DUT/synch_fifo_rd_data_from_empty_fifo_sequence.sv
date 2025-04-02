//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_rd_data_from_empty_fifo_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_RD_DATA_FROM_EMPTY_FIFO_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_RD_DATA_FROM_EMPTY_FIFO_SEQUENCE_SV

class synch_fifo_rd_data_from_empty_fifo_sequence extends synch_fifo_base_sequence;
  
  `uvm_object_utils(synch_fifo_rd_data_from_empty_fifo_sequence)      
  
   synch_fifo_transaction trans;
  
   extern function new(string name="synch_fifo_rd_data_from_empty_fifo_sequence");
  
   extern task body();
  
endclass: synch_fifo_rd_data_from_empty_fifo_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_rd_data_from_empty_fifo_sequence::new(string name="synch_fifo_rd_data_from_empty_fifo_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_rd_data_from_empty_fifo_sequence::body();
  
    trans=synch_fifo_transaction::type_id::create("trans");
  
    // Read data from Empty FIFO 
    repeat(10) begin
      start_item(trans);
      trans.randomize with {
                           re == 1;
                           we == 0;
                          
                          };
      
    finish_item(trans);
      `uvm_info("SEQUENCE_TRANSACTION_COUNT", "Read transaction from Empty FIFO completed", UVM_NONE);
      
    end
  
    // Writing data into the FIFO after testing the empty read scenario is not necessary for the underflow test .
    // But but it can be part of a broader test sequence to verify normal operation after handling an empty condition.
    // Hence now , Write data and read them back from FIFO to verify data integrity
    repeat(10) begin
      start_item(trans);
      trans.randomize with {
                           re == 1;
                           we == 1;
                           };
      finish_item(trans);
      `uvm_info("SEQUENCE_TRANSACTION_COUNT", "Write data and Read back transactions completed", UVM_NONE);
    end
  
endtask:body

`endif //GUARD_SYNCH_FIFO_RD_DATA_FROM_EMPTY_FIFO_SEQUENCE_SV
     
