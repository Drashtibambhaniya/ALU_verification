`include "alu_test.sv"  

module alu_top;

  bit clk;
  always #5 clk = ~clk;
  
  // interface instantiation
  alu_interface alu_if(clk);


  // DUT instantiation
  ALU_DESIGN dut (
    .CLK       (clk),
    .RST       (alu_if.rst),
    .CE        (alu_if.ce),
    .MODE      (alu_if.mode),
    .CMD       (alu_if.cmd),
    .INP_VALID (alu_if.inp_valid),
    .OPA       (alu_if.opa),
    .OPB       (alu_if.opb),
    .CIN       (alu_if.cin),
    .RES       (alu_if.res),
    .COUT      (alu_if.cout),
    .OFLOW     (alu_if.oflow),
    .G         (alu_if.g),
    .L         (alu_if.l),
    .E         (alu_if.e),
    .ERR       (alu_if.err)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_top);
  end

  initial begin
    clk <= 0;

    // Run Tests

    //begin add_test       t=new(alu_if); t.run(); end
    //begin sub_test       t=new(alu_if); t.run(); end
    //begin add_cin_test   t=new(alu_if); t.run(); end
    //begin sub_cin_test   t=new(alu_if); t.run(); end
    //begin inc_a_test     t=new(alu_if); t.run(); end
    //begin dec_a_test     t=new(alu_if); t.run(); end
    //begin inc_b_test     t=new(alu_if); t.run(); end
    //begin dec_b_test     t=new(alu_if); t.run(); end
    //begin cmp_test       t=new(alu_if); t.run(); end
    //begin mul_inc_test   t=new(alu_if); t.run(); end
    //begin mul_shift_test t=new(alu_if); t.run(); end

    //begin and_test       t=new(alu_if); t.run(); end
    //begin nand_test      t=new(alu_if); t.run(); end
    //begin or_test        t=new(alu_if); t.run(); end
    //begin nor_test       t=new(alu_if); t.run(); end
    //begin xor_test       t=new(alu_if); t.run(); end
    //begin xnor_test      t=new(alu_if); t.run(); end
    //begin not_a_test     t=new(alu_if); t.run(); end
    //begin not_b_test     t=new(alu_if); t.run(); end
    //begin shr_a_test     t=new(alu_if); t.run(); end
    //begin shl_a_test     t=new(alu_if); t.run(); end
    //begin shr_b_test     t=new(alu_if); t.run(); end
    //begin shl_b_test     t=new(alu_if); t.run(); end
    //begin rol_test t=new(alu_if); t.run(); end
    //begin ror_test t=new(alu_if); t.run(); end

    // ++++++Run regression test+++++++++

    begin regression_test t=new(alu_if); t.run(); end
  end

  initial begin
    #500000;
    $display("\n[ERROR] Simulation timeout!");
    $finish;
  end

endmodule
