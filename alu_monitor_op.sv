import alu_pkg::*;

class alu_monitor_op;

  virtual alu_interface vif;
  mailbox #(alu_packet) op_mb;

  function new(virtual alu_interface vif,
               mailbox #(alu_packet) mb);
    this.vif   = vif;
    this.op_mb = mb;
  endfunction

  task run();
    alu_packet pkt;

    forever begin

      //if (vif.mon_cb.rst)
       //continue;

      //if (!vif.mon_cb.ce)
        //continue;

      repeat (3) @(vif.mon_cb);

      pkt = new();

      // Capture DUT OUTPUTS
      pkt.pkt_id = vif.mon_cb.pkt_id;
      pkt.res   = vif.mon_cb.res;
      pkt.cout  = vif.mon_cb.cout;
      pkt.oflow = vif.mon_cb.oflow;
      pkt.g     = vif.mon_cb.g;
      pkt.l     = vif.mon_cb.l;
      pkt.e     = vif.mon_cb.e;
      pkt.err   = vif.mon_cb.err;
      
      $display("\n------ OUTPUT MONITOR PACKET ID=%0d ------", pkt.pkt_id);
      $display("time = %0t RES=%0d COUT=%0d OFLOW=%0d",$time,pkt.res, pkt.cout, pkt.oflow);
      $display("G=%0d L=%0d E=%0d ERR=%0d", pkt.g, pkt.l, pkt.e, pkt.err);
      $display("========================================\n"); 

      // Send to Scoreboard
      op_mb.put(pkt);
    end
  endtask

endclas