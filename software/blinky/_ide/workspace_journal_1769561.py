# 2025-02-18T23:06:53.851281
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.get_component(name="blink2")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

status = comp.clean()

status = platform.build()

comp.build()

vitis.dispose()

