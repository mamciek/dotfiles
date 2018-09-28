# vim:foldmethod=marker

if status --is-login
  source $HOME/.config/fish/nix.fish
  
  #: gpg-agent {{{
  set -x SSH_AUTH_SOCK "$HOME/.gnupg/S.gpg-agent.ssh"
  gpgconf --launch gpg-agent
  #: }}}
end

#: fisherman {{{
set -x fish_path $HOME/.config/fisherman-plugins

set -x fish_function_path $fish_path/functions $fish_function_path
set -x fish_complete_path $fish_path/completions $fish_complete_path

for file in $fish_path/conf.d/*.fish
  builtin source $file 2> /dev/null
end
#: }}}

set -x EDITOR vim

set -x PATH "$HOME/.cargo/bin" $PATH

eval (direnv hook fish)
