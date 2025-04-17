# 2025-02-28T21:09:48.535147
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

comp = client.get_component(name="xgpio_example")
comp.build()

vitis.dispose()

