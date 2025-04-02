//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_driver.sv 
// Project : Synchronous FIFO Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////
`ifndef GUARD_SYNCH_FIFO_DRIVER_SV
`define GUARD_SYNCH_FIFO_DRIVER_SV

`define vintf vif.driver_mp.driver_cb

class synch_fifo_driver extends uvm_driver#(synch_fifo_transaction);
   `uvm_component_utils(synch_fifo_driver)

   virtual synch_fifo_interface vif;

   extern function new(string name="synch_fifo_driver",uvm_component parent=null);
      

   extern function void build_phase(uvm_phase phase);
     
   extern task run_phase(uvm_phase phase);
     
   extern task driver_logic(synch_fifo_transaction trans);

endclass:synch_fifo_driver
           
//==========================================================================================
// New
//==========================================================================================

function synch_fifo_driver::new(string name="synch_fifo_driver",uvm_component parent);  
    super.new(name,parent);
endfunction :new           
           
//==========================================================================================
// build_phase
//==========================================================================================

function void synch_fifo_driver::build_phase(uvm_phase phase);
  
      string _name = "build_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      super.build_phase(phase);
  
      if(!uvm_config_db#(virtual synch_fifo_interface)::get(this,"","vintf",vif)) begin
         `uvm_fatal("DRIVER_CONNECTION_NOT_ESTABLISHED","");
      end
      else begin
         `uvm_info("DRIVER_CONNECTION_ESTABLISHED","",UVM_NONE);
      end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction :build_phase           
           
//==========================================================================================
// run_phase
//==========================================================================================
 
task synch_fifo_driver::run_phase(uvm_phase phase);
      synch_fifo_transaction trans;
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
  
      forever begin
         fork
            begin
               while(vif.reset==0) begin
                  @(posedge vif.clk);
               end
            end
            begin
               if(vif.reset==0) begin
                  `vintf.we<=0;
                  `vintf.re<=0;
                  wait(vif.reset==1);
               end
            end
         join_any
         disable fork;
         seq_item_port.get_next_item(trans);
         driver_logic(trans);
         seq_item_port.item_done();
         //`uvm_info("DRIVER_TRANSACTION_COUNT = ","",UVM_NONE);
      end
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
           
endtask :run_phase 

// driver_logic task 
task synch_fifo_driver::driver_logic(synch_fifo_transaction trans);
       @(posedge vif.clk);
       `vintf.re     <=trans.re;
       `vintf.we     <=trans.we;
  
       trans.full  =vif.full;
       if(trans.we==1) 
         `vintf.data_in<=trans.data_in;
       else if(trans.full==1 || trans.we==0) 
         `vintf.data_in<=32'hxxxx_xxxx;
  
endtask :driver_logic           
           
           
`endif //GUARD_SYNCH_FIFO_DRIVER_SV
