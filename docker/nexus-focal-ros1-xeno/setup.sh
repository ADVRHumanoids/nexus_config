ros1(){
    local script_dir env_file
    script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    env_file="$script_dir/../nexus-config_ros1.env"

    if [ ! -f "$env_file" ]; then
        echo "Nexus docker environment file not found: $env_file" >&2
        return 1
    fi

    # shellcheck disable=SC1091
    source "$env_file"
    export NEXUS_ACTIVE_DOCKER_ENV=ros1

    cd "$script_dir" || return 1
    xhost +local:root
    echo "Running docker image from $PWD..."
    docker compose up dev -d --no-recreate
    docker compose exec dev bash
}
