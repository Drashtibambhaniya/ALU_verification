import alu_pkg::*;

//arithmetic

class add_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { mode==1; inp_valid == 2'b11; cmd==4'h0; cin == 0; })
      else $fatal("[add_test_data] Randomization failed");
  endtask
endclass

class sub_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { mode==1; inp_valid == 2'b11; cmd==4'h1; cin == 0; })
      else $fatal("[sub_test_data] Randomization failed");
  endtask
endclass

class add_cin_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { mode==1; inp_valid == 2'b11; cmd==4'h2; cin == 1; })
      else $fatal("[add_cin_test_data] Randomization failed");
  endtask
endclass

class sub_cin_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { mode==1; inp_valid == 2'b11; cmd==4'h3; cin == 1;})
      else $fatal("[sub_cin_test_data] Randomization failed");
  endtask
endclass

class inc_a_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { mode==1; inp_valid == 2'b01; cmd==4'h4;})
      else $fatal("[inc_a_test_data] Randomization failed");
  endtask
endclass

class dec_a_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid == 2'b01; cmd==4'h5; opa == 8'd70; })
      else $fatal("[dec_a_test_data] Randomization failed");
  endtask
endclass

class inc_b_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h6; inp_valid == 2'b10; opb == 8'd22; })
      else $fatal("[inc_b_test_data] Randomization failed");
  endtask
endclass

class dec_b_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h7; inp_valid == 2'b10; opb == 8'd22; })
      else $fatal("[dec_b_test_data] Randomization failed");
  endtask
endclass

class cmp_gt_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h8; inp_valid == 2'b11; opa == 8'd5; opb == 8'd3;})
      else $fatal("[cmp_gt_test_data] Randomization failed");
  endtask
endclass

class cmp_lt_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h8; inp_valid == 2'b11; opa == 8'd4; opb == 8'd12;})
      else $fatal("[cmp_lt_test_data] Randomization failed");
  endtask
endclass

class cmp_eq_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h8; inp_valid == 2'b11; opa == 8'd25; opb == 8'd25;})
      else $fatal("[cmp_eq_test_data] Randomization failed");
  endtask
endclass

class mul_inc_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h9; inp_valid == 2'b11; opa == 8'd5; opb == 8'd8; })
      else $fatal("[mul_inc_test_data] Randomization failed");
  endtask
endclass

class mul_shift_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; cmd==4'hA; inp_valid == 2'b11; opa == 8'd4; opb == 8'd7; })
      else $fatal("[mul_shift_test_data] Randomization failed");
  endtask
endclass

// logical

class and_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h0; inp_valid == 2'b11; opa == 8'd5; opb == 8'd7;})
      else $fatal("[and_test_data] Randomization failed");
  endtask
endclass

class nand_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h1; inp_valid == 2'b11; opa == 8'd5; opb == 8'd7; })
      else $fatal("[nand_test_data] Randomization failed");
  endtask
endclass

class or_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h2; inp_valid == 2'b11; opa == 8'd5; opb == 8'd7; })
      else $fatal("[or_test_data] Randomization failed");
  endtask
endclass

class nor_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h3; inp_valid == 2'b11; opa == 8'd5; opb == 8'd7; })
      else $fatal("[nor_test_data] Randomization failed");
  endtask
endclass

class xor_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h4; inp_valid == 2'b11; opa == 8'd5; opb == 8'd7; })
      else $fatal("[xor_test_data] Randomization failed");
  endtask
endclass

class xnor_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h5; inp_valid == 2'b11; opa == 8'd7; opb == 8'd12;})
      else $fatal("[xnor_test_data] Randomization failed");
  endtask
endclass

class not_a_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h6; inp_valid == 2'b01; opa == 8'd45; })
      else $fatal("[not_a_test_data] Randomization failed");
  endtask
endclass

class not_b_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h7; inp_valid == 2'b10; opb == 8'd30;})
      else $fatal("[not_b_test_data] Randomization failed");
  endtask
endclass

class shr_a_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h8; inp_valid == 2'b01; opa == 8'b1000_0001;})
      else $fatal("[shr_a_test_data] Randomization failed");
  endtask
endclass

class shl_a_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'h9; inp_valid == 2'b01; opa == 8'b1000_0001;})
      else $fatal("[shl_a_test_data] Randomization failed");
  endtask
endclass

class shr_b_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'hA; inp_valid == 2'b10; opb == 8'b1000_0001; })
      else $fatal("[shr_b_test_data] Randomization failed");
  endtask
endclass

class shl_b_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'hB; inp_valid == 2'b10; opb == 8'b1000_0001; })
      else $fatal("[shl_b_test_data] Randomization failed");
  endtask
endclass


class rol_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'hC; inp_valid == 2'b11; opa == 8'd3; opb == 8'b1010_0010; })
      else $fatal("[rol_test_data] Randomization failed");
  endtask
endclass


class ror_test_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; cmd==4'hD; inp_valid == 2'b11; opa == 8'd3; opb == 8'b1010_0010; })
      else $fatal("[ror_test_data] Randomization failed");
  endtask
endclass



// RANDOM SCENARIOS 
// Same operations as directed test but opa, opb fully random
// Used in regression to hit coverage bins

// arithmetic
class add_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h0; })
      else $fatal(1, "[add_rand_data] Randomization failed");
  endtask
endclass

class sub_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h1; })
      else $fatal(1, "[sub_rand_data] Randomization failed");
  endtask
endclass

