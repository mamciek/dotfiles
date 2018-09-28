# vim:foldmethod=marker

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

#: gpg-agent {{{
export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
gpgconf --launch gpg-agent
#: }}}

source $HOME/.bashrc
