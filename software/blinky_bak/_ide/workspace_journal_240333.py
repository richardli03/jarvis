# 2025-02-18T21:21:52.887238
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

client.delete_component(name="xgpio_example_1")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = comp.clean()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = comp.clean()

status = platform.build()

comp.build()

client.delete_component(name="xgpio_example")

client.delete_component(name="xgpio_example_1")

status = platform.build()

comp.build()

vitis.dispose()

