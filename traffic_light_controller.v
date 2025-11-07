module traffic_light_controller (
    input wire clk,
    input wire rst,
    input wire button,
    output reg main_red,
    output reg main_yellow,
    output reg main_green,
    output reg side_red,
    output reg side_yellow,
    output reg side_green
);

    // State encoding
    parameter S0 = 3'b000, // both red
              S1 = 3'b001, // main yellow
              S2 = 3'b010, // main green
              S3 = 3'b011, // main red, side yellow
              S4 = 3'b100; // main red, side green

    reg [2:0] state, next_state;

    // Next-state logic
    always @(*) begin
        next_state = state;
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = (button) ? S3 : S0;
            S3: next_state = S4;
            S4: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // State transition
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        main_red    = 0;
        main_yellow = 0;
        main_green  = 0;
        side_red    = 0;
        side_yellow = 0;
        side_green  = 0;

        case (state)
            S0: begin main_red=1; side_red=1; end
            S1: begin main_yellow=1; side_red=1; end
            S2: begin main_green=1; side_red=1; end
            S3: begin main_red=1; side_yellow=1; end
            S4: begin main_red=1; side_green=1; end
        endcase
    end

endmodule