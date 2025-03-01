# 2025-02-28T20:52:14.561410
import vitis

client = vitis.create_client()
client.set_workspace(path="blinky_4")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../blinky_wrapper_7.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",generate_dtb = True)

platform = client.get_component(name="platform")
status = platform.build()

comp = client.create_app_component(name="blinky_4",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_psv_cortexa9_0")

comp = client.get_component(name="blinky_4")
comp.build()

proj = client.create_sys_project(name="system_project", platform="$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm", template="empty_accelerated_application")

proj = client.get_sys_project(name="system_project")

proj = proj.add_component(name="componentName")

vitis.dispose()

