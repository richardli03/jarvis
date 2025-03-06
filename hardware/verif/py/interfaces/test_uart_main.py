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
    dut.rx = 0
    await ClockCycles(
        signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
    )

    # read bits
    read_data = random.randint(0, 2**buffer_width)
    for index in range(0, 8):
        dut.rx.value = (read_data >> index) & 0b1
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
        )

    # assert read data and read valid
    assert read_data == dut.read_data.value

    # idle and cooldown
    dut.rx.value = 1
    await ClockCycles(signal=dut.clk, num_cycles=5)


def test_spi_main():
    hardware.verif.py.cocotb_runner.run_cocotb(top="uart_main", deps=[])
