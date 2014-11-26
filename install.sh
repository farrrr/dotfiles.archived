#!/usr/bin/env bash

## setup parameters
app_name='dotfiles'
app_dir="$HOME/.dotfiles"
debug_mode='0'

## basic setup tools
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\e[32m[✔]\e[0m ${1}${2}"
    fi
}

error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    type $1 >/dev/null 2>&1 || { local ret='1'; }

    # throw error on non-zero return value
    if [ ! "$ret" -eq '0' ]; then
        error "$2"
    fi
}

## setup functions
lnif() {
    if [ ! -e "$2" ]; then
        ln -s "$1" "$2"
    fi

    if [ -L "$2" ]; then
        if [ -d "$2" ]; then
            rm "$2"
        fi
        ln -sf "$1" "$2"
    fi

    ret="$?"
    debug
}

do_backup() {
    if [ -e "$2" ]; then
        today=`date +%Y%m%d_%s`
        [ -e "$2" ] && [ ! -L "$2" ] && mv "$2" "$2.today";
        ret="$?"
        success "$1"
        debug
    fi
}
create_config() {
    if [! -e "$HOME/.config" ]; then
        mkdir -p $HOME/.config
    fi
}

## main()
endpath="$app_dir"
for settings in ".gitconfig" ".osx" ".screenrc" ".tmux.conf"
do
    do_backup "$settings"
    lnif "$endpath/$settings"   "$HOME/$settings"
    success "creating symlink $settings"
done

do_backup "powerline"
create_config
lnif "$endpath/powerline" "$HOME/.config/powerline"
success "creating symlink powerline"
