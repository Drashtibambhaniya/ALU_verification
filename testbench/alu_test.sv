`include "alu_base_test.sv"

// --------- ARITHMETIC TESTS ---------

class add_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    add_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class sub_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    sub_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class add_cin_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    add_cin_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class sub_cin_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    sub_cin_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class inc_a_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    inc_a_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class dec_a_test extends alu_base_test;          
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    dec_a_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class inc_b_test extends alu_base_test;           
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    inc_b_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class dec_b_test extends alu_base_test;           
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    dec_b_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class cmp_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    cmp_gt_test_data txn_gt = new();
    cmp_lt_test_data txn_lt = new();
    cmp_eq_test_data txn_eq = new();
    txn_gt.run(); gen.send_pkt(txn_gt);
    txn_lt.run(); gen.send_pkt(txn_lt);
    txn_eq.run(); gen.send_pkt(txn_eq);
  endtask
endclass

class mul_inc_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    mul_inc_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class mul_shift_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    mul_shift_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass


// ------ LOGICAL TESTS ----

class and_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    and_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class nand_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    nand_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class or_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    or_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class nor_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    nor_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class xor_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    xor_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class xnor_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    xnor_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class not_a_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    not_a_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class not_b_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    not_b_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class shr_a_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    shr_a_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class shl_a_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    shl_a_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class shr_b_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    shr_b_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class shl_b_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    shl_b_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class rol_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    rol_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass

class ror_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();
    ror_test_data txn = new();
    txn.run();
    gen.send_pkt(txn);
  endtask
endclass


class regression_test extends alu_base_test;
  function new(virtual alu_interface vif); super.new(vif); endfunction
  virtual task run_test();

    $display("\n[REGRESSION] Arithmetic - random operands...");
    repeat(3) begin add_rand_data       txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin sub_rand_data       txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin add_cin_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin sub_cin_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin inc_a_rand_data     txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin dec_a_rand_data     txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin inc_b_rand_data     txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin dec_b_rand_data     txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin cmp_gt_rand_data    txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin cmp_lt_rand_data    txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin cmp_eq_rand_data    txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin mul_inc_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin mul_shift_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end

    $display("\n[REGRESSION] Logical - random operands...");
    repeat(3) begin and_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin nand_rand_data  txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin or_rand_data    txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin nor_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin xor_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin xnor_rand_data  txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin not_a_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin not_b_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin shr_a_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin shl_a_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin shr_b_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin shl_b_rand_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin rol_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin ror_rand_data   txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(1) begin ce_inactive_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(1) begin no_input_data    txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin opa_zero_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(3) begin opb_zero_data txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(50) begin random_inp_valid txn=new(); txn.run(); gen.send_pkt(txn); end
    repeat(1) begin rst_high_data txn=new(); txn.run(); gen.send_pkt(txn); end


    $display("\n[REGRESSION] All Test done.");
  endtask
endclass
