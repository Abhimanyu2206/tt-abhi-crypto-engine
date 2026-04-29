`default_nettype none

module mini_crypto_engine (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [7:0] data_in,
    input wire [7:0] key,
    output reg [7:0] data_out,
    output reg done
);

    localparam IDLE  = 2'b00;
    localparam LOAD  = 2'b01;
    localparam ROUND = 2'b10;
    localparam DONE  = 2'b11;

    reg [1:0] state, next_state;
    reg [7:0] state_reg;
    reg [2:0] round_count;

    wire [7:0] round_key;
    wire [7:0] xor_out;
    wire [7:0] rot_out;
    wire [7:0] sub_out;

    assign round_key = key ^ {5'b00000, round_count};

    assign xor_out = state_reg ^ round_key;
    assign rot_out = {xor_out[4:0], xor_out[7:5]};

    assign sub_out[7:4] = rot_out[3:0] ^ 4'b1010;
    assign sub_out[3:0] = rot_out[7:4] ^ 4'b0101;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            state_reg <= 8'b0;
            round_count <= 3'b0;
            data_out <= 8'b0;
            done <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: done <= 0;

                LOAD: begin
                    state_reg <= data_in;
                    round_count <= 0;
                end

                ROUND: begin
                    state_reg <= sub_out;
                    round_count <= round_count + 1;
                end

                DONE: begin
                    data_out <= state_reg;
                    done <= 1;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE:  next_state = start ? LOAD : IDLE;
            LOAD:  next_state = ROUND;
            ROUND: next_state = (round_count == 3) ? DONE : ROUND;
            DONE:  next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
