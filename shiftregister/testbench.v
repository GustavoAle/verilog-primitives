module test;

    reg clk;
    reg [7:0] data;
    reg shld = 0;
    reg latch = 0;
    wire outl, outr;
    wire [7:0] outpl;

    piso_right #(
        .INPUT_WIDTH(8),
        .VALUE_PULL(1'b1)
    )
    SHR(
        .clk(clk),
        .shift_load(shld),
        .serial_out(outr),
        .data(data)
    );

    piso_left #(
        .INPUT_WIDTH(8),
        .VALUE_PULL(1'b1)
    )
    SHL(
        .clk(clk),
        .shift_load(shld),
        .serial_out(outl),
        .data(data)
    );

    sipo_left #(
        .OUTPUT_WIDTH(8),
        .VALUE_PULL(1'b0)
    )
    PHL(
        .clk(clk),
        .serial_in(outl),
        .latch_clock(latch),
        .reset(shld),
        .data(outpl)
    );


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,test);

        clk = 0;
        data <= 8'b11011000;
        #1 shld = 1;
        #1 shld = 0;

        #17 latch = 1;
        #1 latch = 0;

        data <= 8'b00101000;
        #20 shld = 1;
        #1 shld = 0;


        #40 $finish;

    end

    always
    begin
       #1 clk = ~clk;
       #1 clk = ~clk;
    end

endmodule
