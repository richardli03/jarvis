# 2025-03-03T21:00:41.530112
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

platform = client.create_platform_component(name = "python-tester",hw_design = "$COMPONENT_LOCATION/../../blinky_wrapper_7.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",generate_dtb = True)

platform = client.get_component(name="python-tester")
status = platform.build()

vitis.dispose()

