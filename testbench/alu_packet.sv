class alu_packet;
  int pkt_id;

  rand bit        rst; 
  rand bit        mode;       
  rand bit [3:0]  cmd;
  rand bit [1:0]  inp_valid;
  rand bit [7:0]  opa;
  rand bit [7:0]  opb;
  rand bit        cin;
  rand bit        ce;

  bit [8:0] res;
  bit cout;
  bit oflow;
  bit g;
  bit l;
  bit e;
  bit err;

  constraint ce_c {
    ce dist {1 := 90, 0 := 10};
  }

  constraint rst_c {
    rst dist {1'b0 := 95, 1'b1 := 5};
  }

  constraint cmd_range {
    if (mode == 1)       
      cmd inside {[0:10]};
    else                 
      cmd inside {[0:13]};
}

  constraint inp_valid_map {

    if (mode == 1) { 
      if (cmd inside {0,1,2,3,8,9,10})  // ADD, SUB, ADD_CIN, SUB_CIN, CMP, MUL_INC, MUL_SHIFT
        inp_valid == 2'b11;


      else if (cmd inside {4,5})  
        inp_valid == 2'b01;

      else  
        inp_valid == 2'b10;   
    }


    else { 

      if (cmd inside {0,1,2,3,4,5,12,13})  // AND, NAND, OR, NOR, XOR, XNOR
        inp_valid == 2'b11;

      else if (cmd inside {6,8,9})  // NOT_A, SHR1_A, SHL1_A, ROL_A_B, ROR_A_B
        inp_valid == 2'b01;

      else  
        inp_valid == 2'b10;
    }
  }

  constraint rotate_error {
    if (mode == 0 && (cmd == 12 || cmd == 13)) {
    
      opb[7:4] dist {4'b0000 := 70, [4'b0001:4'b1111] := 30};
    }
  }
  constraint mode_independent_c {
  mode dist { 0 := 50, 1 := 50 };
   }


  function void display(string prefix = "");
    $display("%s [PKT_ID=%0d] MODE=%s CMD=%0d", 
             prefix, pkt_id, mode ? "ARITH" : "LOGIC", cmd);
    $display("%s   OPA=0x%0h OPB=0x%0h CIN=%0b INP_VALID=%0b CE=%0b", 
             prefix, opa, opb, cin, inp_valid, ce);
    $display("%s   RES=0x%0h COUT=%0b OFLOW=%0b G=%0b L=%0b E=%0b ERR=%0b",
             prefix, res, cout, oflow, g, l, e, err);
  endfunction

endclass
