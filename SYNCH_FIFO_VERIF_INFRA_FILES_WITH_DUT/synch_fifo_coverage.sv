//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_coverage.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_COVERAGE_SV
`define GUARD_SYNCH_FIFO_COVERAGE_SV

class synch_fifo_coverage extends uvm_subscriber#(synch_fifo_transaction);
   `uvm_component_utils(synch_fifo_coverage)

   uvm_tlm_analysis_fifo#(synch_fifo_transaction) mon2subs;

   synch_fifo_transaction trans;
  
   // Function New
   extern function new(string name="synch_fifo_coverage",uvm_component parent=null);
   // build_phase
   extern function void build_phase(uvm_phase phase);
   // build_phase
   extern task run_phase(uvm_phase phase);
   // check_phase
   extern function void check_phase(uvm_phase phase);     

   covergroup fifo_cg();
      cp1:coverpoint trans.we;
      cp2:coverpoint trans.re;
      cp3:coverpoint trans.full;
      cp4:coverpoint trans.empty;
      cp5:coverpoint trans.data_in { bins b1[10] = {[0:30]};}
   endgroup
     
   // Coverage sampling Function
   extern function void write(T t);
     
endclass :synch_fifo_coverage

//==========================================================================================
// New
//==========================================================================================

function synch_fifo_coverage::new(string name="synch_fifo_coverage",uvm_component parent=null);
      super.new(name,parent);
      fifo_cg=new();
endfunction :new

//==========================================================================================
// build_phase
//==========================================================================================

function void synch_fifo_coverage::build_phase(uvm_phase phase);
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
      super.build_phase(phase);
      mon2subs=new("mon2subs",this);
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
      
endfunction :build_phase  
     
//==========================================================================================
// run_phase
//==========================================================================================

task synch_fifo_coverage::run_phase(uvm_phase phase);
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
     `uvm_info("SUBSCRIBER-RUN PHASE","",UVM_NONE);
      forever begin
         mon2subs.get(trans);
         write(trans);
      end
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endtask : run_phase     
     
//==========================================================================================
// check_phase
//==========================================================================================
     
function void synch_fifo_coverage::check_phase(uvm_phase phase);
     string _name = "check_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE); 
     $display("-----------------------------------------------------------------------------");
     $display("-----------------------------------------------------------------------------");
    `uvm_info("MY_COVERAGE",$sformatf("%0f",fifo_cg.get_coverage()),UVM_NONE);
     $display("-----------------------------------------------------------------------------");
     $display("-----------------------------------------------------------------------------");
    `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endfunction: check_phase

//==========================================================================================
// coverage sample function
//==========================================================================================
     
function void synch_fifo_coverage::write(T t);
      fifo_cg.sample();
endfunction :write    
    
`endif //GUARD_SYNCH_FIFO_COVERAGE_SV