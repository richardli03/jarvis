"""
Test for UART loopback demo.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

from hardware.util.verif import repeat, parameterize

NUM_REPEATS = 10
random.seed(123)


@cocotb.test()
async def uart_random_loopback(dut):
    """
    Test loopback of random uart data.
    """
    # setup module parameters and variables
    buffer_width = 8
    clk_cycles_till_sample = int(dut.uart_0.CLK_CYCLES_PER_BIT.value / 2)

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

    previous_read_data = 0b11111111

    for _ in range(0, NUM_REPEATS):
        # start bit
        dut.rx.value = 0
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.uart_0.CLK_CYCLES_PER_BIT.value, rising=True
        )

        # read bits
        read_data = random.randint(0, 2**buffer_width - 1)
        for index in range(0, 8):
            dut.rx.value = (read_data >> index) & 0b1
            await ClockCycles(
                signal=dut.clk,
                num_cycles=dut.uart_0.CLK_CYCLES_PER_BIT.value,
                rising=True,
            )

            # await ClockCycles(
            #     signal=dut.clk, num_cycles=dut.uart_0.clk_cycles_till_sample.value
            # )
            # await ClockCycles(
            #     signal=dut.clk, num_cycles=dut.uart_0.clk_cycles_till_sample.value
            # )
            # # assert (
            # #     dut.tx.value == (previous_read_data >> index) & 0b1
            # # )  # TODO: Fix or split into two test

        # idle and cooldown
        dut.rx.value = 1
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.uart_0.CLK_CYCLES_PER_BIT.value
        )

        previous_read_data = read_data

    # ensure additional bits are not transmitted
    await ClockCycles(
        signal=dut.clk,
        num_cycles=10 * dut.uart_0.CLK_CYCLES_PER_BIT.value,
        rising=True,
    )
    for index in range(0, 8):
        await ClockCycles(
            signal=dut.clk,
            num_cycles=dut.uart_0.CLK_CYCLES_PER_BIT.value,
            rising=True,
        )
        assert dut.tx.value == 0b1


def test_uart_loopback():
    hardware.verif.py.cocotb_runner.run_cocotb(
        top="uart_loopback_demo", deps=["uart", "count_ones"]
    )
