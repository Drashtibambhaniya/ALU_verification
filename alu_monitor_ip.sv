import alu_pkg::*;

class alu_monitor_ip;

  virtual alu_interface vif;
  mailbox #(alu_packet) ip_mb;

  function new(virtual alu_interface vif,
               mailbox #(alu_packet) mb);
    this.vif   = vif;
    this.ip_mb = mb;
  endfunction


  task run();
    alu_packet pkt;

    forever begin
      @(vif.mon_cb);

      if (vif.mon_cb.rst)
        continue;

      if (!vif.mon_cb.ce)
        continue;

      pkt = new();

      // Capture INPUT side signals
      pkt.pkt_id    = vif.mon_cb.pkt_id;  
      pkt.mode      = vif.mon_cb.mode;
      pkt.cmd       = vif.mon_cb.cmd;
      pkt.inp_valid = vif.mon_cb.inp_valid;
      pkt.opa       = vif.mon_cb.opa;
      pkt.opb       = vif.mon_cb.opb;
      pkt.cin       = vif.mon_cb.cin;
      pkt.ce        = vif.mon_cb.ce;
      
      $display("\n------ INPUT MONITOR PACKET ID=%0d ------", pkt.pkt_id);
      $display("time = %0t MODE=%0d CMD=%0d INP_VALID=%1d", $time, pkt.mode, pkt.cmd, pkt.inp_valid);
      $display("OPA=%0d OPB=%0d CIN=%0d CE=%0d", pkt.opa, pkt.opb, pkt.cin, pkt.ce);
      $display("================================");   

      ip_mb.put(pkt);
    end
  endtask

endclas