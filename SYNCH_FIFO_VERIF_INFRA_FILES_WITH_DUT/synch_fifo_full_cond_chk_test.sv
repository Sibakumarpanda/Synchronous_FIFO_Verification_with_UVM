//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_full_cond_chk_test.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_FULL_COND_CHK_TEST_SV
`define GUARD_SYNCH_FIFO_FULL_COND_CHK_TEST_SV

class synch_fifo_full_cond_chk_test extends synch_fifo_base_test;

    `uvm_component_utils(synch_fifo_full_cond_chk_test)
     
     synch_fifo_full_cond_chk_sequence  full_cond_chk_seq;
    
     //Constructor: new
     extern function new(string name="",uvm_component parent);
       
     //Function: build_phase
     extern function void build_phase(uvm_phase phase);
       
     //Task: run_phase
     extern task run_phase(uvm_phase phase);
    
endclass: synch_fifo_full_cond_chk_test
       
//===================================================================================
// New
//===================================================================================
function synch_fifo_full_cond_chk_test::new(string name="",uvm_component parent);
	   super.new(name,parent);
endfunction :new
    
//===================================================================================
// build_phase
//===================================================================================
function void synch_fifo_full_cond_chk_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
      //env_h     = singleport_ram_env::type_id::create("env_h",this);

endfunction : build_phase
    
//===================================================================================
// run_phase
//===================================================================================
task synch_fifo_full_cond_chk_test::run_phase(uvm_phase phase);
	 
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started Running the--> synch_fifo_full_cond_chk_test Test"), UVM_NONE);
 
      phase.raise_objection(this);
  
      // Check and validate the sequencer handle
      if (env_h.agent_h.sequencer_h == null) begin 
         `uvm_fatal(get_type_name(), "Sequencer handle is null");  
      end
  
      // Create the sequence object
      full_cond_chk_seq = synch_fifo_full_cond_chk_sequence::type_id::create("full_cond_chk_seq");
	 
      // Ensure the sequence is started with a valid sequencer handle
      full_cond_chk_seq.start(env_h.agent_h.sequencer_h); 
      
  
      // Wait for 100 time units
      #100;
      phase.drop_objection(this); // Drop the objection to allow the phase to end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended Running the --> synch_fifo_full_cond_chk_test Test"), UVM_NONE);
endtask: run_phase

`endif //GUARD_SYNCH_FIFO_FULL_COND_CHK_TEST_SV