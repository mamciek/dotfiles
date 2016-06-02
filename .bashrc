umask 0022

export EDITOR=vim
export HISTCONTROL=ignoreboth:erasedups
export XDG_CONFIG_HOME="$HOME/.config"

if [ -n "$DISPLAY" ]; then
    export BROWSER=chromium
fi

if [ "$HOSTNAME" = "ktr-mmazur" ]; then
    export GIT_AUTHOR_NAME="Maciej Mazur"
    export GIT_AUTHOR_EMAIL="Maciej.Mazur@komputronik.pl"
    export GIT_COMMITTER_NAME="Maciej Mazur"
    export GIT_COMMITTER_EMAIL="Maciej.Mazur@komputronik.pl"
    export GIT_SSH_USERNAME=m.mazur
fi

# aliases
alias ..='cd ..'
alias cd..='cd ..'
alias ls='LC_COLLATE=POSIX ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la --color | less -R'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias sudo='sudo '                  # pass aliases to sudo

# chicken
export CHICKEN_REPOSITORY=$HOME/.chicken/eggs

# fasd
eval "$(fasd --init auto)"
alias v='f -e vim'

