"""
This script will build software from scratch given a .xsa file and flash it onto your Zybo board.

To run this script, you need to have the Vitis command line tools installed.
Then, run `vitis -s build.py` in the terminal.
"""

import vitis
import os
import sys
import subprocess

## list_components


# Configuration
WORKSPACE = "blinky"  # relative path
XSA_FILE = "blinky_wrapper_7.xsa"  # Path to your XSA file
PLATFORM_NAME = "demo_platform"  # Name for the platform component
APP_NAME = "jarvis"  # Name for the application component

CPU_TYPE = "ps7_cortexa9_0"  # CPU type
OS_TYPE = "standalone"  # OS type

APP_TEMPLATE = "empty_application"


def db():
    user_confirmation = ""
    while user_confirmation.lower() not in ["y"]:
        user_confirmation = input("Do you want to continue? (y/n): ")
        if user_confirmation.lower() in ["n"]:
            # Close the client connection and terminate the vitis server
            vitis.dispose()
            raise RuntimeError("User chose not to continue")

    return user_confirmation.lower() == "y"


def run_bash(command, shell: bool = False):
    try:
        result = subprocess.run(
            command, capture_output=True, shell=shell, text=True, check=True
        )

    except subprocess.CalledProcessError as e:
        print(f"error was: {e.stderr.strip()}")
        raise RuntimeError(f"Failed to run command: {command}")
    finally:
        if result.stderr:
            return f"output: {result.stdout.strip()}\nerrors: {result.stderr.strip()}"
        else:
            return f"output: {result.stdout.strip()}"


def build_platform(client, platform_name, xsa_file, os_type):
    """Build the platform component from scratch. Used if the platform xpfm doesn't exist already

    :param client: Vitis client
    :type client: vitis.cli_client.Accelerated (i think)
    """

    # Create platform component
    print(f"Creating platform component '{platform_name}' from {xsa_file}...")
    platform_obj = client.create_platform_component(
        name=platform_name,
        hw_design=xsa_file,
        cpu=CPU_TYPE,
        os=os_type,
    )
    platform_obj.build()
    print(f"Platform component built successfully")

    return True


def build_application(client, app_name, platform_xpfm, template, os_type):
    """Build application from scratch
    :type os_type: _type_
    """
    print(f"Creating application component '{app_name}' using template '{template}'...")
    domain = f"{os_type}_{CPU_TYPE}"
    application_component = client.create_app_component(
        name=app_name,
        platform=platform_xpfm,
        domain=domain,
        template=template,
    )
    application_component.build()
    return True


def build():
    """Build a project from a .xsa file"""

    # Create a Vitis client
    try:
        client = vitis.create_client()
        client.set_workspace(WORKSPACE)
        print(f"Using workspace: {client.get_workspace()}")
    except Exception as e:
        raise RuntimeError(f"Failed to create Vitis client: {e}")

    # Check if platform already exists
    existing_platforms = client.list_platforms()
    print(f"Existing platforms: {existing_platforms}")
    # the 0th element of the tuple is the platform name

    if any(f"{PLATFORM_NAME}.xpfm" in platform[0] for platform in existing_platforms):
        print(f"Platform '{PLATFORM_NAME}' already exists here: {existing_platforms}")
    else:
        build_platform(client, PLATFORM_NAME, XSA_FILE, OS_TYPE)

    platform_xpfm = client.find_platform_in_repos(PLATFORM_NAME)
    print(f"Using platform: {platform_xpfm}")

    # Check if application already exists
    existing_apps = client.list_components()
    print(f"Existing applications: {existing_apps}")
    if any(APP_NAME == app["name"] for app in existing_apps):
        print(f"Application '{APP_NAME}' already exists, just rebuilding")
        app_component = client.get_component(APP_NAME)
        app_component.build()
    else:
        build_application(client, APP_NAME, platform_xpfm, APP_TEMPLATE, OS_TYPE)

    return True


def flash():
    print("Flashing the board...")
    output = run_bash(["xsct", "flash.tcl"])
    print(output)


if __name__ == "__main__":
    while True:
        user_confirmation = input("Build project? (y/n): ")
        if user_confirmation.lower() in ["yes", "y"]:
            success = build()
        else:
            success = True
            break

    if success:
        while True:
            user_confirmation = input("Flash the board? (y/n): ")
            if user_confirmation.lower() in ["yes", "y"]:
                flash()
                break
            elif user_confirmation.lower() in ["no", "n"]:
                print("not flashing!")
                break
    vitis.dispose()
