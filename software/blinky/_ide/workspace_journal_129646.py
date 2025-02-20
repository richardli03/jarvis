# 2025-02-13T20:51:15.146516
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

comp.build()

client.delete_component(name="xgpio_low_level_example")

client.delete_component(name="xgpio_tapp_example")

status = platform.build()

comp = client.get_component(name="xgpio_low_level_example")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

