`timescale 1ns/1ps

module tb_traffic_light_controller;

    reg clk;
    reg rst;
    reg button;
    wire main_red, main_yellow, main_green;
    wire side_red, side_yellow, side_green;

    // DUT instantiation
    traffic_light_controller dut (
        .clk(clk),
        .rst(rst),
        .button(button),
        .main_red(main_red),
        .main_yellow(main_yellow),
        .main_green(main_green),
        .side_red(side_red),
        .side_yellow(side_yellow),
        .side_green(side_green)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns period

    initial begin
        $dumpfile("traffic_light_controller.vcd");
        $dumpvars(0, tb_traffic_light_controller);

        // Initialize signals
        clk = 0;
        rst = 1;
        button = 0;

        // Reset pulse
        #10 rst = 0;

        // Normal sequence without button press
        #50;

        // Press button during main green
        button = 1;
        #10;
        button = 0;

        // Let it go through side sequence
        #50;

        // Another normal cycle
        #50;

        $finish;
    end

    // Monitor state outputs
    initial begin
        $display("Time\tState\tMain(R,Y,G)\tSide(R,Y,G)\tButton");
        $monitor("%0t\t%b\t%b%b%b\t%b%b%b\t%b",
                 $time, dut.state,
                 main_red, main_yellow, main_green,
                 side_red, side_yellow, side_green,
                 button);
    end

endmodule