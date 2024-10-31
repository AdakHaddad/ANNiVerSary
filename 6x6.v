module systolic_6x6 #(
    parameter WIDTH=16,
    parameter FRAC_BIT=10
)(
    input wire clk, 
    input wire rst_n, 
    input wire en, 
    input wire clr,
    
    input wire signed [WIDTH-1:0] a0, a1, a2, a3, a4, a5,
    input wire signed [WIDTH-1:0] b00, b01, b02, b03, b04, b05,
    input wire signed [WIDTH-1:0] b10, b11, b12, b13, b14, b15,
    input wire signed [WIDTH-1:0] b20, b21, b22, b23, b24, b25,
    input wire signed [WIDTH-1:0] b30, b31, b32, b33, b34, b35,
    input wire signed [WIDTH-1:0] b40, b41, b42, b43, b44, b45,
    input wire signed [WIDTH-1:0] b50, b51, b52, b53, b54, b55,
    output wire signed [WIDTH-1:0] y0, y1, y2, y3, y4, y5
);

    // PE array connections
    wire signed [WIDTH-1:0] a_out [0:5][0:5];
    wire signed [WIDTH-1:0] y_out [0:5][0:5];
    
    // Generate PE array
    genvar i, j;
    generate
        for (i = 0; i < 6; i = i + 1) begin : row
            for (j = 0; j < 6; j = j + 1) begin : col
                pe #(
                    .WIDTH(WIDTH),
                    .FRAC_BIT(FRAC_BIT)
                ) pe_inst (
                    .a_in(i == 0 ? (j == 0 ? a0 : 
                                   j == 1 ? a1 :
                                   j == 2 ? a2 :
                                   j == 3 ? a3 :
                                   j == 4 ? a4 : a5) :
                           a_out[i-1][j]),
                    .b(j == 0 ? (i == 0 ? b00 :
                                i == 1 ? b10 :
                                i == 2 ? b20 :
                                i == 3 ? b30 :
                                i == 4 ? b40 : b50) :
                        j == 1 ? (i == 0 ? b01 :
                                 i == 1 ? b11 :
                                 i == 2 ? b21 :
                                 i == 3 ? b31 :
                                 i == 4 ? b41 : b51) :
                        j == 2 ? (i == 0 ? b02 :
                                 i == 1 ? b12 :
                                 i == 2 ? b22 :
                                 i == 3 ? b32 :
                                 i == 4 ? b42 : b52) :
                        j == 3 ? (i == 0 ? b03 :
                                 i == 1 ? b13 :
                                 i == 2 ? b23 :
                                 i == 3 ? b33 :
                                 i == 4 ? b43 : b53) :
                        j == 4 ? (i == 0 ? b04 :
                                 i == 1 ? b14 :
                                 i == 2 ? b24 :
                                 i == 3 ? b34 :
                                 i == 4 ? b44 : b54) :
                                (i == 0 ? b05 :
                                 i == 1 ? b15 :
                                 i == 2 ? b25 :
                                 i == 3 ? b35 :
                                 i == 4 ? b45 : b55)),
                    .y_in(j == 0 ? 0 : y_out[i][j-1]),
                    .a_out(a_out[i][j]),
                    .y_out(y_out[i][j])
                );
            end
        end
    endgenerate

    // Assign outputs
    assign y0 = y_out[0][5];
    assign y1 = y_out[1][5];
    assign y2 = y_out[2][5];
    assign y3 = y_out[3][5];
    assign y4 = y_out[4][5];
    assign y5 = y_out[5][5];

endmodule