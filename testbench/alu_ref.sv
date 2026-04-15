import alu_pkg::*;

class alu_reference_model;

  function alu_packet compute(alu_packet in_pkt);
    
    alu_packet exp_pkt;

    int rot_amt;
    logic [15:0] mul_tmp;

    exp_pkt = new();

    exp_pkt.pkt_id    = in_pkt.pkt_id;
    exp_pkt.mode      = in_pkt.mode;
    exp_pkt.cmd       = in_pkt.cmd;
    exp_pkt.inp_valid = in_pkt.inp_valid;
    exp_pkt.opa       = in_pkt.opa;
    exp_pkt.opb       = in_pkt.opb;
    exp_pkt.cin       = in_pkt.cin;
    exp_pkt.ce        = in_pkt.ce;

    exp_pkt.res   = 0;
    exp_pkt.cout  = 0;
    exp_pkt.oflow = 0;
    exp_pkt.g     = 0;
    exp_pkt.l     = 0;
    exp_pkt.e     = 0;
    exp_pkt.err   = 0;

    if (!in_pkt.ce)
      return exp_pkt;

    if (in_pkt.mode == 1) begin

      case (in_pkt.cmd)

        4'h0: begin // ADD
          exp_pkt.res  = {1'b0, in_pkt.opa} + {1'b0, in_pkt.opb};
          exp_pkt.cout = exp_pkt.res[8];
        end

        4'h1: begin // SUB
          exp_pkt.res   = {1'b0, in_pkt.opa} - {1'b0, in_pkt.opb};
          exp_pkt.oflow = (in_pkt.opa < in_pkt.opb);
        end

        4'h2: begin // ADD_CIN
          exp_pkt.res  = {1'b0, in_pkt.opa} + {1'b0, in_pkt.opb} + in_pkt.cin;
          exp_pkt.cout = exp_pkt.res[8];
        end

        4'h3: begin // SUB_CIN
          exp_pkt.res   = {1'b0, in_pkt.opa} - {1'b0, in_pkt.opb} - in_pkt.cin;
          exp_pkt.oflow = (in_pkt.opa < (in_pkt.opb + in_pkt.cin));
        end

        4'h4: begin // INC_A
          exp_pkt.res = {1'b0, in_pkt.opa} + 1;
        end

        4'h5: begin // DEC_A
          exp_pkt.res = {1'b0, in_pkt.opa} - 1;
        end

        4'h6: begin // INC_B
          exp_pkt.res = {1'b0, in_pkt.opb} + 1;
        end

        4'h7: begin // DEC_B
          exp_pkt.res = {1'b0, in_pkt.opb} - 1;
        end

        4'h8: begin // CMP
          if (in_pkt.opa == in_pkt.opb)      exp_pkt.e = 1;
          else if (in_pkt.opa > in_pkt.opb)  exp_pkt.g = 1;
          else                                exp_pkt.l = 1;
        end

        4'h9: begin // MUL_INC
          mul_tmp     = (in_pkt.opa + 1) * (in_pkt.opb + 1);
          exp_pkt.res = {1'b0, mul_tmp[7:0]};
        end

        4'hA: begin // MUL_SHIFT
          mul_tmp     = (in_pkt.opa << 1) * in_pkt.opb;
          exp_pkt.res = {1'b0, mul_tmp[7:0]};
        end

        default: exp_pkt.err = 1;

      endcase
    end

    else begin

      case (in_pkt.cmd)

        4'h0: exp_pkt.res = {1'b0, in_pkt.opa & in_pkt.opb};
        4'h1: exp_pkt.res = {1'b0, ~(in_pkt.opa & in_pkt.opb)};
        4'h2: exp_pkt.res = {1'b0, in_pkt.opa | in_pkt.opb};
        4'h3: exp_pkt.res = {1'b0, ~(in_pkt.opa | in_pkt.opb)};
        4'h4: exp_pkt.res = {1'b0, in_pkt.opa ^ in_pkt.opb};
        4'h5: exp_pkt.res = {1'b0, ~(in_pkt.opa ^ in_pkt.opb)};
        4'h6: exp_pkt.res = {1'b0, ~in_pkt.opa};
        4'h7: exp_pkt.res = {1'b0, ~in_pkt.opb};
        4'h8: exp_pkt.res = {1'b0, in_pkt.opa >> 1};
        4'h9: exp_pkt.res = {1'b0, in_pkt.opa << 1};
        4'hA: exp_pkt.res = {1'b0, in_pkt.opb >> 1};
        4'hB: exp_pkt.res = {1'b0, in_pkt.opb << 1};

        4'hC: begin // ROL
          if (in_pkt.opb[7:4] != 0) exp_pkt.err = 1;
          rot_amt = in_pkt.opb[2:0];
          if (rot_amt == 0)
            exp_pkt.res = {1'b0, in_pkt.opa};
          else
            exp_pkt.res = {1'b0,
              (in_pkt.opa << rot_amt) | (in_pkt.opa >> (8 - rot_amt))};
        end

        4'hD: begin // ROR
          if (in_pkt.opb[7:4] != 0) exp_pkt.err = 1;
          rot_amt = in_pkt.opb[2:0];
          if (rot_amt == 0)
            exp_pkt.res = {1'b0, in_pkt.opa};
          else
            exp_pkt.res = {1'b0,
              (in_pkt.opa >> rot_amt) | (in_pkt.opa << (8 - rot_amt))};
        end

        default: exp_pkt.err = 1;

      endcase
    end

    return exp_pkt;

  endfunction


  // get_cmd_name fuction returns command name associated with cmd value

  function string get_cmd_name(bit mode, bit [3:0] cmd);
    if (mode == 1) begin
      case (cmd)
        4'h0: return "ADD";
        4'h1: return "SUB";
        4'h2: return "ADD_CIN";
        4'h3: return "SUB_CIN";
        4'h4: return "INC_A";
        4'h5: return "DEC_A";
        4'h6: return "INC_B";
        4'h7: return "DEC_B";
        4'h8: return "CMP";
        4'h9: return "MUL_INC";
        4'hA: return "MUL_SHIFT";
        default: return "UNKNOWN";
      endcase
    end else begin
      case (cmd)
        4'h0: return "AND";
        4'h1: return "NAND";
        4'h2: return "OR";
        4'h3: return "NOR";
        4'h4: return "XOR";
        4'h5: return "XNOR";
        4'h6: return "NOT_A";
        4'h7: return "NOT_B";
        4'h8: return "SHR1_A";
        4'h9: return "SHL1_A";
        4'hA: return "SHR1_B";
        4'hB: return "SHL1_B";
        4'hC: return "ROL_A_B";
        4'hD: return "ROR_A_B";
        default: return "UNKNOWN";
      endcase
    end
  endfunction

endclass
