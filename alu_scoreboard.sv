// ==================================================================
import alu_pkg::*;
`include "alu_ref.sv"

class alu_scoreboard;

  mailbox #(alu_packet) ip_mb;  
  mailbox #(alu_packet) op_mb;  

  alu_reference_model ref_model;

  int pass_cnt = 0;
  int fail_cnt = 0;
  int total_cnt = 0;
  
  // BUG FIX #12: Add bug log file
  int bug_file;

  function new(mailbox #(alu_packet) ip,
               mailbox #(alu_packet) op);
    this.ip_mb = ip;
    this.op_mb = op;
    ref_model  = new();
    
    // Create bug log file
    bug_file = $fopen("bug_report.log", "w");
    $fdisplay(bug_file, "========================================================================");
    $fdisplay(bug_file, "ALU VERIFICATION BUG REPORT");
    $fdisplay(bug_file, "========================================================================");
    $fdisplay(bug_file, "Generated at simulation time: %0t\n", $time);
  endfunction


  task run();

    alu_packet in_pkt;
    alu_packet act_pkt;
    alu_packet exp_pkt;
     
    $display("[SCOREBOARD] Scoreboard Started");
    
    forever begin
      // Get input packet
      ip_mb.get(in_pkt);
      
      // Compute expected output
      exp_pkt = ref_model.compute(in_pkt);
      
      // Get actual output from DUT
      op_mb.get(act_pkt);
      
      total_cnt++;

      // Compare and report
      if (compare_pkt(exp_pkt, act_pkt)) begin
        pass_cnt++;  
        
        $display("\n===================================");
        $display("[SCOREBOARD][%0t] TEST #%0d PASSED", $time, total_cnt);
        $display("[ID=%0d] MODE=%s CMD=%0d", 
                 in_pkt.pkt_id, 
                 in_pkt.mode ? "ARITH" : "LOGIC", 
                 in_pkt.cmd);
        $display("===================================\n");
      end
      else begin
        fail_cnt++;
        
        // BUG FIX #11 & #13: Detailed mismatch reporting to console AND file
        report_failure(in_pkt, exp_pkt, act_pkt);
      end

    end
  endtask


  // BUG FIX #11: Detailed failure reporting function
  function void report_failure(alu_packet inp, alu_packet exp, alu_packet act);
    
    // Console output
    $display("\n========================================================================");
    $display("*** BUG DETECTED *** TEST #%0d FAILED at time %0t", total_cnt, $time);
    $display("========================================================================");
    
    $display("\nINPUT STIMULUS:");
    $display("  Packet ID   = %0d", inp.pkt_id);
    $display("  MODE        = %s (%0b)", inp.mode ? "ARITHMETIC" : "LOGICAL", inp.mode);
    $display("  CMD         = %0d (0x%0h)", inp.cmd, inp.cmd);
    $display("  OPA         = 0x%0h (decimal: %0d)", inp.opa, inp.opa);
    $display("  OPB         = 0x%0h (decimal: %0d)", inp.opb, inp.opb);
    $display("  CIN         = %0b", inp.cin);
    $display("  INP_VALID   = %0b", inp.inp_valid);
    $display("  CE          = %0b", inp.ce);
    
    $display("\nMISMATCH DETAILS:");
    show_mismatches(exp, act);
    
    $display("\nCOMPLETE COMPARISON:");
    $display("  Signal    Expected    Actual      Status");
    $display("  ------    --------    ------      ------");
    $display("  RES       0x%03h      0x%03h       %s", exp.res, act.res, 
             (exp.res == act.res) ? "PASS" : "FAIL");
    $display("  COUT      %0b           %0b           %s", exp.cout, act.cout,
             (exp.cout == act.cout) ? "PASS" : "FAIL");
    $display("  OFLOW     %0b           %0b           %s", exp.oflow, act.oflow,
             (exp.oflow == act.oflow) ? "PASS" : "FAIL");
    $display("  G         %0b           %0b           %s", exp.g, act.g,
             (exp.g == act.g) ? "PASS" : "FAIL");
    $display("  L         %0b           %0b           %s", exp.l, act.l,
             (exp.l == act.l) ? "PASS" : "FAIL");
    $display("  E         %0b           %0b           %s", exp.e, act.e,
             (exp.e == act.e) ? "PASS" : "FAIL");
    $display("  ERR       %0b           %0b           %s", exp.err, act.err,
             (exp.err == act.err) ? "PASS" : "FAIL");
    $display("========================================================================\n");
    
    // File output
    $fdisplay(bug_file, "------------------------------------------------------------------------");
    $fdisplay(bug_file, "BUG #%0d - Test #%0d", fail_cnt, total_cnt);
    $fdisplay(bug_file, "------------------------------------------------------------------------");
    $fdisplay(bug_file, "Time: %0t", $time);
    
    $fdisplay(bug_file, "\nINPUT STIMULUS:");
    $fdisplay(bug_file, "  Packet ID   = %0d", inp.pkt_id);
    $fdisplay(bug_file, "  MODE        = %s (%0b)", inp.mode ? "ARITHMETIC" : "LOGICAL", inp.mode);
    $fdisplay(bug_file, "  CMD         = %0d (0x%0h)", inp.cmd, inp.cmd);
    $fdisplay(bug_file, "  OPA         = 0x%0h (decimal: %0d, binary: %08b)", inp.opa, inp.opa, inp.opa);
    $fdisplay(bug_file, "  OPB         = 0x%0h (decimal: %0d, binary: %08b)", inp.opb, inp.opb, inp.opb);
    $fdisplay(bug_file, "  CIN         = %0b", inp.cin);
    $fdisplay(bug_file, "  INP_VALID   = %0b", inp.inp_valid);
    $fdisplay(bug_file, "  CE          = %0b", inp.ce);
    
    $fdisplay(bug_file, "\nMISMATCH DETAILS:");
    write_mismatches_to_file(exp, act);
    
    $fdisplay(bug_file, "\nCOMPLETE OUTPUT COMPARISON:");
    $fdisplay(bug_file, "  Signal    Expected    Actual      Status");
    $fdisplay(bug_file, "  ------    --------    ------      ------");
    $fdisplay(bug_file, "  RES       0x%03h      0x%03h       %s", exp.res, act.res,
              (exp.res == act.res) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "  COUT      %0b           %0b           %s", exp.cout, act.cout,
              (exp.cout == act.cout) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "  OFLOW     %0b           %0b           %s", exp.oflow, act.oflow,
              (exp.oflow == act.oflow) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "  G         %0b           %0b           %s", exp.g, act.g,
              (exp.g == act.g) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "  L         %0b           %0b           %s", exp.l, act.l,
              (exp.l == act.l) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "  E         %0b           %0b           %s", exp.e, act.e,
              (exp.e == act.e) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "  ERR       %0b           %0b           %s", exp.err, act.err,
              (exp.err == act.err) ? "PASS" : "FAIL");
    $fdisplay(bug_file, "\n");
    
  endfunction


  // Show which specific signals mismatched (console)
  function void show_mismatches(alu_packet exp, alu_packet act);
    if (exp.res !== act.res)
      $display("  ? RES MISMATCH: Expected=0x%0h, Got=0x%0h", exp.res, act.res);
    if (exp.cout !== act.cout)
      $display("  ? COUT MISMATCH: Expected=%0b, Got=%0b", exp.cout, act.cout);
    if (exp.oflow !== act.oflow)
      $display("  ? OFLOW MISMATCH: Expected=%0b, Got=%0b", exp.oflow, act.oflow);
    if (exp.g !== act.g)
      $display("  ? G MISMATCH: Expected=%0b, Got=%0b", exp.g, act.g);
    if (exp.l !== act.l)
      $display("  ? L MISMATCH: Expected=%0b, Got=%0b", exp.l, act.l);
    if (exp.e !== act.e)
      $display("  ? E MISMATCH: Expected=%0b, Got=%0b", exp.e, act.e);
    if (exp.err !== act.err)
      $display("  ? ERR MISMATCH: Expected=%0b, Got=%0b", exp.err, act.err);
  endfunction


  // Write mismatches to file
  function void write_mismatches_to_file(alu_packet exp, alu_packet act);
    if (exp.res !== act.res)
      $fdisplay(bug_file, "  - RES MISMATCH: Expected=0x%0h, Got=0x%0h", exp.res, act.res);
    if (exp.cout !== act.cout)
      $fdisplay(bug_file, "  - COUT MISMATCH: Expected=%0b, Got=%0b", exp.cout, act.cout);
    if (exp.oflow !== act.oflow)
      $fdisplay(bug_file, "  - OFLOW MISMATCH: Expected=%0b, Got=%0b", exp.oflow, act.oflow);
    if (exp.g !== act.g)
      $fdisplay(bug_file, "  - G MISMATCH: Expected=%0b, Got=%0b", exp.g, act.g);
    if (exp.l !== act.l)
      $fdisplay(bug_file, "  - L MISMATCH: Expected=%0b, Got=%0b", exp.l, act.l);
    if (exp.e !== act.e)
      $fdisplay(bug_file, "  - E MISMATCH: Expected=%0b, Got=%0b", exp.e, act.e);
    if (exp.err !== act.err)
      $fdisplay(bug_file, "  - ERR MISMATCH: Expected=%0b, Got=%0b", exp.err, act.err);
  endfunction


  // Compare packets
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


  // BUG FIX #13: Final report function
  function void report();
    real pass_percent;
    
    if (total_cnt > 0)
      pass_percent = (pass_cnt * 100.0) / total_cnt;
    else
      pass_percent = 0;
    
    // Console report
    $display("\n========================================================================");
    $display("FINAL VERIFICATION REPORT");
    $display("========================================================================");
    $display("Total Tests       : %0d", total_cnt);
    $display("Passed            : %0d", pass_cnt);
    $display("Failed (BUGS)     : %0d", fail_cnt);
    $display("Pass Percentage   : %0.2f%%", pass_percent);
    $display("========================================================================");
    
    if (fail_cnt > 0)
      $display("*** %0d BUGS DETECTED - See bug_report.log for details ***\n", fail_cnt);
    else
      $display("*** NO BUGS DETECTED - All tests passed! ***\n");
    
    // File report
    $fdisplay(bug_file, "\n========================================================================");
    $fdisplay(bug_file, "FINAL VERIFICATION SUMMARY");
    $fdisplay(bug_file, "========================================================================");
    $fdisplay(bug_file, "Total Tests       : %0d", total_cnt);
    $fdisplay(bug_file, "Passed            : %0d", pass_cnt);
    $fdisplay(bug_file, "Failed (BUGS)     : %0d", fail_cnt);
    $fdisplay(bug_file, "Pass Percentage   : %0.2f%%", pass_percent);
    $fdisplay(bug_file, "========================================================================");
    
    if (fail_cnt > 0)
      $fdisplay(bug_file, "\n*** %0d BUGS DETECTED ***", fail_cnt);
    else
      $fdisplay(bug_file, "\n*** NO BUGS DETECTED - All tests passed! ***");
    
    $fclose(bug_file);
  endfunction

endclas