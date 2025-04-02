//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_simultaneous_wr_rd_data_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_SIMULTANEOUS_WR_RD_DATA_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_SIMULTANEOUS_WR_RD_DATA_SEQUENCE_SV

class synch_fifo_simultaneous_wr_rd_data_sequence extends synch_fifo_base_sequence;
  
  `uvm_object_utils(synch_fifo_simultaneous_wr_rd_data_sequence)      
  
   synch_fifo_transaction trans;
  
   extern function new(string name="synch_fifo_simultaneous_wr_rd_data_sequence");
  
   extern task body();
  
endclass: synch_fifo_simultaneous_wr_rd_data_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_simultaneous_wr_rd_data_sequence::new(string name="synch_fifo_simultaneous_wr_rd_data_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_simultaneous_wr_rd_data_sequence::body();
  
  trans=synch_fifo_transaction::type_id::create("trans");
  
  repeat(30) begin
  start_item(trans);
     
     // Randomize the transaction item independently for re and we
    /* trans.randomize with {
                           // Randomize read enable (re) and write enable (we) independently
                           re == $urandom_range(0, 1);  // Randomize read enable (0 or 1)
                           we == $urandom_range(0, 1);  // Randomize write enable (0 or 1)
                          }; */
    
    // Randomize re and we before applying the transaction
    trans.re = $urandom_range(0, 1);  // Randomize read enable (0 or 1)
    trans.we = $urandom_range(0, 1);  // Randomize write enable (0 or 1)

    // Apply the randomized values to the transaction item
    trans.randomize();  // Now you can randomize the transaction item with other constraints if necessary
  
  finish_item(trans);
  end
  
endtask:body
     

`endif //GUARD_SYNCH_FIFO_SIMULTANEOUS_WR_RD_DATA_SEQUENCE_SV