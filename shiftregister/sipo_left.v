//------------------------------------------------------------------------------
//                            SHIFT REGISTER
//                      SERIAL-IN PARALLEL-OUT LEFT
//------------------------------------------------------------------------------

module sipo_left
#(
    parameter OUTPUT_WIDTH = 8,
    parameter VALUE_PULL = 1'b0
)
(
    input                           clk,
    input                           serial_in,
    input                           latch_clock,
    input                           reset,
    output reg [OUTPUT_WIDTH-1:0]   data
);

    reg [OUTPUT_WIDTH-1:0] shift_register;

    always @(posedge clk, posedge reset) begin
        if(reset) begin
            shift_register <= {OUTPUT_WIDTH{1'b0}};
            data <= {OUTPUT_WIDTH{1'b0}};
        end
        else begin
            shift_register <= (shift_register << 1) | serial_in;
        end
    end

    always @(posedge latch_clock) begin
        data <= shift_register;
    end


endmodule
