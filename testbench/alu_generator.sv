import alu_pkg::*;

class alu_generator;

  mailbox #(alu_packet) gen2drv_mb;
  int pkt_count;
  event gen_done;

  function new(mailbox #(alu_packet) mb);
    this.gen2drv_mb = mb;
    this.pkt_count  = 0;
  endfunction

  task send_pkt(alu_packet pkt);
    pkt.pkt_id = pkt_count++;
    $display("\n------ GEN PACKET ID=%0d ------", pkt.pkt_id);
    $display("TIME = %0t MODE=%0d CMD=%0d INP_VALID=%0b",
             $time, pkt.mode, pkt.cmd, pkt.inp_valid);
    $display("OPA=%0d OPB=%0d CIN=%0d CE=%0d",
             pkt.opa, pkt.opb, pkt.cin, pkt.ce);
    gen2drv_mb.put(pkt);
  endtask

  task run();
    $display("[%0t][GEN] Generator Started", $time);
    ->gen_done;
  endtask

endclass
