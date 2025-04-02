//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_monitor.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_MONITOR_SV
`define GUARD_SYNCH_FIFO_MONITOR_SV

`define vintf_h vif.monitor_mp.monitor_cb

class synch_fifo_monitor extends uvm_monitor;
   `uvm_component_utils(synch_fifo_monitor)

   virtual synch_fifo_interface vif;

   synch_fifo_transaction trans;

   uvm_analysis_port#(synch_fifo_transaction) mon2scor;
    
   // function new
   extern function new(string name="synch_fifo_monitor",uvm_component parent=null);

   // build_phase
   extern function void build_phase(uvm_phase phase);
      
   // run_phase
   extern task run_phase(uvm_phase phase);
      
endclass:synch_fifo_monitor

//==========================================================================================
// New
//==========================================================================================

function synch_fifo_monitor::new(string name="synch_fifo_monitor",uvm_component parent=null);
      super.new(name,parent);
endfunction :new

//==========================================================================================
// build_phase
//==========================================================================================

function void synch_fifo_monitor::build_phase(uvm_phase phase);
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      super.build_phase(phase);
      mon2scor=new("mon2scor",this);
       if(!uvm_config_db#(virtual synch_fifo_interface)::get(this,"","vintf",vif)) begin
         `uvm_fatal("MONITOR_CONNECTION_NOT_ESTABLISHED","");
      end
      else begin
         `uvm_info("MONITOR_CONNECTION_ESTABLISHED","",UVM_NONE);
      end
  
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction :build_phase

//==========================================================================================
// run_phase
//==========================================================================================

task synch_fifo_monitor::run_phase(uvm_phase phase);
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      forever begin
         if(vif.reset==1) begin
            trans=synch_fifo_transaction::type_id::create("trans",this);
            trans.we       = `vintf_h.we;        
            trans.re       = `vintf_h.re;
            trans.full     = `vintf_h.full;
            trans.empty    = `vintf_h.empty;
            trans.data_in  = `vintf_h.data_in;
            trans.data_out = `vintf_h.data_out;
            @(posedge vif.clk);
            mon2scor.write(trans);
            //`uvm_info("MONITOR_TO_SCOREBOARD_SENT","",UVM_NONE);
         end
         else @(posedge vif.clk);
      end
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endtask :run_phase

`endif //GUARD_SYNCH_FIFO_MONITOR_SV