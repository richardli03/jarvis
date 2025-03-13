# 2025-02-18T22:30:32.755986
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.create_platform_component(name = "blink2",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

client.delete_component(name="platform")

client.delete_component(name="xgpio_example")

client.delete_component(name="xgpio_example")

platform = client.get_component(name="blink2")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = comp.clean()

status = platform.build()

comp.build()

