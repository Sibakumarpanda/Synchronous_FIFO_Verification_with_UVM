//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_env.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_ENV_SV
`define GUARD_SYNCH_FIFO_ENV_SV

class synch_fifo_env extends uvm_env;
   `uvm_component_utils(synch_fifo_env)

   synch_fifo_scoreboard  scoreboard_h;
   synch_fifo_coverage    subscriber_h;
   synch_fifo_agent       agent_h;
   
   // Function new
   extern function new(string name="synch_fifo_env",uvm_component parent=null);
     
   // build_phase
   extern function void build_phase(uvm_phase phase);
      
   //connect_phase
   extern function void connect_phase(uvm_phase phase);
     
   //run_phase
   extern task run_phase(uvm_phase phase);
     

endclass :synch_fifo_env

//==========================================================================================
// New
//==========================================================================================

function synch_fifo_env::new(string name="synch_fifo_env",uvm_component parent=null);
    super.new(name,parent);
endfunction :new

//==========================================================================================
// build_phase
//==========================================================================================
function void  synch_fifo_env::build_phase(uvm_phase phase);
    string _name = "build_phase";
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
    super.build_phase(phase);
    scoreboard_h =synch_fifo_scoreboard::type_id::create("scoreboard_h",this);
    subscriber_h =synch_fifo_coverage::type_id::create("subscriber_h",this);
    agent_h      =synch_fifo_agent::type_id::create("agent_h",this);
  
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction : build_phase

//==========================================================================================
// connect_phase
//==========================================================================================
function void synch_fifo_env::connect_phase(uvm_phase phase);
      string _name = "connect_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
      super.connect_phase(phase);
      agent_h.mon2scor.connect(scoreboard_h.mon2scor.analysis_export);
      agent_h.mon2scor.connect(subscriber_h.mon2subs.analysis_export);
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endfunction :connect_phase

//==========================================================================================
// run_phase
//==========================================================================================
task synch_fifo_env::run_phase(uvm_phase phase);
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
     `uvm_info("ENVIRONMENT-RUN PHASE","",UVM_NONE);
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endtask :run_phase

`endif //GUARD_SYNCH_FIFO_ENV_SV

