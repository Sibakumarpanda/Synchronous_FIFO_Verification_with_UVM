//-----------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_wr_data_to_full_fifo_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : To test a synchronous FIFO by writing data until it is full and then performing read operations
// Author  : Siba Kumar Panda
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_WR_DATA_TO_FULL_FIFO_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_WR_DATA_TO_FULL_FIFO_SEQUENCE_SV

class synch_fifo_wr_data_to_full_fifo_sequence extends synch_fifo_base_sequence;
  
  `uvm_object_utils(synch_fifo_wr_data_to_full_fifo_sequence)      
  
   synch_fifo_transaction trans;
  
   extern function new(string name="synch_fifo_wr_data_to_full_fifo_sequence");
  
   extern task body();
  
endclass: synch_fifo_wr_data_to_full_fifo_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_wr_data_to_full_fifo_sequence::new(string name="synch_fifo_wr_data_to_full_fifo_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_wr_data_to_full_fifo_sequence::body();
  
    trans=synch_fifo_transaction::type_id::create("trans");
  
    // Write to FIFO until full
    repeat(10) begin
      start_item(trans);
      trans.randomize with {
                           re == 0;
                           we == 1;
                          // Add any data randomization if needed
                          };
      
    finish_item(trans);
    `uvm_info("SEQUENCE_TRANSACTION_COUNT", "Write transaction completed", UVM_NONE);
      
    end

    // Attempt to write one more item to test overflow handling
    start_item(trans);
    trans.randomize with {
                         re == 0;
                         we == 1;
                         // Add any data randomization if needed
                         };
    finish_item(trans);
    `uvm_info("SEQUENCE_TRANSACTION_COUNT", "Attempted to write beyond FIFO capacity", UVM_NONE);

    // Read from FIFO to verify data integrity
    repeat(10) begin
      start_item(trans);
      trans.randomize with {
                           re == 1;
                           we == 0;
                           };
      finish_item(trans);
      `uvm_info("SEQUENCE_TRANSACTION_COUNT", "Read transaction completed", UVM_NONE);
    end
  
  
  
endtask:body

`endif //GUARD_SYNCH_FIFO_WR_DATA_TO_FULL_FIFO_SEQUENCE_SV
     
