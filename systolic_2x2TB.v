module systolic_2x2TB;

  parameter WIDTH = 16;
  parameter FRAC_BIT = 10;

  reg clk;
  reg rst_n;
  reg en;
  reg clr;
  reg signed [WIDTH-1:0] a0, a1;
  reg signed [WIDTH-1:0] b00, b01, b10, b11;
  wire signed [WIDTH-1:0] y0, y1;

  systolic_2x2 #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) dut (
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .clr(clr),
    .a0(a0),
    .a1(a1),
    .b00(b00),
    .b01(b01),
    .b10(b10),
    .b11(b11),
    .y0(y0),
    .y1(y1)
  );

  // Clock 
  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin
    rst_n = 0;
    en = 0;
    clr = 0;
    a0 = 0;
    a1 = 0;
    b00 = 0;
    b01 = 0;
    b10 = 0;
    b11 = 0;

    // reset
    #10 rst_n = 1;
    clr = 1;
    #10 clr = 0;

    #10 en = 1;

    //[1; 3] B Matrix
     a0 = 16'h0400;  // Q5.10 for 1
    a1 = 16'h0800;  // Q5.10 for 2
    
    //A Matrix
    b00 = 16'h0400; // Q5.10 for 1
    b01 = 16'h0800; // Q5.10 for 2
    b10 = 16'h0C00; // Q5.10 for 3
    b11 = 16'h1000; // Q5.10 for 4

    // Wait for the first column to propagate
    #20;

   //[2; 4] B Matrix
    a0 = 16'h0C00;  // Q5.10 for 3
    a1 = 16'h1000;  // Q5.10 for 4


    #100;

    $stop;
  end

  initial begin
    $monitor("Time=%0t | a0=%d, a1=%d, b00=%d, b01=%d, b10=%d, b11=%d | y0=%d, y1=%d",
             $time, a0, a1, b00, b01, b10, b11, y0, y1);
  end

endmodule
