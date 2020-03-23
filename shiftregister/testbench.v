module test;

    reg clk;
    reg [7:0] data;
    reg shld = 0;
    wire outl, outr;

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


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1,test);

        clk = 0;
        data <= 8'b11011000;
        #1 shld = 1;
        #1 shld = 0;

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
