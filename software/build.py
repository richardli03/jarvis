"""
This script will build software and flash it onto your Zybo board.

To run this script, you need to have the Vitis command line tools installed.
Then, run `vitis -s build.py` in the terminal.
"""

import vitis
import xdsb

CREATE_APP_COMPONENT = False
CREATE_PLATFORM_COMPONENT = False


def main():

    client = vitis.create_client()
    client.set_workspace("blinky_4")

    print(f"Current workspace: {client.get_workspace()}")
    PLATFORM_NAME = "platform"

    if CREATE_PLATFORM_COMPONENT:
        platform_obj = client.create_platform_component(
            name=PLATFORM_NAME,
            hw_design="blinky_wrapper_7.xsa",
            cpu="ps7_cortexa9_0",
            os="standalone",
        )
        platform_obj.build()

    platform_xpfm = client.find_platform_in_repos(PLATFORM_NAME)

    print("______________________________________________ RICHARD")
    print(platform_xpfm)
    print("___________________________________________-")

    APP_COMP_NAME = "xgpio_example"

    if CREATE_APP_COMPONENT:
        application_component = client.create_application_component(
            name=APP_COMP_NAME,
            platform=platform_xpfm,
            domain="standalone_ps7_cortexa9_0",
            template=None,
        )
    else:
        application_component = client.get_component(
            name=APP_COMP_NAME,
            # platform=platform_xpfm
            # domain="standalone_ps7_cortexa9_0",
        )
    application_component.build()

    print(application_component)


def flash():
    jtag = xdsb.jtag.Jtag()

    jtag.claim()
    jtag.open()


if __name__ == "__main__":
    main()
    flash
