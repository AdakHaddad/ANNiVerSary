`timescale 1ns / 1ps
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

module systolic_2x2 #(
    parameter WIDTH=16,
    parameter FRAC_BIT=10
)(
input wire clk, 
    input wire rst_n, 
    input wire en, 
    input wire clr,
    
    input wire signed [WIDTH-1:0] a0, a1, y00_in,y01_in,
    input wire signed [WIDTH-1:0] b00, b01, b10, b11,
    output wire signed [WIDTH-1:0] y0, y1, // Outputs of systolic array

    // Internal Wires (from systolic_2x2 module)
    wire signed [WIDTH-1:0] a00_in, a01_in,  a10_in, a11_in,
    wire signed [WIDTH-1:0]  y10_in, y11_in,

     wire signed [WIDTH-1:0] a0_reg0, a1_reg0, a1_reg1, // Registers for input propagation
     wire signed [WIDTH-1:0] a00_out, a01_out, a10_out, a11_out, // Outputs from each processing element (PE)
     wire signed [WIDTH-1:0] y00_out, y01_out, y0_tmp, y1_tmp, // Intermediate results from PEs
     wire signed [WIDTH-1:0] y0_reg0, y0_reg1, y1_reg0  // Registers for output accumulation  )        // Registers for output accumulation
);
    
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE00 (
        .a_in(a00_in),
        .b(b00),
        .y_in(y00_in),
        .a_out(a00_out),
        .y_out(y00_out)
    );

    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE01 (
        .a_in(a01_in),
        .b(b01),
        .y_in(y01_in),
        .a_out(a01_out),
        .y_out(y01_out)
    );

    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE10 (
        .a_in(a10_in),
        .b(b10),
        .y_in(y10_in),
        .a_out(a10_out),
        .y_out(y0_tmp)
    );

    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE11 (
        .a_in(a11_in),
        .b(b11),
        .y_in(y11_in),
        .a_out(a11_out),
        .y_out(y1_tmp)
    );
register #(.WIDTH(WIDTH)) reg_a0 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(a0),
        .q(a0_reg0)
    );
        assign a00_in=a0_reg0;

    register #(.WIDTH(WIDTH)) reg_a0_1 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(a00_out),
        .q(a01_in)
    );


    
    register #(.WIDTH(WIDTH)) reg_a1 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(a1),
        .q(a1_reg0)
    );

    register #(.WIDTH(WIDTH)) reg_a1_1 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(a1_reg0),
        .q(a1_reg1)
    );
    assign a10_in=a1_reg1;
    
    register #(.WIDTH(WIDTH)) reg_a1_2 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(a10_out),
        .q(a11_in)
    );

    register #(.WIDTH(WIDTH)) reg_y0 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(y00_out),
        .q(y10_in)
    );

    register #(.WIDTH(WIDTH)) reg_y0_1 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(y0_tmp),
        .q(y0_reg0)
    );
    register #(.WIDTH(WIDTH)) reg_y0_2 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(y0_reg0),
        .q(y0_reg1)
    );
    

    register #(.WIDTH(WIDTH)) reg_y1 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(y01_out),
        .q(y11_in)
    );
    
    register #(.WIDTH(WIDTH)) reg_y1_1 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(y1_tmp),
        .q(y1_reg0)
    );


    assign y0 = y0_reg1;  
    assign y1 = y1_reg0;  

endmodule