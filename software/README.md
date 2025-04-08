# Software
TODO:
- add a central config file so you don't have to set it in python + args.tcl (idk how to pip install stuff to the vitis python version .o.)

# Building + Flashing:
The building/flashing script has been written to automate the building of new application components or platform components. Basically, if it exists, the script will just skip the creation step (platform component) or rebuild it (application component).

To build + flash the board, run `vitis -s build.py` in the terminal.

If you'd just like to flash, run `xsct flash.tcl` in the terminal. Or you can just run the script to rebuild the application component.

NOTE that if you make a change in the name of the application component or `.xsa`, you'll have to change it in `args.tcl` AND `build.py`. Working on a fix. 
