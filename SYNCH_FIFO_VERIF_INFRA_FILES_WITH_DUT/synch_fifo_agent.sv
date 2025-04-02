//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_agent.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_AGENT_SV
`define GUARD_SYNCH_FIFO_AGENT_SV

class synch_fifo_agent extends uvm_agent;
   `uvm_component_utils(synch_fifo_agent)

   synch_fifo_sequencer    sequencer_h;
   synch_fifo_driver       driver_h;
   synch_fifo_monitor      monitor_h;

   uvm_analysis_port#(synch_fifo_transaction) mon2scor;

   // Function New
   extern function new(string name="synch_fifo_agent",uvm_component parent=null);
     
   // build_phase
   extern function void build_phase(uvm_phase phase);
      
   //connect_phase
   extern function void connect_phase(uvm_phase phase);
     
   //run_phase
   extern task run_phase(uvm_phase phase);
      
endclass :synch_fifo_agent

//==========================================================================================
// New
//==========================================================================================

function synch_fifo_agent::new(string name="synch_fifo_agent",uvm_component parent=null);
      super.new(name,parent);
endfunction: new

//==========================================================================================
// build_phase
//==========================================================================================

function void synch_fifo_agent::build_phase(uvm_phase phase);
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      super.build_phase(phase);
      mon2scor=new("mon2scor",this);
      sequencer_h=synch_fifo_sequencer::type_id::create("sequencer_h",this);
      driver_h   =synch_fifo_driver::type_id::create("driver_h",this);
      monitor_h  =synch_fifo_monitor::type_id::create("monitor_h",this);
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endfunction

//==========================================================================================
// connect_phase
//==========================================================================================
     
function void synch_fifo_agent::connect_phase(uvm_phase phase);
      string _name = "connect_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      super.connect_phase(phase);
      driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
      monitor_h.mon2scor.connect(mon2scor);
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endfunction
     
//==========================================================================================
// run_phase
//==========================================================================================
     
task synch_fifo_agent::run_phase(uvm_phase phase);
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endtask
     
`endif //GUARD_SYNCH_FIFO_AGENT_SV