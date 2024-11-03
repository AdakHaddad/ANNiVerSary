`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2024 09:33:55
// Design Name: 
// Module Name: register_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module register_tb;
    parameter T_CLK = 10;
    localparam WIDTH = 16;
    reg clk;
    reg rst_n;
    reg en;
    reg clr;
    reg [WIDTH-1:0] d;
    wire [WIDTH-1:0] q;
    
    register
    #(
        .WIDTH (WIDTH)
      )
      register_inst
      (
        .clk ( clk ),
        .rst_n (rst_n),
        .en (en),
        .clr (clr),
        .d (d),
        .q (q)
       );
 

        task expect;
        input [WIDTH-1:0] exp_out;
        if (q !== exp_out) begin
            $display("TEST FAILED");
            $display("At time %0d rst_n=%b en=%b clr=%b d=%b q=%b",
                $time, rst_n, en, clr, d, q);
            $display("q should be %b", exp_out);
            $finish;
         end
        else begin
            $display("TEST SUCCESS: At time %0d rst_n=%b en=%b clr=%b d=%b q=%b",
            $time, rst_n, en, clr, d, q);
        end
        endtask
        
  initial begin
    // Inisialisasi
    en  = 0;
    clr = 0;
    d = 16'd0;

    // Reset
    rst_n = 0;
    #(T_CLK*2);
    rst_n = 1;
    #(T_CLK*2);
    
    d = 16'd88;
    #(T_CLK);
    expect(16'd00);
    
    // Enable
    en = 1;
    d = 16'd168;
    #(T_CLK);
    expect(16'd168);

    // Clear    
    clr = 1;
    #(T_CLK);
    expect(16'd00);   
  end
  
  always 
  begin
    clk = 0;
    #(T_CLK/2);
    clk = 1;
    #(T_CLK/2);
  end
        
    
endmodule