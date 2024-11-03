`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2024 14:55:09
// Design Name: 
// Module Name: register
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


module register
#(parameter WIDTH=16)
(
input wire clk,rst_n,en,clr,
input wire signed [WIDTH-1:0] d,
output reg signed [WIDTH-1:0]q
    );
always@(posedge clk or negedge rst_n)
begin
if (!rst_n||clr)
 q<=16'b0;

else if (en)
q<=d;
end

endmodule
