SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export XBOT2_DEFAULT_HW=ec_idle
export ECAT_MASTER_CONFIG="$SCRIPT_DIR/ecat/ecat_config.yaml"
alias ecat_master="stdbuf --output=L --error=L repl -f $ECAT_MASTER_CONFIG 2>&1 | tee /tmp/ecat-output"
alias ecat_master_gdb="gdb --args repl $ECAT_MASTER_CONFIG"
export CONCERT_LAUNCHER_ROS1_CONFIG="$SCRIPT_DIR/gui/ros1/nexus_launcher_config.yaml"
export CONCERT_LAUNCHER_ROS2_CONFIG="$SCRIPT_DIR/gui/ros2/nexus_launcher_config.yaml"

export XBOT2_CONFIG_ROS1="$SCRIPT_DIR/xbot2/nexus_basic_ros1.yaml"
export XBOT2_CONFIG_ROS2="$SCRIPT_DIR/xbot2/nexus_basic_ros2.yaml"

# Default to ROS 2 assets unless ROS_VERSION explicitly requests ROS 1.
case "${ROS_VERSION:-}" in
  1|ros1)
    export CONCERT_LAUNCHER_DEFAULT_CONFIG="$CONCERT_LAUNCHER_ROS1_CONFIG"
    set_xbot2_config "$XBOT2_CONFIG_ROS1"
    echo "INFO: Using ROS 1 configuration as per ROS_VERSION='${ROS_VERSION}'." >&2
    ;;
  2|ros2|"")
    export CONCERT_LAUNCHER_DEFAULT_CONFIG="$CONCERT_LAUNCHER_ROS2_CONFIG"
    set_xbot2_config "$XBOT2_CONFIG_ROS2"
    echo "INFO: Using ROS 2 configuration as per ROS_VERSION='${ROS_VERSION}'." >&2
    ;;
  *)
    echo "WARN: Unknown ROS_VERSION='${ROS_VERSION}'. Defaulting to ROS 2." >&2
    export CONCERT_LAUNCHER_DEFAULT_CONFIG="$CONCERT_LAUNCHER_ROS2_CONFIG"
    set_xbot2_config "$XBOT2_CONFIG_ROS2"
    ;;
esac