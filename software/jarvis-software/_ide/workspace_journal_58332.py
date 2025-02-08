# 2025-02-06T01:05:08.654060
import vitis

client = vitis.create_client()
client.set_workspace(path="jarvis-software")

platform = client.get_component(name="platform")
status = platform.build()

vitis.dispose()

