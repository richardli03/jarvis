"""
Test for UART main.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

# from hardware.util.verif import repeat parameterize


@cocotb.test()
async def uart_main_random_read(dut):
    """
    Test random reads with a UART main.
    """
    # UART parameters
    baud_rate = 115200

    # Arrange
    clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
    clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # Reset
    dut.rst_n.value = 1
    await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)

    # Start bit
    dut.rx = 0
    await ClockCycles(
        signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
    )

    # Read bits #TODO: parameterize based on input buffer size
    read_data = 0b10101001
    for index in range(0, 8):
        dut.rx.value = (read_data >> index) & 0b1
        await ClockCycles(
            signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value, rising=True
        )


def test_spi_main():
    hardware.verif.py.cocotb_runner.run_cocotb(top="uart_main", deps=[])
