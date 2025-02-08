# 2025-02-07T22:38:58.863366
import vitis

client = vitis.create_client()
client.set_workspace(path="jarvis-software")

platform = client.get_component(name="platform")
status = platform.build()

