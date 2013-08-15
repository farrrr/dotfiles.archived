# bash configuration

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && source "$file"
done
unset file

# OPTIONS
set bell-style=visual
set nobeep
# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi


# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# Change iTerm2 Tab Title dynamically
TABTITLE=`hostname`
echo -e "\033];$TABTITLE\007"

[ -f /etc/profile.d/rvm.sh ] && source /etc/profile.d/rvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
