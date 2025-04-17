# 2025-02-28T21:04:24.838789
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

comp = client.get_component(name="blinky_4")
comp.build()

vitis.dispose()

