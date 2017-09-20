function os_type() {
    case "$OSTYPE" in
	linux*)   echo "linux" ;;
	darwin*)  echo "mac" ;;
	bsd*)     echo "bsd" ;;
	*)        echo "unknown" ;;
    esac
}

umask 0022

export EDITOR=vim
export HISTCONTROL=ignoreboth:erasedups
export XDG_CONFIG_HOME="$HOME/.config"

export PATH=$HOME/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

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

if [ -z "$DOTFILES_EXPENSIVE_INIT" ]; then
    #pyenv
    export PATH="/home/maciej/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    #rbenv
    eval "$(rbenv init -)"

    #nvm
    source /usr/share/nvm/init-nvm.sh

    export DOTFILES_EXPENSIVE_INIT=1
fi


# golang
export GOPATH=$HOME/projects/go

if [ $(hostname) = "ktr-mmazur" ]; then
   export GIT_COMMITTER_NAME="Maciej Mazur"
   export GIT_COMMITTER_EMAIL="Maciej.Mazur@komputronik.pl"
   export GIT_AUTHOR_NAME="Maciej Mazur"
   export GIT_AUTHOR_EMAIL="Maciej.Mazur@komputronik.pl"
else
   export GIT_COMMITTER_NAME="Maciej Mazur"
   export GIT_COMMITTER_EMAIL="mamciek@gmail.com"
   export GIT_AUTHOR_NAME="Maciej Mazur"
   export GIT_AUTHOR_EMAIL="mamciek@gmail.com"
fi
