# 2025-02-18T22:03:29.039148
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

vitis.dispose()

