# Other shortcuts
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

alias c="xclip -sel clip"
alias l="ls -lh"
alias m="make"
alias v="nvim -p"
alias z="zathura"
alias d="docker"
alias s="ssh"
alias psgr="ps aux | grep"
alias gdb="gdb -q"

alias gr="grep"
alias rg="grep -rnI . -e"
alias rgw="grep -rnIw . -e"

alias g="git"
alias gd="git diff"
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gps="git push"
alias gpl="git pull"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gcl="git clone"

alias t="tmux"
alias tn="tmux new-session -s"
alias ta="tmux attach -t"

alias cin="clockify-cli in"
alias cout="clockify-cli out"

alias ..="cd .."
alias -2="cd ../.."
alias -3="cd ../../.."
alias -4="cd ../../../.."
alias -5="cd ../../../../.."
alias -6="cd ../../../../../.."
alias -7="cd ../../../../../../.."
alias -8="cd ../../../../../../../.."

alias ipy=ipython3

alias ash="adb shell"
alias ashi="expect -c 'spawn adb shell; expect \"\$\" { sleep 0.1; send \"alias l='\''ls -lh'\''\n\" }; interact'"
alias wad="watch -n 1 adb devices"

alias eusb="udisksctl power-off -b"

# Create dir and change to it
cdm() { mkdir -p $1 && cd $1; }

# transfer.sh
transfer() {
    curl --progress-bar --upload-file "$1" https://transfer.sh/$(basename $1) | tee /dev/null;
}
