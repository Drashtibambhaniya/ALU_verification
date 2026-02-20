import alu_pkg::*;

class alu_driver;

  virtual alu_interface drv_vif;
  mailbox #(alu_packet) gen2drv_mb;

  function new(virtual alu_interface vif,
               mailbox #(alu_packet) mb);
    this.drv_vif    = vif;
    this.gen2drv_mb = mb;
  endfunction


  task reset_dut();
    $display("[%0t][DRV] Applying Reset",$time);

    drv_vif.drv_cb.rst <= 1;
    repeat (3) @(drv_vif.drv_cb);
    drv_vif.drv_cb.rst <= 0;

    $display("[%0t][DRV] Reset Released" ,$time);
  endtask


  task drive_pkt(alu_packet pkt);
    @(drv_vif.drv_cb);

    drv_vif.drv_cb.pkt_id    <= pkt.pkt_id;
    drv_vif.drv_cb.ce        <= pkt.ce;
    drv_vif.drv_cb.mode      <= pkt.mode;
    drv_vif.drv_cb.cmd       <= pkt.cmd;
    drv_vif.drv_cb.inp_valid <= pkt.inp_valid;
    drv_vif.drv_cb.opa       <= pkt.opa;
    drv_vif.drv_cb.opb       <= pkt.opb;
    drv_vif.drv_cb.cin       <= pkt.cin;


    @(drv_vif.drv_cb);


    

  endtask


  task run();
    alu_packet pkt;

    $display("[%0t][DRV] Driver Started", $time);

    forever begin
      gen2drv_mb.get(pkt);
      
      //$display("\n------ DRV PACKET ID=%0d ------", pkt.pkt_id);
      //$display("MODE=%0d CMD=%0d INP_VALID=%1d", pkt.mode, pkt.cmd, pkt.inp_valid);
      //$display("OPA=%0d OPB=%0d CIN=%0d CE=%0d", pkt.opa, pkt.opb, pkt.cin, pkt.ce);
      //$display("RES=%0d COUT=%0d OFLOW=%0d", pkt.res, pkt.cout, pkt.oflow);
      //$display("G=%0d L=%0d E=%0d ERR=%0d", pkt.g, pkt.l, pkt.e, pkt.err);    
      //$display("--------------------------------\n");

      drive_pkt(pkt);
    end
  endtask

endclas