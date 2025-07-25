# ~/xbot2_ws/src/nexus_config/launcher/nexus_launcher.bash
#!/bin/bash

# Define directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source workspace setup if it exists

# Prioritize the root setup.bash file first
if [ -f ~/xbot2_ws/setup.bash ]; then
    echo "Sourcing space: ~/xbot2_ws/setup.bash"
    source ~/xbot2_ws/setup.bash

# If that doesn't exist, check for the 'devel' space
elif [ -f ~/xbot2_ws/devel/setup.bash ]; then
    echo "Sourcing devel space: ~/xbot2_ws/devel/setup.bash"
    source ~/xbot2_ws/devel/setup.bash

# If neither of the above exist, check for an 'install' space
elif [ -f ~/xbot2_ws/install/setup.bash ]; then
    echo "Sourcing install space: ~/xbot2_ws/install/setup.bash"
    source ~/xbot2_ws/install/setup.bash

# If none are found, print a warning
else
    echo "Warning: Could not find a valid workspace setup.bash file."
fi

# Check if concert_launcher is installed
if ! command -v concert_launcher &> /dev/null; then
    echo "Error: concert_launcher is not installed. Please install it first."
    echo "You can install it with: pip install --user concert_launcher"
    exit 1
fi

# Handle commands
COMMAND=$1
shift  # Remove first argument

case "$COMMAND" in
    sim)
        # Default simulation
        concert_launcher run sim_all "$@"
        ;;
    sim:*)
        # Simulation with variant)
        concert_launcher run "$COMMAND" "$@"
        ;;
    ecat)
        concert_launcher run ecat "$@"
        ;;
    status|kill|monitor)
        concert_launcher "$COMMAND" "$@"
        ;;
    *)
esac
#command should be like this ./nexus_launcher.bash real -p hw_type=ec_imp
#command should be like this ./nexus_launcher.bash real --ctrl ec_imp