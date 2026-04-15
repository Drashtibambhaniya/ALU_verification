interface alu_interface (input logic clk, rst);

  logic [31:0] pkt_id; 
  
  //logic rst;
  logic ce;
  logic mode;
  logic [3:0] cmd;
  logic [1:0] inp_valid;
  logic [7:0] opa;
  logic [7:0] opb;
  logic cin;

  logic [9:0] res;
  logic cout;
  logic oflow;
  logic g;
  logic l;
  logic e;
  logic err;

  clocking drv_cb @(posedge clk);
   default input #0 output #0;    

    output pkt_id, rst, ce, mode, cmd, inp_valid, opa, opb, cin;
    input  res, cout, oflow, g, l, e, err;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #0 output #1; 

    input pkt_id, rst, ce, mode, cmd, inp_valid, opa, opb, cin;
    input res, cout, oflow, g, l, e, err;
  endclocking

endinterface
