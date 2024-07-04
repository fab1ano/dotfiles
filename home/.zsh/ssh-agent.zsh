typeset ssh_environment

function start_ssh_agent() {
	local lifetime

	echo starting ssh-agent...
	mkdir -p ~/.ssh

	ssh-agent -s | sed 's/^echo/#echo/' >! $ssh_environment
	chmod 600 $ssh_environment
	source $ssh_environment > /dev/null
}

ssh_environment="$HOME/.ssh/environment-$HOST"

if [[ $UID -ne 0 ]]; then
	if [[ -f "$ssh_environment" ]]; then
		source $ssh_environment > /dev/null
		ps x | grep ssh-agent | grep -q $SSH_AGENT_PID || {
			start_ssh_agent
		}
	else
		if [[ -z "$SSH_AUTH_SOCK" ]]; then
			start_ssh_agent
		fi
	fi
fi

unset ssh_environment
unfunction start_ssh_agent
