`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2024 12:03:00
// Design Name: 
// Module Name: MultAdd
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


module pe 
#(parameter WIDTH=16, 
FRAC_BIT=10)
(
    input wire [WIDTH-1:0] a_in, 
    input wire [WIDTH-1:0] b,     
    input wire [WIDTH-1:0] y_in,  
    output wire [WIDTH-1:0] a_out, 
    output wire [WIDTH-1:0] y_out 
);
    wire [WIDTH*2-1:0] ab;

assign ab=a_in*b;
    assign y_out = ab[WIDTH+FRAC_BIT-1:FRAC_BIT] + y_in;

    assign a_out = a_in;

endmodule