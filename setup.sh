SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export XBOT2_DEFAULT_HW=ec_idle
export ECAT_MASTER_CONFIG="$SCRIPT_DIR/ecat/ecat_config.yaml"
alias ecat_master="stdbuf --output=L --error=L repl $ECAT_MASTER_CONFIG 2>&1 | tee /tmp/ecat-output"
alias ecat_master_gdb="gdb --args repl $ECAT_MASTER_CONFIG"
export CONCERT_LAUNCHER_DEFAULT_CONFIG="$SCRIPT_DIR/gui/ros1/nexus_launcher_config.yaml"
set_xbot2_config "$SCRIPT_DIR/nexus_basic.yaml"