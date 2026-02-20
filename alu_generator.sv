import alu_pkg::*;

class alu_generator;

  mailbox #(alu_packet) gen2drv_mb;
  int num_tx;
  static int id_count = 0; 
  event gen_done;
  
  function new(mailbox #(alu_packet) mb, int n = 10);
    this.gen2drv_mb = mb;
    this.num_tx     = n;
  endfunction


  task run();
    alu_packet pkt;

    $display("[%0t][GEN] Generator Started", $time);

    repeat (num_tx) begin
      
      pkt = new();
      assert(pkt.randomize());
      pkt.pkt_id = id_count++;

      
      //if (!pkt.randomize()) begin
        //$display("[%0t][GEN] Randomization Failed", $time);
      //end
      begin
       
        $display("\n------ GEN PACKET ID=%0d ------", pkt.pkt_id);
        $display("MODE=%0d CMD=%0d INP_VALID=%0d", pkt.mode, pkt.cmd, pkt.inp_valid);
        $display("OPA=%0d OPB=%0d CIN=%0d CE=%0d", pkt.opa, pkt.opb, pkt.cin, pkt.ce);
        //$display("RES=%0d COUT=%0d OFLOW=%0d", pkt.res, pkt.cout, pkt.oflow);
        //$display("G=%0d L=%0d E=%0d ERR=%0d", pkt.g, pkt.l, pkt.e, pkt.err); 
        //$display("-------------------------------\n");            

        gen2drv_mb.put(pkt);
      end

      #30;   
    end

    $display("[%0t]GEN] Generator Finished", $time);
    -> gen_done;
  endtask
  
  

endclass