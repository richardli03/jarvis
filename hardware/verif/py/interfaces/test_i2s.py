"""
Tests for I2S module.
"""

import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge, FallingEdge

import hardware.verif.py.cocotb_runner

from hardware.util.verif import repeat, parameterize


@cocotb.test()
@repeat(num_repeats=3)
async def i2s_random_read(dut, bit_depth: int = None):
    """
    Test random reads with a I2S main.
    """
    # setup module parameters and variables
    bit_depth = 24

    # setup clock
    clock_period_ns = int(1e9 / 12e6)
    clock = Clock(signal=dut.mclk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.rx.value = 0  # I2S idle high

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.mclk, num_cycles=2, rising=True)
    dut.rst_n.value = 1
    # await ClockCycles(signal=dut.mclk, num_cycles=5, rising=True)

    await ClockCycles(signal=dut.rx_lrclk, num_cycles=1, rising=False)
    await ClockCycles(
        signal=dut.bclk, num_cycles=1, rising=False
    )  # I2S typically starts shifting out on the second falling edge of bclk

    for sample in range(0, 4):
        # receive bits
        read_data = random.randint(0, 2**bit_depth - 1)
        for index in range(0, bit_depth):
            dut.rx.value = (read_data >> (bit_depth - index - 1)) & 0b1
            await ClockCycles(signal=dut.bclk, num_cycles=1, rising=False)

        # pad rest of lrclk frame, assert lrclk
        assert dut.rx_lrclk.value == sample % 2
        await ClockCycles(signal=dut.bclk, num_cycles=32 - bit_depth, rising=False)

        # assert receive data, receive valid, and lrclk
        assert dut.rx_data.value == read_data
        assert dut.rx_valid.value == 1


# @cocotb.test()
# @repeat(num_repeats=10)
# async def uart_random_write(dut):
#     """
#     Test random writes with a UART main.
#     """
#     # setup module parameters and variables
#     buffer_width = 8
#     write_data = random.randint(0, 2**buffer_width - 1)
#     clk_cycles_till_sample = int(dut.CLK_CYCLES_PER_BIT.value / 2)

#     # setup clock
#     clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
#     clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
#     await cocotb.start(clock.start())

#     # reset
#     dut.rst_n.value = 0
#     await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)
#     dut.rst_n.value = 1
#     await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)

#     # await for write_ready, continue if already high
#     if not dut.write_ready.value:
#         await RisingEdge(signal=dut.write_ready)
#     dut.write_data.value = write_data
#     dut.write_valid.value = 1

#     # start bit
#     await FallingEdge(signal=dut.tx)
#     await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
#     assert dut.tx.value == 0

#     # write bits
#     for index in range(0, 8):
#         await ClockCycles(signal=dut.clk, num_cycles=dut.CLK_CYCLES_PER_BIT.value)
#         assert dut.tx.value == (write_data >> index) & 0b1
#     await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)

#     # stop transmit
#     dut.write_valid.value = 0

#     # stop bit
#     await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
#     assert dut.tx.value == 0b1

#     # idle and cooldown
#     await ClockCycles(signal=dut.clk, num_cycles=5)


# @cocotb.test()
# @repeat(num_repeats=10)
# async def uart_random_full_duplex(dut):
#     """
#     Test random UART receive and transmit concurrently.
#     """
#     # setup module parameters and variables
#     buffer_width = 8
#     write_data = random.randint(0, 2**buffer_width - 1)
#     clk_cycles_till_sample = int(dut.CLK_CYCLES_PER_BIT.value / 2)

#     # setup clock
#     clock_period_ns = int(1e9 / dut.CLK_FREQ.value)
#     clock = Clock(signal=dut.clk, period=clock_period_ns, units="ns")
#     await cocotb.start(clock.start())

#     # setup inputs
#     dut.rx.value = 1  # UART idle high

#     # reset
#     dut.rst_n.value = 0
#     await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)
#     dut.rst_n.value = 1
#     await ClockCycles(signal=dut.clk, num_cycles=2, rising=True)

#     # await for write_ready, continue if already high
#     if not dut.write_ready.value:
#         await RisingEdge(signal=dut.write_ready)
#     dut.write_data.value = write_data
#     dut.write_valid.value = 1

#     # start bit
#     dut.rx.value = 0
#     await FallingEdge(signal=dut.tx)
#     await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
#     assert dut.tx.value == 0

#     # read and write bits
#     read_data = random.randint(0, 2**buffer_width - 1)
#     for index in range(0, 8):
#         await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
#         dut.rx.value = (read_data >> index) & 0b1
#         await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
#         assert dut.tx.value == (write_data >> index) & 0b1
#     await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)

#     # stop transmit and assert read data
#     dut.write_valid.value = 0
#     assert dut.read_data.value == read_data

#     # stop bit
#     await ClockCycles(signal=dut.clk, num_cycles=clk_cycles_till_sample)
#     assert dut.tx.value == 0b1

#     # idle and cooldown
#     dut.rx.value = 1
#     await ClockCycles(signal=dut.clk, num_cycles=5)


def test_i2s():
    hardware.verif.py.cocotb_runner.run_cocotb(top="i2s", deps=[])
