"""
Test for UART main.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

from hardware.util.verif import repeat, parameterize


# @parameterize(parameter_name="baud_rate", values=[115200, 250000])
@cocotb.test()
@repeat(num_repeats=10)
# @parameterize(parameter_name="buffer_width", values=[8, 16])
async def uart_main_random_read(dut, buffer_width: int = None):
    """
    Test random reads with a UART main.
    """
    # setup module parameters
    # dut.BUFFER_WIDTH.value = buffer_width #TODO: correct syntax
    buffer_width = 8

    # setup clock
    clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
    clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.rx.value = 1  # UART idle high
    dut.mode.value = 0  # read

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
    read_data = random.randint(0, 2**buffer_width)
    for index in range(0, 8):  # TODO: update for buffer width
        dut.rx.value = (read_data >> index) & 0b1
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
        )

    # assert read data and read valid
    assert dut.read_data.value == read_data
    # assert dut.read_valid.value == 1 #TODO: fix

    # idle and cooldown
    dut.rx.value = 1
    await ClockCycles(signal=dut.clk, num_cycles=5)


@cocotb.test()
@repeat(num_repeats=10)
async def uart_main_random_write(dut):
    """
    Test random writes with a UART main.
    """
    # setup module parameters and variables
    buffer_width = 8
    write_data = random.randint(0, 2**buffer_width)

    # setup clock
    clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
    clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.mode.value = 1  # write

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
    await ClockCycles(signal=dut.clk, num_cycles=dut.CLK_CYCLES_TIL_SAMPLE.value)
    assert dut.tx.value == 0

    # write bits
    for index in range(0, 8):
        await ClockCycles(signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value)
        assert dut.tx.value == (write_data >> index) & 0b1
    await ClockCycles(signal=dut.clk, num_cycles=dut.CLK_CYCLES_TIL_SAMPLE.value)

    # stop transmit
    dut.write_valid.value = 0

    # idle and cooldown
    await ClockCycles(signal=dut.clk, num_cycles=5)


# @cocotb.test()
# @repeat(num_repeats=1)
# async def uart_main_random_loopback(dut):
#     """
#     Test random loopback tests with a UART main.
#     """
#     pass


def test_uart_main():
    hardware.verif.py.cocotb_runner.run_cocotb(top="uart_main", deps=[])
