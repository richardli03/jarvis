# 2025-04-07T20:35:05.053821
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

comp = client.get_component(name="jarvis")
comp.build()

vitis.dispose()

