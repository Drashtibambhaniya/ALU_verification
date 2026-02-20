// ========================================================================
// CORRECTED ALU Packet Class
// Bug fix: ROL/ROR constraints corrected
// ========================================================================

class alu_packet;
  int pkt_id;

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

  // Clock enable should be high most of the time
  constraint ce_c {
    ce dist {1 := 90, 0 := 10};
  }

  // Valid command range
  constraint cmd_range {
    cmd inside {[0:13]};  // 0-13 are valid commands
  }

  // BUG FIX #9: ROL/ROR constraints were wrong
  // INP_VALID must match command requirements
  constraint inp_valid_map {

    // ARITHMETIC MODE
    if (mode == 1) { 

      // Two operand arithmetic (both A and B needed)
      if (cmd inside {0,1,2,3,8,9,10})  // ADD, SUB, ADD_CIN, SUB_CIN, CMP, MUL_INC, MUL_SHIFT
        inp_valid == 2'b11;

      // Only A valid
      else if (cmd inside {4,5})  // INC_A, DEC_A
        inp_valid == 2'b01;

      // Only B valid
      else  // INC_B, DEC_B (cmd 6,7)
        inp_valid == 2'b10;   
    }

    // LOGICAL MODE
    else { 

      // Two operand logical (both A and B needed)
      if (cmd inside {0,1,2,3,4,5})  // AND, NAND, OR, NOR, XOR, XNOR
        inp_valid == 2'b11;

      // FIXED: ROL_A_B and ROR_A_B only need A valid
      // Only A valid (B is used but not as "valid operand")
      else if (cmd inside {6,8,9,12,13})  // NOT_A, SHR1_A, SHL1_A, ROL_A_B, ROR_A_B
        inp_valid == 2'b01;

      // Only B valid
      else  // NOT_B, SHR1_B, SHL1_B (cmd 7,10,11)
        inp_valid == 2'b10;
    }
  }

  // Constraint to generate rotate error cases sometimes
  constraint rotate_error {
    if (mode == 0 && (cmd == 12 || cmd == 13)) {
      // 30% chance of error condition (OPB[7:4] != 0)
      opb[7:4] dist {4'b0000 := 70, [4'b0001:4'b1111] := 30};
    }
  }

  // Display function for debugging
  function void display(string prefix = "");
    $display("%s [PKT_ID=%0d] MODE=%s CMD=%0d", 
             prefix, pkt_id, mode ? "ARITH" : "LOGIC", cmd);
    $display("%s   OPA=0x%0h OPB=0x%0h CIN=%0b INP_VALID=%0b CE=%0b", 
             prefix, opa, opb, cin, inp_valid, ce);
    $display("%s   RES=0x%0h COUT=%0b OFLOW=%0b G=%0b L=%0b E=%0b ERR=%0b",
             prefix, res, cout, oflow, g, l, e, err);
  endfunction

endclas