#!/usr/bin/env sh

endpath="$HOME/.vimpeppers"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
}

# Backup existing .vim stuff
echo "Backing up current vim config\n"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done

if [ ! -e $endpath/.git ]; then
    echo "Cloning repo\n"
    git clone --recursive -b 3.0 http://github.com/repo $endpath
else
    echo "Updating updating repo\n"
    cd $endpath && git pull
fi

echo "Setting up symlinks"
lnif $endpath/.vimrc $HOME/.vimrc
lnif $endpath/.vim $HOME/.vim
if [ ! -d $endpath/.vim/bundle ]; then
    mkdir -p $endpath/.vim/bundle
fi

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "Installing plugins using Vundle"
vim -u $endpath/.vimrc.bundles - +BundleInstall! +BundleClean +qall
