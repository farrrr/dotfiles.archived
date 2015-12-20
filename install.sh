#!/usr/bin/env bash

# ----- Setup Parameters -----
app_name='dotfiles'
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.dotfiles"
[ -z "$REPO_URI" ] && REPO_URL='https://github.com/farrrr/dotfiles.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='master'
debug_mode='1'
maintainer='far'

# ----- Basic Setup Tools -----
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

is_maintainer() {
    if [ $USER = $maintainer ]; then
        return 1
    fi

    return 0
}

# ----- Setup Functions -----
do_backup() {
    local need_backup=0
    for i in $*; do
        [ -e "$i" ] && need_backup=1
    done

    if [ $need_backup -eq 1 ]; then
        msg 'Attempting to back up your origin configuration.'
        today=`date +%Y%m%d_%s`
        for i in $*; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.today";
        done
        ret="$?"
        success "Your original configuration has been backed up."
        debug
    fi
}

sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"
    local repo_name="$4"

    msg "Trying to update $repo_name"

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name"
    fi

    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.tmux.conf"      "$target_path/.tmux.conf"
    lnif "$source_path/.zshrc"          "$target_path/.zshrc"
    lnif "$source_path/.gitconfig"      "$target_path/.gitconfig"

    if is_maintainer; then
        lnif "$source_path/.gitconfig.far"  "$target_path/.gitconfig.far"
    fi

    touch  "$target_path/.gitconfig.local"

    ret="$?"
    success "Setting up dotfiles symlinks."
    debug
}

create_config_dir() {
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi
}

setup_powerline() {
    create_config_dir
    lnif "$APP_PATH/powerline" "$HOME/.config/powerline"
}

# ----- Main() -----
variable_set "$HOME"
program_must_exist "git"

do_backup           "$HOME/.tmux.conf" \
                    "$HOME/.zshrc" \
                    "$HOME/.gitconfig"

sync_repo           "$APP_PATH" \
                    "$REPO_URI" \
                    "$REPO_BRANCH" \
                    "$app_name"

create_symlinks     "$APP_PATH" \
                    "$HOME"

setup_powerline
