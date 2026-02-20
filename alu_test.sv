`include "alu_driver.sv"
`include "alu_generator.sv"
`include "alu_monitor_ip.sv"
`include "alu_monitor_op.sv"
`include "alu_scoreboard.sv"

class alu_test;

  virtual alu_interface vif;

  mailbox #(alu_packet) gen2drv_mb;
  mailbox #(alu_packet) ip2sb_mb;
  mailbox #(alu_packet) op2sb_mb;

  alu_driver     drv;
  alu_generator  gen;
  alu_monitor_ip mon_ip;
  alu_monitor_op mon_op;
  alu_scoreboard sb;
  function new(virtual alu_interface vif);
    this.vif = vif;
  endfunction

  task run();

    gen2drv_mb = new();
    ip2sb_mb   = new();
    op2sb_mb   = new();

    drv    = new(vif, gen2drv_mb);
    gen    = new(gen2drv_mb, 10);
    mon_ip = new(vif, ip2sb_mb);
    mon_op = new(vif, op2sb_mb);
    sb     = new(ip2sb_mb, op2sb_mb);

    drv.reset_dut();
    fork
      drv.run();
      gen.run();
      mon_ip.run();
      mon_op.run();
      sb.run();
    join_none
    @gen.gen_done;
    #300;
    $finish;

  endtask

endclass
