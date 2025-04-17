# 2025-02-28T21:00:40.292630
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../blinky_wrapper_7.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",generate_dtb = True)

vitis.dispose()

