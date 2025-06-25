# nexus_xbot2
This package contains configuration files to control IIT's Nexus robot with the xbot2
RT middleware.

## Setup
1. make sure that hhcm's ethercat master is correcly installed and configured, i.e. running the command `repl` from command line results in the master running without errors
2. source the included `setup.sh` from the `.bashrc` file; this creates the alias `ecat_master`, to be used instead of directly calling `repl`; it internally calls `repl` with a proper configuration file for motors offsets and rotations signs that are specific to Nexus, and duplicates its standard output and standard error to the `/tmp/ecat-output` file

WARNING: calling `repl` directly must be avoided except for debugging purposes!

3. select the included basic configuration file for xbot2 with `set_xbot2_config <path-to-this-repo>/nexus_basic.yaml`

## Running the robot
The Nexus robot can be run from two terminals as follows:
- make sure the emergency button is released
- [terminal 1] run the `ecat_master` commands and wait until terminal output stops; this powers on the robot and establishes the ethercat communication with its slaves
- [terminal 2] run `xbot2-core --hw CTRL_MODE` (optionally with `--verbose`), where `CTRL_MODE` can be
    - `ec_pos` (motors start in position control mode)
    - `ec_imp` (motors start in impedance control mode)
    - `ec_idle` (motors are not started, and are turned off if needed)


A homing procedure can be optionally run at this point with `rosservice call /xbotcore/homing/switch 1`; note however that the homing module will not take care of (self) collision avoidance, and therefore care must be taken by the robot operator.

To control the robot from ROS, a specific module must be executed with `rosservice call /xbotcore/ros_control/switch 1` **before** any message is published to the `/xbotcore/command` topic. **WARNING:** make sure that no other plugin is sending commands to the robot (e.g., the homing) in order to avoid discontinuous references.

## Further information
Some more information is found [here](https://advrhumanoids.github.io/xbot2_wip/cheat.html)

## Reporting issues
Please use the [issue tracker](https://github.com/ADVRHumanoids/leonardo_centauro_documentation/issues)