# 2025-02-18T21:08:51.102772
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

