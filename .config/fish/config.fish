# vim:foldmethod=marker

set -g fisher_path $HOME/.config/fisher-plugins
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]

if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $fisher_path/functions/fisher.fish
    set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
    fish -c fisher
end

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

fenv source $HOME/.nix-profile/etc/profile.d/nix.sh

if status --is-login
  
  #: gpg-agent {{{
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  #: }}}
end

#: gpg-agent {{{
set -x GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
#: }}}


set -x EDITOR vim

prepend_paths "$HOME/.nimble/bin"
prepend_paths "$HOME/.cargo/bin"
prepend_paths "$HOME/bin"

eval (direnv hook fish)
