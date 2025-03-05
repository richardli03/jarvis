# 2025-03-04T21:45:24.960187
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

comp = client.get_component(name="xgpio_example")
comp.build()

