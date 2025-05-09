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
async def i2s_random_receive(dut, bit_depth: int = None):
    """
    Test random receives with a I2S peripheral.
    """
    # setup module parameters and variables
    bit_depth = 24

    # setup clock
    clock_period_ns = int(1e9 / 12e6)
    clock = Clock(signal=dut.mclk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.rx.value = 0  # I2S idle low

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.bclk, num_cycles=2, rising=True)
    dut.rst_n.value = 1

    # await start of lrclk frame
    await ClockCycles(signal=dut.rx_lrclk, num_cycles=1, rising=False)
    # I2S typically starts shifting out on the second falling edge of bclk
    # after falling edge of lrclk
    await ClockCycles(signal=dut.bclk, num_cycles=3, rising=False)

    for sample in range(0, 4):
        # receive bits
        receive_data = random.randint(0, 2**bit_depth - 1)
        for index in range(0, bit_depth):
            dut.rx.value = (receive_data >> (bit_depth - index - 1)) & 0b1
            await ClockCycles(signal=dut.bclk, num_cycles=1, rising=False)

        # assert receive data, receive valid, and lrclk
        assert dut.rx_data.value == receive_data
        assert dut.rx_valid.value == 1

        # pad rest of lrclk frame, assert lrclk
        assert dut.rx_lrclk.value == sample % 2
        await ClockCycles(signal=dut.bclk, num_cycles=32 - bit_depth, rising=False)


@cocotb.test()
@repeat(num_repeats=3)
async def i2s_random_transmit(dut, bit_depth: int = None):
    """
    Test random transmits with a I2S peripheral.
    """
    # setup module parameters and variables
    bit_depth = 24

    # setup clock
    clock_period_ns = int(1e9 / 12e6)
    clock = Clock(signal=dut.mclk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.tx_valid.value = 0

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.bclk, num_cycles=2, rising=True)
    dut.rst_n.value = 1

    # await for transmit_ready, continue if already high
    if not dut.tx_ready.value:
        await RisingEdge(signal=dut.tx_ready)
    transmit_data = random.randint(0, 2**bit_depth - 1)
    dut.tx_data.value = transmit_data
    dut.tx_valid.value = 1

    # await start of lrclk frame
    await ClockCycles(signal=dut.tx_lrclk, num_cycles=1, rising=False)
    # I2S typically starts shifting out on the second falling edge of bclk
    # after falling edge of lrclk
    await ClockCycles(signal=dut.bclk, num_cycles=2, rising=True)

    for sample in range(0, 4):
        # transmit bits
        for index in range(0, bit_depth):
            await ClockCycles(signal=dut.bclk, num_cycles=1, rising=True)
            assert dut.tx.value == (transmit_data >> (bit_depth - index - 1)) & 0b1

        # pad rest of lrclk frame, assert lrclk
        assert dut.tx_lrclk.value == sample % 2
        await ClockCycles(signal=dut.bclk, num_cycles=32 - bit_depth, rising=True)


@cocotb.test()
@repeat(num_repeats=3)
async def i2s_random_full_duplex(dut, bit_depth: int = None):
    """
    Test random transmit and receives with a I2S main.
    """
    # setup module parameters and variables
    bit_depth = 24

    # setup clock
    clock_period_ns = int(1e9 / 12e6)
    clock = Clock(signal=dut.mclk, period=clock_period_ns, units="ns")
    await cocotb.start(clock.start())

    # setup inputs
    dut.rx.value = 0  # I2S idle low
    dut.tx_valid.value = 0

    # reset
    dut.rst_n.value = 0
    await ClockCycles(signal=dut.bclk, num_cycles=2, rising=True)
    dut.rst_n.value = 1

    # await for transmit_ready, continue if already high
    if not dut.tx_ready.value:
        await RisingEdge(signal=dut.tx_ready)
    transmit_data = random.randint(0, 2**bit_depth - 1)
    dut.tx_data.value = transmit_data
    dut.tx_valid.value = 1

    # await start of lrclk frame
    await ClockCycles(signal=dut.rx_lrclk, num_cycles=1, rising=False)
    # I2S typically starts shifting out on the second falling edge of bclk
    # after falling edge of lrclk
    await ClockCycles(signal=dut.bclk, num_cycles=3, rising=False)  # 3.0

    for sample in range(0, 4):
        # transmit and receive bits
        receive_data = random.randint(0, 2**bit_depth - 1)
        for index in range(0, bit_depth):
            # apply rx value on falling edge
            dut.rx.value = (receive_data >> (bit_depth - index - 1)) & 0b1

            # assert tx value on rising edge
            await ClockCycles(signal=dut.bclk, num_cycles=1, rising=True)
            assert dut.tx.value == (transmit_data >> (bit_depth - index - 1)) & 0b1

            # complete cycle
            await ClockCycles(signal=dut.bclk, num_cycles=1, rising=False)

        # assert receive data, receive valid, and lrclk
        assert dut.rx_data.value == receive_data
        assert dut.rx_valid.value == 1

        # pad rest of lrclk frame, assert lrclk
        assert dut.rx_lrclk.value == sample % 2
        await ClockCycles(signal=dut.bclk, num_cycles=32 - bit_depth, rising=False)


def test_i2s():
    hardware.verif.py.cocotb_runner.run_cocotb(top="i2s", deps=[])
