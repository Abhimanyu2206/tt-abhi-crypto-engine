/*
 * Copyright (c) 2024 Abhi
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_abhi_crypto (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    // INPUTS
    wire start = ui_in[0];      
    wire [7:0] data_in = ui_in; 
    wire [7:0] key = 8'hA5;     

    // OUTPUT FROM CORE
    wire [7:0] data_out;
    wire done;

    // YOUR CRYPTO ENGINE
    mini_crypto_engine core (
        .clk(clk),
        .rst(~rst_n),
        .start(start),
        .data_in(data_in),
        .key(key),
        .data_out(data_out),
        .done(done)
    );

    // FINAL OUTPUT
    assign uo_out = data_out;

    // UNUSED IO
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // PREVENT WARNINGS
    wire _unused = &{ena, uio_in};

endmodule
