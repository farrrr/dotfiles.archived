#!/usr/bin/env sh

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
    if [ -L $2 ] ; then
        if [ -d $2 ] ; then
            rm $2
        fi
        ln -sf $1 $2
    fi
}

readFileLink() {
    TARGET_FILE=$1

    cd `dirname $TARGET_FILE`
    TARGET_FILE=`basename $TARGET_FILE`

    # Iterate down a (possible) chain of symlinks
    while [ -L "$TARGET_FILE" ]
    do
        TARGET_FILE=`readlink $TARGET_FILE`
        cd `dirname $TARGET_FILE`
        TARGET_FILE=`basename $TARGET_FILE`
    done

    # Compute the canonicalized name by finding the physical path 
    # for the directory we're in and appending the target file.
    PHYS_DIR=`pwd -P`
    RESULT=$PHYS_DIR/$TARGET_FILE
    echo $RESULT
}

echo 'Installing dotfiles'
today=`date +%Y%m%d`

for i in $HOME/.bashrc $HOME/.aliases $HOME/.bash_prompt $HOME/.bash_profile $HOME/.functions $HOME/.exports $HOME/.gitconfig $HOME/.zshrc $HOME/.osx $HOME/.screenrc $HOME/.tmux.conf; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done

script="$(readFileLink $0)"
dotfilepath="$(dirname $script)"

echo 'setting up symlinks'
lnif $dotfilepath/.bashrc $HOME/.bashrc
lnif $dotfilepath/.bash_prompt $HOME/.bash_prompt
lnif $dotfilepath/.bash_profile $HOME/.bash_profile
lnif $dotfilepath/.aliases $HOME/.aliases
lnif $dotfilepath/.exports $HOME/.exports
lnif $dotfilepath/.functions $HOME/.functions
lnif $dotfilepath/.zshrc $HOME/.zshrc
lnif $dotfilepath/.screenrc $HOME/.screenrc
lnif $dotfilepath/.gitconfig $HOME/.gitconfig
lnif $dotfilepath/.tmux $HOME/.tmux
lnif $dotfilepath/.tmux.conf $HOME/.tmux.conf
lnif $dotfilepath/.osx $HOME/.osx

echo "Install Done"
