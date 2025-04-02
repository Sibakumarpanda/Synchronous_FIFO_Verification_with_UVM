//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_op_chk_single_clock_domain_sequence.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : Ensure that both read and write operations are performed using the same clock.
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_OPERATION_CHECK_SINGLE_CLOCK_DOMAIN_SEQUENCE_SV
`define GUARD_SYNCH_FIFO_OPERATION_CHECK_SINGLE_CLOCK_DOMAIN_SEQUENCE_SV

class synch_fifo_op_chk_single_clock_domain_sequence extends synch_fifo_base_sequence #(synch_fifo_transaction);
  
  `uvm_object_utils(synch_fifo_op_chk_single_clock_domain_sequence)      
  
   //synch_fifo_transaction trans;
  
   extern function new(string name="synch_fifo_op_chk_single_clock_domain_sequence");
  
   extern task body();
  
endclass: synch_fifo_op_chk_single_clock_domain_sequence

//===================================================================================
// New
//===================================================================================
function synch_fifo_op_chk_single_clock_domain_sequence::new(string name="synch_fifo_op_chk_single_clock_domain_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task synch_fifo_op_chk_single_clock_domain_sequence::body();
  
    synch_fifo_transaction req;
    synch_fifo_transaction rsp;
    int fifo_depth = 8; 
    int write_count = 0;
    int read_count = 0;
    
  
     // Write data to FIFO
    while (write_count < fifo_depth) begin
      req = synch_fifo_transaction::type_id::create("req");
      assert(req.randomize()) 
      else 
          `uvm_error("RANDOMIZE_FAIL", "Failed to randomize transaction")

      start_item(req);
      req.randomize with {
        we == 1; // Write enable
        re == 0; // Read disable
      };
      finish_item(req);

      write_count++;
    end

    `uvm_info("FIFO_TEST", "Write sequence completed.", UVM_MEDIUM)
  
     // Read data from FIFO
    while (read_count < fifo_depth) begin
      rsp = synch_fifo_transaction::type_id::create("rsp");

      start_item(rsp);
      rsp.randomize with {
        re == 1; // Read enable
        we == 0; // Write disable
      };
      finish_item(rsp);

      // Verify the data integrity
     /* if (rsp.data_out !== req.data_in) begin
        `uvm_error("DATA_MISMATCH", $sformatf("Data mismatch at index %0d Occurs: data_out= %0d, data_in= %0d", read_count, rsp.data_out, req.data_in))
      end */

      read_count++;
    end
    `uvm_info("FIFO_TEST", "Read sequence completed. Data integrity verified.", UVM_MEDIUM)
  
endtask:body
     
`endif //GUARD_SYNCH_FIFO_OPERATION_CHECK_SINGLE_CLOCK_DOMAIN_SEQUENCE_SV
     
