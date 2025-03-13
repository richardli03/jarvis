# 2025-02-20T14:58:21.229077
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.create_platform_component(name = "blinky",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="blink2")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

platform = client.get_component(name="blinky")
status = platform.build()

platform = client.get_component(name="blink2")
status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

platform = client.get_component(name="blinky")
status = platform.build()

platform = client.get_component(name="blink2")
status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="blink2")

comp.build()

comp.build()

platform = client.get_component(name="blinky")
status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa")

status = platform.build()

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa")

status = platform.build()

vitis.dispose()

