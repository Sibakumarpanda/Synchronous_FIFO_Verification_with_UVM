//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : synch_fifo_package.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SYNCH_FIFO_PACKAGE_SV
`define GUARD_SYNCH_FIFO_PACKAGE_SV

package synch_fifo_package;

import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "synch_fifo_interface.sv" - Inside Package "interface" is not allowed to write
//`include "tb_define.sv" - We can include when this file is in use , at current its not used


`include "synch_fifo_transaction.sv"
`include "synch_fifo_base_sequence.sv"

`include "synch_fifo_reset_sequence.sv"
`include "synch_fifo_wr_rd_data_sequence.sv"
`include "synch_fifo_full_cond_chk_sequence.sv"
`include "synch_fifo_empty_cond_chk_sequence.sv"
`include "synch_fifo_wr_data_to_full_fifo_sequence.sv"
`include "synch_fifo_rd_data_from_empty_fifo_sequence.sv"
`include "synch_fifo_simultaneous_wr_rd_data_sequence.sv"
`include "synch_fifo_with_diff_datawidth_depth_sequence.sv"
`include "synch_fifo_op_chk_single_clock_domain_sequence.sv"


`include "synch_fifo_sequencer.sv"
`include "synch_fifo_driver.sv"
`include "synch_fifo_monitor.sv"
`include "synch_fifo_coverage.sv"
`include "synch_fifo_agent.sv"
`include "synch_fifo_scoreboard.sv"
`include "synch_fifo_env.sv"
`include "synch_fifo_base_test.sv"
`include "synch_fifo_wr_rd_data_test.sv"
`include "synch_fifo_full_cond_chk_test.sv"
`include "synch_fifo_empty_cond_chk_test.sv"
`include "synch_fifo_wr_data_to_full_fifo_test.sv"
`include "synch_fifo_rd_data_from_empty_fifo_test.sv"
`include "synch_fifo_simultaneous_wr_rd_data_test.sv"
`include "synch_fifo_with_diff_datawidth_depth_test.sv"
`include "synch_fifo_op_chk_single_clock_domain_test.sv"



endpackage : synch_fifo_package

`endif //GUARD_SYNCH_FIFO_PACKAGE_SV