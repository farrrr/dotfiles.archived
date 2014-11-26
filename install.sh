#!/usr/bin/env bash

## setup parameters
app_name='dotfiles'
app_dir="$HOME/.dotfiles"
[ -z "$git_repo" ] && git_repo='farrrr/dotfiles'
git_branch='master'
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
    if [ ! -e "$HOME/.config" ]; then
        mkdir -p $HOME/.config
    fi
}

upgrade_repo() {
      msg "trying to update $1"

      if [ "$1" = "$app_name" ]; then
          cd "$app_dir" &&
          git pull origin "$git_branch"
      fi

      ret="$?"
      success "$2"
      debug
}

clone_repo() {
    program_exists "git" "Sorry, we cannot continue without GIT, please install it first."

    if [ ! -e "$app_dir" ]; then
        git clone --recursive -b "$git_branch" "$git_uri" "$app_dir"
        ret="$?"
        success "$1"
        debug
    else
        upgrade_repo "$app_name"    "Successfully updated $app_name"
    fi
}

## main()
endpath="$app_dir"

while true
do
    read -p "Do you wanna clone Repo over SSH? [Y/N]" RESP
    case $RESP
        in
        [yY])
            git_uri="git@github.com:$git_repo"
            break
            ;;
        [nN])
            git_uri="https://github.com/$git_repo"
            break
            ;;
        *)
            msg "Please enter Y or N"
            ;;
    esac
done

clone_repo  "Successfully cloned $app_name"

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
