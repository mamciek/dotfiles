function os_type() {
    case "$OSTYPE" in
	linux*)   echo "linux" ;;
	darwin*)  echo "mac" ;;
	bsd*)     echo "bsd" ;;
	*)        echo "unknown" ;;
    esac
}

#nvm
export NVM_DIR="$HOME/.nvm"
if [ `os_type` == 'mac' ]; then
    source $HOME/.nvm/nvm.sh
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
else
    source /usr/share/nvm/init-nvm.sh
fi


