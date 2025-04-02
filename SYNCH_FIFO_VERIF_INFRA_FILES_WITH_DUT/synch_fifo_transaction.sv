//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_transaction.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_TRANSACTION_SV
`define GUARD_SYNCH_FIFO_TRANSACTION_SV

class synch_fifo_transaction extends uvm_sequence_item;
   
   parameter DATA_WIDTH=32;
   parameter ADDR_WIDTH=3;
  
   rand bit re;
   rand bit we;
   rand bit [DATA_WIDTH-1:0]data_in;
   bit [DATA_WIDTH-1:0]data_out;
   bit empty;
   bit full;
   //logic reset;

   constraint c_indata{data_in inside{[0:25]};} // we can change the range also , for ex: 0 to 255
  
   constraint ctrl{soft re inside {0,1}; 
                        we inside {0,1};
                  }


   `uvm_object_utils_begin(synch_fifo_transaction)
     `uvm_field_int(re,UVM_ALL_ON)
     `uvm_field_int(we,UVM_ALL_ON)
     `uvm_field_int(data_in,UVM_ALL_ON)
     `uvm_field_int(data_out,UVM_ALL_ON)
     `uvm_field_int(empty,UVM_ALL_ON)
     `uvm_field_int(full,UVM_ALL_ON)
     //`uvm_field_int(reset ,UVM_ALL_ON)
   `uvm_object_utils_end

   // Constructor
   extern function new(string name="synch_fifo_transaction");
    

endclass :synch_fifo_transaction

//===================================================================================
// New
//===================================================================================
function synch_fifo_transaction::new(string name="synch_fifo_transaction");
    super.new(name);
endfunction :new


`endif //GUARD_SYNCH_FIFO_TRANSACTION_SV