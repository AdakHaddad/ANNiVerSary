module pe_tb;
    localparam WIDTH = 16;
    localparam FRAC_BIT = 10;
    reg [WIDTH-1:0] a_in;
    reg [WIDTH-1:0] y_in;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] a_out;
    wire [WIDTH-1:0] y_out;
    
    pe
    #(
        .WIDTH(WIDTH),
        .FRAC_BIT(FRAC_BIT)
    )
    pe_inst
    (
        .a_in(a_in),
        .y_in(y_in),
        .b(b),
        .a_out(a_out),
        .y_out(y_out)
    );
    
    task expect;
        input [WIDTH-1:0] exp_out;
        if (y_out !== exp_out) begin
            $display("TEST FAILED");
            $display("At time %0d a_in=%b y_in=%b b=%b a_out=%b y_out=%b",
                $time, a_in, y_in, b, a_out, y_out);
            $display("y_out should be %b", exp_out);
            $finish;
        end
        else begin
            $display("At time %0d a_in=%b y_in=%b b=%b a_out=%b y_out=%b",
                $time, a_in, y_in, b, a_out, y_out);
        end
    endtask
        
    initial begin

        a_in = 16'h0B00; y_in = 16'h0600; b = 16'h0500; #1 expect(16'h13C0);

        a_in = 16'hF300; y_in = 16'h0200; b = 16'h0800; #1 expect(16'hE800);

        a_in = 16'h1080; y_in = 16'h0900; b = 16'hFA00; #1 expect(16'hE180);

        a_in = 16'h0780; y_in = 16'hF600; b = 16'h0E00; #1 expect(16'h1040);

        a_in = 16'hE900; y_in = 16'h0C80; b = 16'hFC80; #1 expect(16'h2080);

        $display("TEST PASSED");
        $finish;
    end
    
endmodule
