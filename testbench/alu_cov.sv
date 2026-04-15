import alu_pkg::*;
class alu_coverage;

  
  bit rst, ce, mode, cin;
  bit [1:0]  inp_valid;
  bit [3:0]  cmd;
  bit [7:0]  opa, opb;
  bit [8:0]  res;
  bit cout, oflow, e, g, l, err;

  covergroup alu_cg;

    // --- INPUT COVERAGE ---------------------------------------------------

    reset_cov: coverpoint rst {
      bins rst_high = {1};
      bins rst_low  = {0};
    }

    clk_enable_cov: coverpoint ce {
      bins ce_active   = {1};
      bins ce_inactive = {0};
    }

    inp_valid_cov: coverpoint inp_valid {
      bins only_opa_valid = {2'b01};
      bins only_opb_valid = {2'b10};
      bins both_ops_valid = {2'b11};
      bins no_input       = {2'b00};
    }

    mode_cov: coverpoint mode {
      bins arithmetic_mode = {1};
      bins logical_mode    = {0};
    }

    carry_in_cov: coverpoint cin {
      bins cin_set   = {1};
      bins cin_clear = {0};
    }

    arith_cmd_cov: coverpoint cmd iff (mode == 1) {
      bins op_add       = {4'd0};
      bins op_sub       = {4'd1};
      bins op_add_cin   = {4'd2};
      bins op_sub_cin   = {4'd3};
      bins op_inc_a     = {4'd4};
      bins op_dec_a     = {4'd5};
      bins op_inc_b     = {4'd6};
      bins op_dec_b     = {4'd7};
      bins op_cmp       = {4'd8};
      bins op_mul_inc   = {4'd9};
      bins op_mul_shift = {4'd10};
      ignore_bins unused = {[11:15]};
    }

    logic_cmd_cov: coverpoint cmd iff (mode == 0) {
      bins op_and   = {4'd0};
      bins op_nand  = {4'd1};
      bins op_or    = {4'd2};
      bins op_nor   = {4'd3};
      bins op_xor   = {4'd4};
      bins op_xnor  = {4'd5};
      bins op_not_a = {4'd6};
      bins op_not_b = {4'd7};
      bins op_shr_a = {4'd8};
      bins op_shl_a = {4'd9};
      bins op_shr_b = {4'd10};
      bins op_shl_b = {4'd11};
      bins op_rol   = {4'd12};
      bins op_ror   = {4'd13};
      ignore_bins unused = {[14:15]};
    }

    opa_value_cov: coverpoint opa {
      bins opa_zero  = {0};
      bins opa_small = {[1:127]};
      bins opa_large = {[128:255]};
    }

    opb_value_cov: coverpoint opb {
      bins opb_zero  = {0};
      bins opb_small = {[1:127]};
      bins opb_large = {[128:255]};
    }


    //cmd_x_inp_valid: cross arith_cmd_cov, inp_valid_cov;

    //cmd_x_mode:      cross arith_cmd_cov, mode_cov;

    // OUTPUT COVERAGE 

    result_cov: coverpoint res {
      bins res_zero  = {0};
      bins res_small = {[1:255]};
      bins res_large = {[256:511]};
    }

    carry_out_cov: coverpoint cout {
      bins cout_set   = {1};
      bins cout_clear = {0};
    }

    overflow_cov: coverpoint oflow {
      bins oflow_set   = {1};
      bins oflow_clear = {0};
    }

    equal_flag_cov: coverpoint e {
      bins equal_true  = {1};
      bins equal_false = {0};
    }

    greater_flag_cov: coverpoint g {
      bins greater_true  = {1};
      bins greater_false = {0};
    }

    less_flag_cov: coverpoint l {
      bins less_true  = {1};
      bins less_false = {0};
    }

    error_flag_cov: coverpoint err {
      bins error_set   = {1};
      bins error_clear = {0};
    }

  endgroup

  function new();
    alu_cg = new();
  endfunction

  
  function void sample(alu_packet ip_pkt, alu_packet op_pkt);
    rst       = 0;           
    ce        = ip_pkt.ce;
    mode      = ip_pkt.mode;
    cin       = ip_pkt.cin;
    inp_valid = ip_pkt.inp_valid;
    cmd       = ip_pkt.cmd;
    opa       = ip_pkt.opa;
    opb       = ip_pkt.opb;

    res   = op_pkt.res;
    cout  = op_pkt.cout;
    oflow = op_pkt.oflow;
    e     = op_pkt.e;
    g     = op_pkt.g;
    l     = op_pkt.l;
    err   = op_pkt.err;

    alu_cg.sample();  
  endfunction

  
  function void report();
    $display("\n--------------------------------------------");
    $display("[COV] Functional Coverage = %.2f%%", alu_cg.get_coverage());
    $display("--------------------------------------------\n");
  endfunction

endclass
