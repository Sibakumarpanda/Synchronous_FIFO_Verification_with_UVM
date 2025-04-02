//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_scoreboard.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_SCOREBOARD_SV
`define GUARD_SYNCH_FIFO_SCOREBOARD_SV

class synch_fifo_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(synch_fifo_scoreboard)

   uvm_tlm_analysis_fifo#(synch_fifo_transaction) mon2scor;


   bit [31:0]wmem[$];
   bit [31:0]rmem[$];
   bit [31:0]data;
   int vect_cnt, pass_cnt, fail_cnt;
   
   // Function new 
   extern function new(string name="synch_fifo_scoreboard",uvm_component parent=null);
     
   // build_phase
   extern function void build_phase(uvm_phase phase);
     
   //run_phase
   extern task run_phase(uvm_phase phase);
     
   // Function: report_phase
   extern function void report_phase(uvm_phase phase);   
     
   //Other Functions used here are
   extern function void PASS();
   extern function void FAIL();    
       
endclass:synch_fifo_scoreboard

//==========================================================================================
// New
//==========================================================================================

function synch_fifo_scoreboard::new(string name="synch_fifo_scoreboard",uvm_component parent=null);
    super.new(name,parent);
endfunction :new

//==========================================================================================
// build_phase
//==========================================================================================

function void synch_fifo_scoreboard::build_phase(uvm_phase phase);
    string _name = "build_phase";
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
    super.build_phase(phase);
    mon2scor=new("mon2scor",this);
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction : build_phase


//==========================================================================================
// run_phase
//==========================================================================================

task synch_fifo_scoreboard::run_phase(uvm_phase phase);
     synch_fifo_transaction trans;
     string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      forever begin
         mon2scor.get(trans);
         if(trans.we==1 && !trans.full) begin
            wmem.push_back(trans.data_in);
         end
         if(trans.re==1 && !trans.empty) begin
            rmem.push_back(trans.data_out);
            for(int i=0;i<rmem.size();i++) begin
               if(wmem[i-1]==rmem[i]) begin
                 `uvm_info("FROM_SCOREBOARD_COMPARISION", $sformatf("\nWrite Memory Data: %d\nRead Memory Data: %d\nPACKET Status -> PACKET_MATCHED",wmem[i-1],rmem[i]), UVM_NONE)
                 `uvm_info("SCOREBOARD_PASSED",$sformatf("data_in=%0d,data_out=%0d",trans.data_in,trans.data_out),UVM_NONE);
                  PASS();
               end
               else begin
                 `uvm_error("FROM_SCOREBOARD_COMPARISION", $sformatf("\nWrite Memory Data: %d\nRead Memory Data: %d\nPACKET Status -> PACKET_MISMATCHED", wmem[i-1],rmem[i]))
                 `uvm_error("SCOREBOARD_FAILED",$sformatf("data_in=%0d,data_out=%0d",trans.data_in,trans.data_out));
                  FAIL();
               end
            end
         end
      end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endtask :run_phase
     
function void synch_fifo_scoreboard::PASS();
	vect_cnt++;
	pass_cnt++;
endfunction : PASS

function void synch_fifo_scoreboard::FAIL();
  	vect_cnt++;
  	fail_cnt++;
endfunction :FAIL
     
//===================================================================================
// report_phase -Report phase to summarize results at the end of simulation
//===================================================================================
     
function void synch_fifo_scoreboard::report_phase(uvm_phase phase);
  $display("\n**************Synchronous FIFO Scoreboard comparison Summary***************\n");
     $display("Number of successful comparisons = %0d,Number of Unsuccessful comparisons = %0d\n",pass_cnt,fail_cnt);
     $display("-----------------------------------------------------------------\n");
endfunction : report_phase          

`endif //GUARD_SYNCH_FIFO_SCOREBOARD_SV