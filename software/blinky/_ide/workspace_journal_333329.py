# 2025-02-28T20:53:56.353372
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = client.delete_sys_project(name="system_project")

vitis.dispose()