class add_cin_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h2; })
      else $fatal(1, "[add_cin_rand_data] Randomization failed");
  endtask
endclass

class sub_cin_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h3; })
      else $fatal(1, "[sub_cin_rand_data] Randomization failed");
  endtask
endclass

class inc_a_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b01; cmd==4'h4; })
      else $fatal(1, "[inc_a_rand_data] Randomization failed");
  endtask
endclass

class dec_a_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b01; cmd==4'h5; })
      else $fatal(1, "[dec_a_rand_data] Randomization failed");
  endtask
endclass

class inc_b_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b10; cmd==4'h6; })
      else $fatal(1, "[inc_b_rand_data] Randomization failed");
  endtask
endclass

class dec_b_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b10; cmd==4'h7; })
      else $fatal(1, "[dec_b_rand_data] Randomization failed");
  endtask
endclass

class cmp_gt_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h8; opa > opb; })
      else $fatal(1, "[cmp_gt_rand_data] Randomization failed");
  endtask
endclass

class cmp_lt_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h8; opa < opb; })
      else $fatal(1, "[cmp_lt_rand_data] Randomization failed");
  endtask
endclass

class cmp_eq_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h8; opa == opb; })
      else $fatal(1, "[cmp_eq_rand_data] Randomization failed");
  endtask
endclass

class mul_inc_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'h9; })
      else $fatal(1, "[mul_inc_rand_data] Randomization failed");
  endtask
endclass

class mul_shift_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==1; inp_valid==2'b11; cmd==4'hA; })
      else $fatal(1, "[mul_shift_rand_data] Randomization failed");
  endtask
endclass

// logical
class and_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'h0; })
      else $fatal(1, "[and_rand_data] Randomization failed");
  endtask
endclass

class nand_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'h1; })
      else $fatal(1, "[nand_rand_data] Randomization failed");
  endtask
endclass

class or_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'h2; })
      else $fatal(1, "[or_rand_data] Randomization failed");
  endtask
endclass

class nor_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'h3; })
      else $fatal(1, "[nor_rand_data] Randomization failed");
  endtask
endclass

class xor_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'h4; })
      else $fatal(1, "[xor_rand_data] Randomization failed");
  endtask
endclass

class xnor_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'h5; })
      else $fatal(1, "[xnor_rand_data] Randomization failed");
  endtask
endclass

class not_a_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b01; cmd==4'h6; })
      else $fatal(1, "[not_a_rand_data] Randomization failed");
  endtask
endclass

class not_b_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b10; cmd==4'h7; })
      else $fatal(1, "[not_b_rand_data] Randomization failed");
  endtask
endclass

class shr_a_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b01; cmd==4'h8; })
      else $fatal(1, "[shr_a_rand_data] Randomization failed");
  endtask
endclass

class shl_a_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b01; cmd==4'h9; })
      else $fatal(1, "[shl_a_rand_data] Randomization failed");
  endtask
endclass

class shr_b_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b10; cmd==4'hA; })
      else $fatal(1, "[shr_b_rand_data] Randomization failed");
  endtask
endclass

class shl_b_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b10; cmd==4'hB; })
      else $fatal(1, "[shl_b_rand_data] Randomization failed");
  endtask
endclass

class rol_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { ce==1; mode==0; inp_valid==2'b11; cmd==4'hC; })
      else $fatal(1, "[rol_rand_data] Randomization failed");
  endtask
endclass

class ror_rand_data extends alu_packet;
  task run();
    assert(this.randomize() with { rst==0; ce==1; mode==0; inp_valid==2'b11; cmd==4'hD; })
      else $fatal(1, "[ror_rand_data] Randomization failed");
  endtask
endclass

class no_input_data extends alu_packet;
  task run();
    inp_valid_map.constraint_mode(0); 
    assert(this.randomize() with {
      ce        == 1;
      inp_valid == 2'b00;
    }) else $fatal(1, "[no_input_data] Randomization failed");
  endtask
endclass

class ce_inactive_data extends alu_packet; 
  task run();
    ce_c.constraint_mode(0);
    inp_valid_map.constraint_mode(0);
    assert(this.randomize() with {
      ce        == 0;
      inp_valid == 2'b11;
      mode      == 1;
      cmd       == 4'h0;
    }) else $fatal(1, "[ce_inactive_data] Randomization failed");
  endtask
endclass

class opa_zero_data extends alu_packet;
  task run();          
    inp_valid_map.constraint_mode(0); 
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h0; inp_valid==2'b01; opa==0; })
      else $fatal(1, "[opa_zero_data] failed");
  endtask
endclass

class opb_zero_data extends alu_packet;
  task run();
    ce_c.constraint_mode(0);           
    inp_valid_map.constraint_mode(0); 
    assert(this.randomize() with { ce==1; mode==1; cmd==4'h0; inp_valid==2'b10; opb==0; })
      else $fatal(1, "[opb_zero_data] failed");
  endtask
endclass

class random_inp_valid extends alu_packet;
    task run();
        
        inp_valid_map.constraint_mode(0);
        assert(this.randomize() with {
            ce   == 1;
            mode == 1;
        });
    endtask
endclass

class rst_high_data extends alu_packet;
  task run();
    rst_c.constraint_mode(0);         
    inp_valid_map.constraint_mode(0); 
    assert(this.randomize() with {
      rst == 1'b1;
      ce  == 1;
    }) else $fatal(1, "[rst_high_data] Randomization failed");
  endtask
endclass
