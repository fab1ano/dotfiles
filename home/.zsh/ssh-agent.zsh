typeset ssh_environment

# Don't do anything if we're root
if [[ $UID -eq 0 ]]; then
    return
fi

function start_ssh_agent() {
    echo starting ssh-agent ...
    mkdir -p ~/.ssh

    ssh-agent -s | sed 's/^echo/#echo/' >! $ssh_environment
    chmod 600 $ssh_environment
    source $ssh_environment > /dev/null
}

function save_ssh_environment() {
    echo saving SSH environment ...
    : > $ssh_environment  # Truncate or create the file

    if [[ -n "$SSH_AUTH_SOCK" ]]; then
        echo "export SSH_AUTH_SOCK='$SSH_AUTH_SOCK'" >> $ssh_environment
    fi

    if [[ -n "$SSH_AGENT_PID" ]]; then
        echo "export SSH_AGENT_PID='$SSH_AGENT_PID'" >> $ssh_environment
    fi

    chmod 600 $ssh_environment
}

function load_ssh_environment() {
    local verbose=${1:-true}
    local old_ssh_sock=$SSH_AUTH_SOCK
    local old_ssh_pid=$SSH_AGENT_PID

    source $ssh_environment

    if [[ "$SSH_AUTH_SOCK" != "$old_ssh_sock" || "$SSH_AGENT_PID" != "$old_ssh_pid" ]]; then
        if [[ "$verbose" == true ]]; then
            echo "SSH environment updated from $ssh_environment"
        fi
    fi
}

ssh_environment="$HOME/.ssh/environment-$HOST"

# Check if the parent process is sshd
parent_name=$(ps -o comm= -p $PPID)

if [[ "$parent_name" == "sshd" ]]; then
    if [[ -n "$SSH_AUTH_SOCK" ]]; then
        save_ssh_environment
    elif [[ -f "$ssh_environment" ]]; then
        load_ssh_environment
    fi
else
    if [[ -n "$SSH_TTY" ]]; then
        # On a server, load environment if it exists
        [[ -f "$ssh_environment" ]] && load_ssh_environment
    else
        # On a work station, start ssh-agent if not yet running
        if [[ -f "$ssh_environment" ]]; then
            load_ssh_environment false
            ps x | grep ssh-agent | grep -q "$SSH_AGENT_PID" || {
                start_ssh_agent
            }
        else
            start_ssh_agent
        fi
    fi
fi

# Function to reload the SSH environment
eval "
function reload_ssh_environment() {
    local ssh_env_file=\"$ssh_environment\"
    local old_ssh_sock=\$SSH_AUTH_SOCK
    local old_ssh_pid=\$SSH_AGENT_PID

    echo reloading SSH environment from \$ssh_env_file ...
    [[ -f \"\$ssh_env_file\" ]] && source \"\$ssh_env_file\"

    if [[ \"\$SSH_AUTH_SOCK\" != \"\$old_ssh_sock\" || \"\$SSH_AGENT_PID\" != \"\$old_ssh_pid\" ]]; then
        echo \"SSH environment changed.\"
    fi
}
"

unset ssh_environment
unfunction start_ssh_agent
unfunction save_ssh_environment
unfunction load_ssh_environment
