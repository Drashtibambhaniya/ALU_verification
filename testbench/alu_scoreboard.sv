import alu_pkg::*;
`include "alu_ref.sv"

class alu_scoreboard;

  mailbox #(alu_packet) ip_mb;
  mailbox #(alu_packet) op_mb;
  alu_coverage cov;

  alu_reference_model ref_model;

  alu_packet expected_fifo[$];

  int pass_cnt = 0;
  int fail_cnt = 0;

  function new(mailbox #(alu_packet) ip,
               mailbox #(alu_packet) op);
    this.ip_mb = ip;
    this.op_mb = op;
    ref_model  = new();
    cov        = new();
  endfunction


  task process_inputs();
    alu_packet in_pkt;
    alu_packet exp_pkt;
    forever begin
      ip_mb.get(in_pkt);
      #1;
      cov.sample(in_pkt, in_pkt);
      

      if (in_pkt.ce !== 1'b1)        continue;
      if (in_pkt.inp_valid === 2'b00) continue;
      exp_pkt = ref_model.compute(in_pkt);
      expected_fifo.push_back(exp_pkt);
      $display("[SB INPUT][Time=%0t] Received - Queue size=%0d", $time, expected_fifo.size());
    end
  endtask


  task process_outputs();
    alu_packet act_pkt;
    alu_packet exp_pkt;
    forever begin
      op_mb.get(act_pkt);
      $display("[SB OUTPUT][Time=%0t] Received Output", $time);

      wait(expected_fifo.size() > 0);
      exp_pkt = expected_fifo.pop_front();
      $display("[SB] Retrieved from queue. Remaining=%0d", expected_fifo.size());

      cov.sample(exp_pkt, act_pkt);

      if (compare_pkt(exp_pkt, act_pkt)) begin
        pass_cnt++;
        $display("===================================");
        $display("============Time:::%0t=======================", $time);
        $display("[SB] = PASS");
        $display("---- INPUT ----");
        $display("PKT_ID=%0d  CE=%0d  MODE=%0s  CMD=%0s",
                 exp_pkt.pkt_id, exp_pkt.ce,
                 exp_pkt.mode ? "ARITH" : "LOGIC",
                 ref_model.get_cmd_name(exp_pkt.mode, exp_pkt.cmd));
        $display("OPA=%0d  OPB=%0d  CIN=%0d  INP_VALID=%02b",
                 exp_pkt.opa, exp_pkt.opb,
                 exp_pkt.cin, exp_pkt.inp_valid);
        $display("---- EXPECTED ----");
        $display("RES=%0d COUT=%0d OFLOW=%0d G=%0d L=%0d E=%0d ERR=%0d",
                 exp_pkt.res, exp_pkt.cout, exp_pkt.oflow,
                 exp_pkt.g, exp_pkt.l, exp_pkt.e, exp_pkt.err);
        $display("---- ACTUAL ----");
        $display("RES=%0d COUT=%0d OFLOW=%0d G=%0d L=%0d E=%0d ERR=%0d",
                 act_pkt.res, act_pkt.cout, act_pkt.oflow,
                 act_pkt.g, act_pkt.l, act_pkt.e, act_pkt.err);
        $display("===================================\n");
      end
      else begin
        fail_cnt++;
        $display("===================================");
        $display("============Time:::%0t=======================", $time);
        $display("[SB] FAIL");
        $display("---- INPUT ----");
        $display("PKT_ID=%0d  CE=%0d  MODE=%0s  CMD=%0s",
                 exp_pkt.pkt_id, exp_pkt.ce,
                 exp_pkt.mode ? "ARITH" : "LOGIC",
                 ref_model.get_cmd_name(exp_pkt.mode, exp_pkt.cmd));
        $display("OPA=%0d  OPB=%0d  CIN=%0d  INP_VALID=%02b",
                 exp_pkt.opa, exp_pkt.opb,
                 exp_pkt.cin, exp_pkt.inp_valid);
        $display("---- EXPECTED ----");
        $display("RES=%0d COUT=%0d OFLOW=%0d G=%0d L=%0d E=%0d ERR=%0d",
                 exp_pkt.res, exp_pkt.cout, exp_pkt.oflow,
                 exp_pkt.g, exp_pkt.l, exp_pkt.e, exp_pkt.err);
        $display("---- ACTUAL ----");
        $display("RES=%0d COUT=%0d OFLOW=%0d G=%0d L=%0d E=%0d ERR=%0d",
                 act_pkt.res, act_pkt.cout, act_pkt.oflow,
                 act_pkt.g, act_pkt.l, act_pkt.e, act_pkt.err);
        $display("===================================\n");
      end
    end
  endtask


  task run();
    $display("[SB] Scoreboard Started");
    fork
      process_inputs();
      process_outputs();
    join_none
  endtask


  function bit compare_pkt(alu_packet exp, alu_packet act);
    if (exp.res   !== act.res)   return 0;
    if (exp.cout  !== act.cout)  return 0;
    if (exp.oflow !== act.oflow) return 0;
    if (exp.g     !== act.g)     return 0;
    if (exp.l     !== act.l)     return 0;
    if (exp.e     !== act.e)     return 0;
    if (exp.err   !== act.err)   return 0;
    return 1;
  endfunction


  function void report();
    $display("\n========== SCOREBOARD FINAL REPORT ==========");
    $display("PASS COUNT: %0d", pass_cnt);
    $display("FAIL COUNT: %0d", fail_cnt);
    $display("TOTAL TESTS: %0d", pass_cnt + fail_cnt);
    if (expected_fifo.size() > 0)
      $display("WARNING: %0d packets still pending in queue!", expected_fifo.size());
    if (fail_cnt == 0 && expected_fifo.size() == 0)
      $display("STATUS: ALL TESTS PASSED!");
    else
      $display("STATUS: SOME TESTS FAILED OR PENDING");
    $display("=============================================\n");
    cov.report();
  endfunction

endclass
