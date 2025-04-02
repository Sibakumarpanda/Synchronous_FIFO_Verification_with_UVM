//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_sequencer.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_SEQUENCER_SV
`define GUARD_SYNCH_FIFO_SEQUENCER_SV

class synch_fifo_sequencer extends uvm_sequencer#(synch_fifo_transaction);
   `uvm_component_utils(synch_fifo_sequencer)

   // Function new
   extern function new(string name="synch_fifo_sequencer",uvm_component parent=null);
   //build phase
   extern function void build_phase(uvm_phase phase);
   //run_phase
   extern task run_phase(uvm_phase phase);
     

endclass :synch_fifo_sequencer

//==========================================================================================
// New
//==========================================================================================

function synch_fifo_sequencer::new(string name="synch_fifo_sequencer",uvm_component parent);  
    super.new(name,parent);
endfunction :new
    
//==========================================================================================
// Build_phase
//==========================================================================================
function void synch_fifo_sequencer::build_phase(uvm_phase phase);
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
      super.build_phase(phase);
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endfunction

//==========================================================================================
// run_phase
//==========================================================================================
    
task synch_fifo_sequencer::run_phase(uvm_phase phase);
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endtask       

`endif //GUARD_SYNCH_FIFO_SEQUENCER_SV