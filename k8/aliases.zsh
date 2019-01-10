# if [ $commands[kubectl] ]; then
#   source <(kubectl completion zsh)
# fi

function k() {
    kubectl $@
}
function kuse() {
    kubectl config set-context $(kubectl config current-context) --namespace=$1
}

function kctx() {
    kubectl config set-context $1
}
function kns() {
    context=$(kubectl config current-context)
    kubectl config set-context $context --namespace=$1
}

function kdall() {
    for o in cm ds pvc svc po deploy ds sa statefulsets; do
     k get $o -n $1 | aq | xargs kubectl delete $o -n $1
    done
}
# Drop into an interactive terminal on a container
alias keti='k exec -ti'

dbash() {
    echo docker ps -qa --filter name=$1
    cid="$(docker ps -qa --filter name=$1)"
    echo docker exec -it $cid bash
     docker exec -it $cid bash
}

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='k config use-context'
alias kcsc='k config set-context'
alias kcdc='k config delete-context'
alias kccc='k config current-context'
alias kl='k logs'
alias kg='k get'
alias kd='k describe'

# Pod management.
alias kgp='k get pods'
alias klp='k logs pods'
alias kep='k edit pods'
alias kdp='k describe pods'
alias kdelp='k delete pods'

# Service management.
alias kgs='k get svc'
alias kes='k edit svc'
alias kds='k describe svc'
alias kdels='k delete svc'

# Secret management
alias kgsec='k get secret'
alias kdsec='k describe secret'
alias kdelsec='k delete secret'

# Deployment management.
alias kgd='k get deployment'
alias ked='k edit deployment'
alias kdd='k describe deployment'
alias kdeld='k delete deployment'
alias ksd='k scale deployment'
alias krsd='k rollout status deployment'

# Rollout management.
alias kgrs='k get rs'
alias krh='k rollout history'
alias kru='k rollout undo'
