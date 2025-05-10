"""
Tests for I2C module.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

from hardware.util.verif import repeat, parameterize


@cocotb.test()
@repeat(num_repeats=1)
async def i2c_random_receive(dut, bit_depth: int = None):
    """
    Test random receives with a I2C peripheral.
    """
    # setup module parameters and variables
    # TODO

    # setup clock
    clock_period_ns = int(1e9 / 12e6)
    clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.mode.value = 0  # I2C read

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.clk, num_cycles=200, rising=True)
    dut.rst_n.value = 1

    dut.read_ready = 1
    await ClockCycles(signal=dut.clk, num_cycles=50000, rising=True)


def test_i2c():
    hardware.verif.py.cocotb_runner.run_cocotb(top="i2c_main", deps=[])
