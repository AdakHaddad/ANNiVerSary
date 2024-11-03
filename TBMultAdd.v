`timescale 1ns / 1ps

module TBMultAdd;

    // Inputs
    reg signed [15:0] a_in;
    reg signed [15:0] b;
    reg signed [15:0] y_in;

    // Outputs
    wire signed [15:0] a_out;
    wire signed [15:0] y_out;

    // Instantiate the module under test
    MultAdd dut (
        .a_in(a_in),
        .b(b),
        .y_in(y_in),
        .a_out(a_out),
        .y_out(y_out)
    );

    // Test scenarios
    initial begin
       a_in = 16'd32;   // 1 in Q1.10 format
        b = 16'd64;      // 2 in Q1.10 format
        y_in = 16'd96;   // Convert 3 to Q1.10 format
    #10; 

        // Wait for some time to observe the outputs
        #10;

        // Print the outputs in Q-format
        $display("a_in = %b (%f), b = %b (%f), y_in = %b (%f)", a_in, $itor(a_in) / (1 << 10), b, $itor(b) / (1 << 10), y_in, $itor(y_in) / (1 << 10));
        $display("a_out = %b (%f), y_out = %b (%f)", a_out, $itor(a_out) / (1 << 10), y_out, $itor(y_out) / (1 << 10));

        $finish;
    end

endmodule