cite about-alias
about-alias 'general aliases'

if ls --color -d . &> /dev/null
then
  alias ls="ls -aF --color=auto"
elif ls -GaF -d . &> /dev/null
then
  alias ls='ls -GaF'        # Compact view, show colors
fi

# List directory contents
alias l1='ls -1'

# colored grep
# Need to check an existing file for a pattern that will be found to ensure
# that the check works when on an OS that supports the color option
if grep --color=auto "a" "${BASH_IT}/"*.md &> /dev/null
then
  alias grep='grep --color=auto'
  export GREP_COLOR='1;33'
fi

alias less='less -EmrSw'

alias cls='clear'

alias irc="${IRC_CLIENT:=irc}"

alias ..='cd ..'         # Go up one directory
alias cd..='cd ..'       # Common misspelling for going up one directory

# Shell History
alias h='history'

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# nvim
if [ -x "$(which nvim 2>/dev/null)" ]
then
  alias vim="nvim"
fi

# Directory
alias md='mkdir -p'
alias rd='rmdir'

