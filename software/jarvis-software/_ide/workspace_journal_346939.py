# 2025-02-06T00:39:46.947531
import vitis

client = vitis.create_client()
client.set_workspace(path="jarvis-software")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../main_wrapper.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="xdevcfg_selftest_example")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

vitis.dispose()

