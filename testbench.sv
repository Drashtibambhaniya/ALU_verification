`include "alu_test.sv"

module alu_top;

  bit clk;

  // Clock generation
  always #5 clk = ~clk;

  // Interface
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

  alu_test test;

  // Waveform dumping
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_top);
  end

  // Main test sequence
  initial begin
    clk = 0;

    // BUG FIX #14: Removed direct signal driving to avoid race with driver
    // Let the driver handle all signal initialization
    
    // Create and run test
    test = new(alu_if);
    test.run();
    
    // BUG FIX #13: Wait for test completion before finishing
    // Original code called $finish immediately, killing simulation!
    @(test.gen.gen_done);  // Wait for generator to complete
    
    $display("\n[TESTBENCH] Generator completed, waiting for pipeline to drain...");
    
    repeat(20) @(posedge clk);
    
    test.sb.report();
    
    $display("\n[TESTBENCH] Simulation Complete");
    $finish;
  end

  // Timeout watchdog (prevent infinite simulation)
  initial begin
    #100000;  // 100us timeout
    $display("\n[ERROR] Simulation timeout!");
    test.sb.report();  // Print report even on timeout
    $finish;
  end

endmodule