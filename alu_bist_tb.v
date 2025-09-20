
module tb_alu_bist_top;

    // Clock and reset signals
    reg clk;
    reg reset;
    reg bist_start;

    // BIST outputs
    wire bist_done;
    wire bist_pass;
    wire bist_fail;

    // Instantiate the alu_bist_top module
    alu_bist_top UUT (
        .clk(clk),
        .reset(reset),
        .bist_start(bist_start),
        .bist_done(bist_done),
        .bist_pass(bist_pass),
        .bist_fail(bist_fail)
    );

    // Generate clock signal (100 MHz)
    always #5 clk = ~clk;

    // Testbench initial block
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        bist_start = 0;

        // Apply reset for a few clock cycles
        #20; // Reset for 20 time units (4 clock cycles)
        reset = 0; // Release reset after 20 time units

        // Pulse the bist_start signal
        bist_start = 1;
        #10; // Wait for one clock cycle
        bist_start = 0;

        // Wait until bist_done is asserted
        wait(bist_done);

        // Check the results
        if (bist_pass) begin
            $display("PASS");
        end else begin
            $display("FAIL");
        end

        // End simulation
        $finish;
    end

endmodule
