# 2025-02-28T21:13:09.183861
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

comp = client.get_component(name="xgpio_example")
comp.build()

vitis.dispose()

