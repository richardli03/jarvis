"""
Tests for UART module.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

from hardware.util.verif import repeat, parameterize


@cocotb.test()
@repeat(num_repeats=10)
async def uart_random_receive(dut, buffer_width: int = None):
    """
    Test random reads with a UART main.
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

    # start bit
    dut.rx.value = 0
    await ClockCycles(
        signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
    )

    # read bits
    read_data = random.randint(0, 2**buffer_width - 1)
    for index in range(0, 8):
        dut.rx.value = (read_data >> index) & 0b1
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
        )

    # assert read data and read valid
    assert dut.read_data.value == read_data
    # assert dut.read_valid.value == 1 #TODO: fix

    # stop bit
    dut.rx.value = 1
    await ClockCycles(
        signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
    )

    # idle and cooldown
    await ClockCycles(signal=dut.clk, num_cycles=5)


@cocotb.test()
@repeat(num_repeats=10)
async def uart_random_transmit(dut):
    """
    Test random writes with a UART main.
    """
    # setup module parameters and variables
    buffer_width = 8
    write_data = random.randint(0, 2**buffer_width - 1)
    clk_cycles_till_sample = int(dut.CLK_CYCLES_PER_BIT.value / 2)

    # setup clock
    clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
    clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)
    dut.rst_n.value = 1
    await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)

    # await for write_ready, continue if already high
    if not dut.write_ready.value:
        await RisingEdge(signal=dut.write_ready)
    dut.write_data.value = write_data
    dut.write_valid.value = 1

    # start bit
    await FallingEdge(signal=dut.tx)
    await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
    assert dut.tx.value == 0

    # write bits
    for index in range(0, 8):
        await ClockCycles(signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value)
        assert dut.tx.value == (write_data >> index) & 0b1
    await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)

    # stop transmit
    dut.write_valid.value = 0

    # stop bit
    await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
    assert dut.tx.value == 0b1

    # idle and cooldown
    await ClockCycles(signal=dut.clk, num_cycles=5)


@cocotb.test()
@repeat(num_repeats=10)
async def uart_random_full_duplex(dut):
    """
    Test random UART receive and transmit concurrently.
    """
    # setup module parameters and variables
    buffer_width = 8
    write_data = random.randint(0, 2**buffer_width - 1)
    clk_cycles_till_sample = int(dut.CLK_CYCLES_PER_BIT.value / 2)

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

    # await for write_ready, continue if already high
    if not dut.write_ready.value:
        await RisingEdge(signal=dut.write_ready)
    dut.write_data.value = write_data
    dut.write_valid.value = 1

    # start bit
    dut.rx.value = 0
    await FallingEdge(signal=dut.tx)
    await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
    assert dut.tx.value == 0

    # read and write bits
    read_data = random.randint(0, 2**buffer_width - 1)
    for index in range(0, 8):
        await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
        dut.rx.value = (read_data >> index) & 0b1
        await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
        assert dut.tx.value == (write_data >> index) & 0b1
    await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)

    # stop transmit and assert read data
    dut.write_valid.value = 0
    assert dut.read_data.value == read_data

    # stop bit
    await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
    assert dut.tx.value == 0b1

    # idle and cooldown
    dut.rx.value = 1
    await ClockCycles(signal=dut.clk, num_cycles=5)


def test_uart():
    hardware.verif.py.cocotb_runner.run_cocotb(top="uart", deps=["count_ones"])
