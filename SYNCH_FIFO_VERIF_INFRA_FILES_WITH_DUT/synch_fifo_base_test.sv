//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_base_test.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_BASE_TEST_SV
`define GUARD_SYNCH_FIFO_BASE_TEST_SV

class synch_fifo_base_test extends uvm_test;

    `uvm_component_utils(synch_fifo_base_test)
     
     synch_fifo_env env_h;
     
  
     //synch_fifo_reset_sequence   rst_seq;
     
       
      //Constructor: new   
     extern function new(string name = "synch_fifo_base_test",uvm_component parent);
   
     //Function: build_phase
     extern function void build_phase(uvm_phase phase);
      
     //Function: connect_phase
     extern function void connect_phase(uvm_phase phase);  
    
     //Function: end_of_elaboration_phase
     extern function void end_of_elaboration_phase(uvm_phase phase);
     
     //Function: start_of_simulation_phase  
     extern function void start_of_simulation_phase(uvm_phase phase);  
    
     //Task: run_phase
     extern task run_phase(uvm_phase phase);
      
     //Function: report_phase
     extern function void report_phase(uvm_phase phase);
      
     //Function: final_phase  
     extern function void final_phase(uvm_phase phase);  
    
endclass:synch_fifo_base_test

//===================================================================================
// New
//===================================================================================
function synch_fifo_base_test::new(string name="synch_fifo_base_test",uvm_component parent);
	super.new(name,parent);
endfunction:new

//===================================================================================
// build_phase
//===================================================================================
function void synch_fifo_base_test::build_phase(uvm_phase phase);
     string _name = "build_phase";
    `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
     super.build_phase(phase);
     env_h     = synch_fifo_env::type_id::create("env_h",this);
    `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);

endfunction :build_phase
       
//===================================================================================
// connect_phase
//===================================================================================
      
function void synch_fifo_base_test::connect_phase(uvm_phase phase); 
    string _name = "connect_phase";
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
    super.connect_phase(phase);
  
    uvm_top.print_topology();
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction: connect_phase       

//===================================================================================
// end_of_elaboration_phase
//===================================================================================

function void synch_fifo_base_test::end_of_elaboration_phase(uvm_phase phase);
     string _name = "end_of_elaboration_phase";
    `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
     super.end_of_elaboration_phase(phase);
     uvm_top.print_topology();
    `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
endfunction: end_of_elaboration_phase 
       
       
//===================================================================================
// start_of_simulation_phase
//===================================================================================
function void synch_fifo_base_test::start_of_simulation_phase(uvm_phase phase);
  
    string _name = "start_of_simulation_phase";
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_FULL);

    super.start_of_simulation_phase(phase);

   `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_FULL);
  
endfunction : start_of_simulation_phase 
           
//===================================================================================
// run_phase
//=================================================================================== 
task synch_fifo_base_test::run_phase(uvm_phase phase);
  
      string _name = "run_phase";
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Started Running the Test"), UVM_NONE);
 
      phase.raise_objection(this);
  
      // Check and validate the sequencer handle
      if (env_h.agent_h.sequencer_h == null) begin 
         `uvm_fatal(get_type_name(), "Sequencer handle is null");  
      end
  
      // Create the sequence object
      //rst_seq   = synch_fifo_reset_sequence::type_id::create("rst_seq");
	  
  
      // Ensure the sequence is started with a valid sequencer handle
      //rst_seq.start(env_h.agent_h.sequencer_h); 
     
  
      // Wait for 100 time units
      #100;
      phase.drop_objection(this); // Drop the objection to allow the phase to end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended Running the Test"), UVM_NONE);
  
endtask :run_phase 
       
//===================================================================================
// report_phase
//===================================================================================
function void synch_fifo_base_test::report_phase(uvm_phase phase);
    string _name = "report_phase";
    int err_cnt;
    //uvm_default_report_server foo ;
    uvm_report_server foo ;
    //int err_cnt ;
    
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
    $cast(foo,uvm_top.get_report_server());

    // sum num of errors from sequences (use global report server)
    err_cnt = foo.get_severity_count(UVM_ERROR) + foo.get_severity_count(UVM_FATAL);

    // sum num of errors from this test.
    $cast(foo,get_report_server());
    err_cnt += (foo.get_severity_count(UVM_ERROR) + foo.get_severity_count(UVM_FATAL)); 
    //This is an accumulation operation. The += operator adds the result of the expression on the right to the current value of err_cnt.
    //In this context, err_cnt is a variable that is being used to keep a running total of the number of errors and fatal errors encountered.

    if (err_cnt == 0)
        begin
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
            uvm_report_info(get_full_name(), "         _______  _______  _______  _______         ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |       ||   _   ||       ||       |        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    _  ||  |_|  ||  _____||  _____|        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |_| ||       || |_____ | |_____         ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    ___||       ||_____  ||_____  |        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |    |   _   | _____| | _____| |        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |___|    |__| |__||_______||_______|        ", UVM_LOG);
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
        end
    else
        begin
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
            uvm_report_info(get_full_name(), "         _______  _______  ___   ___                ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |       ||   _   ||   | |   |               ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    ___||  |_|  ||   | |   |               ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |___ |       ||   | |   |               ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    ___||       ||   | |   |___            ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |    |   _   ||   | |       |           ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |___|    |__| |__||___| |_______|           ", UVM_LOG);
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
        end
    super.report_phase(phase);
  `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction : report_phase       
//===================================================================================
// final_phase
//===================================================================================
function void synch_fifo_base_test::final_phase(uvm_phase phase);
  
   string _name = "final_phase";

  `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
   super.final_phase(phase);

  `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction : final_phase 


`endif //GUARD_SYNCH_FIFO_BASE_TEST_SV