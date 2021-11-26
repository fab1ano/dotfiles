# docker-compose
docker-compose () {
    command docker-compose $*
    if [[ -z $DOCKERCOMPOSE_COMPLETE ]]
    then
        fpath=(/usr/local/share/zsh-completion $fpath)
        compinit
        DOCKERCOMPOSE_COMPLETE=1
    fi
}

# kubectl
kubectl () {
    command kubectl $*
    if [[ -z $KUBECTL_COMPLETE ]]
    then
        source <(command kubectl completion zsh)
        KUBECTL_COMPLETE=1
    fi
}
