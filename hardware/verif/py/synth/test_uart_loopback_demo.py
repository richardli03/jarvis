"""
Test for UART loopback demo.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

from hardware.util.verif import repeat, parameterize

NUM_REPEATS = 2


@cocotb.test()
@repeat(num_repeats=1)
async def uart_random_loopback(dut):
    """
    Test loopback of random uart data.
    """
    # setup module parameters and variables
    buffer_width = 8

    # setup clock
    clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
    clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.rx.value = 1  # UART idle high

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)
    dut.rst_n.value = 1
    await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)

    # prev

    for _ in range(0, NUM_REPEATS):
        # start bit
        dut.rx.value = 0
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.uart_0.CLK_CYCLES_PER_BIT.value, rising=True
        )

        # read bits
        # read_data = random.randint(0, 2**buffer_width - 1)
        read_data = 0b10101001
        for index in range(0, 8):
            dut.rx.value = (read_data >> index) & 0b1
            await ClockCycles(
                signal=dut.clk,
                num_cycles=dut.uart_0.CLK_CYCLES_PER_BIT.value,
                rising=True,
            )

        # idle and cooldown
        dut.rx.value = 1
        await ClockCycles(signal=dut.clk, num_cycles=5)


def test_uart_loopback():
    hardware.verif.py.cocotb_runner.run_cocotb(
        top="uart_loopback_demo", deps=["uart", "count_ones"]
    )
