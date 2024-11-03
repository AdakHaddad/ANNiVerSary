`timescale 1ns/1ps
module systolic_6x6_tb;
    // Parameter untuk systolic_6x6
    parameter WIDTH = 16;
    parameter FRAC_BIT = 10;

    // Sinyal input untuk modul
    reg clk;
    reg rst_n;
    reg en;
    reg clr;
    reg signed [WIDTH-1:0] a0, a1, a2, a3, a4, a5;
    reg signed [WIDTH-1:0] b00, b01, b02, b03, b04, b05,
                           b10, b11, b12, b13, b14, b15, 
                           b20, b21, b22, b23, b24, b25,  
                           b30, b31, b32, b33, b34, b35,
                           b40, b41, b42, b43, b44, b45,
                           b50, b51, b52, b53, b54, b55;
    // Sinyal output untuk modul
    wire signed [WIDTH-1:0] y0, y1, y2, y3, y4, y5;

    // Instansiasi modul systolic_6x6
    AllSystolic6x6 #(
        .WIDTH(WIDTH),
        .FRAC_BIT(FRAC_BIT)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .a0(a0), .a1(a1), .a2(a2), .a3(a3), .a4(a4), .a5(a5),
        .b00(b00), .b01(b01), .b02(b02), .b03(b03), .b04(b04), .b05(b05),
        .b10(b10), .b11(b11), .b12(b12), .b13(b13), .b14(b14), .b15(b15), 
        .b20(b20), .b21(b21), .b22(b22), .b23(b23), .b24(b24), .b25(b25),  
        .b30(b30), .b31(b31), .b32(b32), .b33(b33), .b34(b34), .b35(b35),
        .b40(b40), .b41(b41), .b42(b42), .b43(b43), .b44(b44), .b45(b45),
        .b50(b50), .b51(b51), .b52(b52), .b53(b53), .b54(b54), .b55(b55),
        .y0(y0), .y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Inisialisasi sinyal
        clk = 0;
        rst_n = 0;
        en = 0;
        clr = 0;
        a0 = 0; a1 = 0; a2 = 0; a3 = 0; a4 = 0; a5 = 0;
        b00 = 0; b01 = 0; b02 = 0; b03 = 0; b04 = 0; b05 = 0;
        b10 = 0; b11 = 0; b12 = 0; b13 = 0; b14 = 0; b15 = 0; 
        b20 = 0; b21 = 0; b22 = 0; b23 = 0; b24 = 0; b25 = 0;  
        b30 = 0; b31 = 0; b32 = 0; b33 = 0; b34 = 0; b35 = 0;
        b40 = 0; b41 = 0; b42 = 0; b43 = 0; b44 = 0; b45 = 0;
        b50 = 0; b51 = 0; b52 = 0; b53 = 0; b54 = 0; b55 = 0;

        // Reset sistem
        #10;
        rst_n = 1;
        clr = 1;
        #10;
        clr = 0;

        // Berikan nilai pada input matriks dan aktifkan enable
        en = 1;
        a0 = 16'hFB33; a1 = 16'h0533; a2 = 16'h06CC; a3 = 16'hFACC; a4 = 16'hFACC; a5 = 16'h0000;
        b00 = 16'h0800; b01 = 16'h1C00; b02 = 16'h1800; b03 = 16'h0C00; b04 = 16'h1800; b05 = 16'h0C00;
        b10 = 16'h2800; b11 = 16'h0800; b12 = 16'h2000; b13 = 16'h2800; b14 = 16'h2400; b15 = 16'h0800; 
        b20 = 16'h1400; b21 = 16'h0C00; b22 = 16'h0400; b23 = 16'h0C00; b24 = 16'h1400; b25 = 16'h1800;  
        b30 = 16'h0C00; b31 = 16'h0C00; b32 = 16'h1800; b33 = 16'h0400; b34 = 16'h1800; b35 = 16'h2800;
        b40 = 16'h0400; b41 = 16'h0400; b42 = 16'h0400; b43 = 16'h0400; b44 = 16'h0400; b45 = 16'h0400;
        b50 = 16'h0000; b51 = 16'h0000; b52 = 16'h0000; b53 = 16'h0000; b54 = 16'h0000; b55 = 16'h0000;

        #10;
        a0 = 16'h0133; a1 = 16'h0200; a2 = 16'h00CC; a3 = 16'h0400; a4 = 16'hFC00; a5 = 16'h0000;
               
        #10;
        a0 = 16'h0266; a1 = 16'h0066; a2 = 16'h0333; a3 = 16'h0600; a4 = 16'hFC00; a5 = 16'h0000;
        
        #10;
        a0 = 16'h0533; a1 = 16'hFB33; a2 = 16'hFA66; a3 = 16'h0533; a4 = 16'hFC66; a5 = 16'h0000;
        
        #10;
        a0 = 16'h0533; a1 = 16'h0133; a2 = 16'h0200; a3 = 16'h0199; a4 = 16'hFC00; a5 = 16'h0000;
        
        #10;
        a0 = 16'h0000; a1 = 16'h0000; a2 = 16'h0000; a3 = 16'h0000; a4 = 16'h0000; a5 = 16'h0000;
        
        #10;
        a0 = 16'h0000; a1 = 16'h0000; a2 = 16'h0000; a3 = 16'h0000; a4 = 16'h0000; a5 = 16'h0000;
                
        #1000120;

        // Nonaktifkan enable
        en = 0;

        #10;
        $stop;
    end

    // Monitor output untuk debugging
    initial begin
        $monitor("Time: %0t | y0 = %h | y1 = %h | y2 = %h | y3 = %h | y4 = %h | y5 = %h",
                 $time, y0, y1, y2, y3, y4, y5);
    end
endmodule