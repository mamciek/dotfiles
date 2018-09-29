function os_type() {
    case "$OSTYPE" in
	linux*)   echo "linux" ;;
	darwin*)  echo "mac" ;;
	bsd*)     echo "bsd" ;;
	*)        echo "unknown" ;;
    esac
}

function prepend_path() {
  [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

#: gpg-agent {{{
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
#: }}}

umask 0022

export EDITOR=vim
export HISTCONTROL=ignoreboth:erasedups
export XDG_CONFIG_HOME="$HOME/.config"

alias ls='LC_COLLATE=POSIX ls -hF --color=auto'
if hash exa 2>/dev/null; then
    alias ls='exa'
fi
alias ll='ls -l'
alias la='ls -al'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias sudo='sudo '                  # pass aliases to sudo

# fasd
eval "$(fasd --init auto)"
alias v='f -e vim'

prepend_path "$HOME/.cargo/bin"
prepend_path "$HOME/bin"

if [ $(hostname) = "rq-mmazur.echostar.pl" -o $(hostname) = 'rq-mmazur' ]; then
   export GIT_COMMITTER_NAME="Maciej Mazur"
   export GIT_COMMITTER_EMAIL="mmazur@roq.ad"
   export GIT_AUTHOR_NAME="Maciej Mazur"
   export GIT_AUTHOR_EMAIL="mmazur@roq.ad"
else
   export GIT_COMMITTER_NAME="Maciej Mazur"
   export GIT_COMMITTER_EMAIL="mamciek@gmail.com"
   export GIT_AUTHOR_NAME="Maciej Mazur"
   export GIT_AUTHOR_EMAIL="mamciek@gmail.com"
fi

fbr() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

eval "$(direnv hook bash)"
