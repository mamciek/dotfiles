logger -t dotfiles -p debug $BASH_SOURCE loaded

if [ -f $HOME/projects/config-user/home/.bashrc ]; then
    source $HOME/projects/config-user/home/.bashrc
fi

# fasd
if hash fasd 2>/dev/null ; then
    eval "$(fasd --init auto)"
    alias v='f -e vim'
else
    logger -t dotfiles -p err "fasd not found"
fi
