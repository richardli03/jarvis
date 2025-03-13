# 2025-02-20T21:18:06.481314
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="blinky")
status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

comp.build()

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa")

platform = client.get_component(name="blinky")
status = platform.build()

comp.build()

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../hw_export/blinky_wrapper.xsa")

status = platform.build()

comp = client.get_component(name="xgpio_low_level_example")
comp.build()

client.delete_component(name="xgpio_example")

status = platform.build()

comp = client.get_component(name="xgpio_example")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="xgpio_example")

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../hw_export/blinky_wrapper.xsa")

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="xgpio_example")

client.delete_component(name="xgpio_low_level_example")

client.delete_component(name="platform")

client.delete_component(name="blinky")

platform = client.create_platform_component(name = "blink_v3",hw_design = "$COMPONENT_LOCATION/../hw_export/blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="blink_v3")
status = platform.build()

comp.build()

client.delete_component(name="xgpio_example")

client.delete_component(name="blink_v3")

platform = client.create_platform_component(name = "blinky_v4",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="blinky_v4")
status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa")

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa")

status = platform.build()

status = platform.build()

comp.build()

client.delete_component(name="xgpio_example")

client.delete_component(name="blinky_v4")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="platform")
status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa")

status = platform.build()

status = platform.build()

comp.build()

client.delete_component(name="platform")

client.delete_component(name="xgpio_example")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper_2.xsa")

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper_4.xsa")

status = platform.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper_4.xsa")

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper_5.xsa")

status = platform.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../blinky_wrapper_6.xsa")

status = platform.build()

client.delete_component(name="platform")

client.delete_component(name="xgpio_example")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../blinky_wrapper_6.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

status = platform.build()

comp.build()

client.delete_component(name="platform")

client.delete_component(name="xgpio_example")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../blinky_3/blinky_wrapper_7.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

status = platform.build()

comp.build()

