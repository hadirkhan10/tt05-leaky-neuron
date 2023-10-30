import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles



@cocotb.test()
async def test_lif_neuron(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 1, units="ms")
    cocotb.start_soon(clock.start())

    # reset the circuit
    dut.rst_n.value = 0
    # wait for 5 clock cycles
    await ClockCycles(dut.clk, 5)
    # take the design out of reset
    dut.rst_n.value = 1
    # set the value of beta
    dut.ui_in.value = 1
    # go to the beta state
    dut.setting.value = 1
    await ClockCycles(dut.clk, 125)
    # go to the thresh state
    dut.setting.value = 2
    await ClockCycles(dut.clk, 1)
    # now set the value of threshold
    dut.ui_in.value = 32
    await ClockCycles(dut.clk, 5)
    # go to the read state
    dut.setting.value = 3
    await ClockCycles(dut.clk, 1)
    # set the current value
    dut.ui_in.value = 20
    await ClockCycles(dut.clk, 50)
    # start with new configuration
    # - beta = 0.75
    # - thres = 127
    # - current = 50
    dut.setting.value = 0
    await ClockCycles(dut.clk, 5)
    # set the value of beta
    dut.ui_in.value = 2
    # go to the beta state
    dut.setting.value = 1
    await ClockCycles(dut.clk, 2)
    # go to the thresh state
    dut.setting.value = 2
    await ClockCycles(dut.clk, 1)
    # now set the value of threshold
    dut.ui_in.value = 128
    await ClockCycles(dut.clk, 5)
    # go to the read state
    dut.setting.value = 3
    await ClockCycles(dut.clk, 1)
    # set the current value
    dut.ui_in.value = 50
    await ClockCycles(dut.clk, 550)

