//------------------------------------------------------------------------------
//                            SHIFT REGISTER
//                    PARALLEL-IN SERIAL-OUT LEFT
//------------------------------------------------------------------------------

module piso_left
#(
    parameter INPUT_WIDTH = 8,  // register size
    parameter VALUE_PULL =  1'b0   // complementary bit value
)
(
    input                       clk,
    input [INPUT_WIDTH-1:0]     data,
    input                       shift_load, //0: shift, 1: load
    output wire                 serial_out
);

    reg [INPUT_WIDTH-1:0]       internal_reg;

    assign serial_out = internal_reg[INPUT_WIDTH-1];

    always @(posedge clk, posedge shift_load) begin
        if(shift_load) begin
            internal_reg <= data;
        end
        else begin
            internal_reg <= (internal_reg << 1) | VALUE_PULL;
        end


    end

endmodule
