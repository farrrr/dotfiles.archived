# Advance Aliases

# cat
if [[ -x "$(which bat 2>/dev/null)" ]]
then
  alias alias cat="bat"
fi

# ping
if [[ -x "$(which prettyping 2>/dev/null)" ]]
then
  alias alias ping="prettyping --nolegend"
fi

# ncdu
if [[ -x "$(which ncdu 2>/dev/null)" ]]
then
  alias alias du="ncdu --color dark -rr"
fi

# tree
if [[ ! -x "$(which tree 2>/dev/null)" ]]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# nvim
if [[ -x "$(which nvim 2>/dev/null)" ]]
then
  alias vim="nvim"
fi

# less
export LESS="-EfmrSwX"
# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"
# For colourful man pages (CLUG-Wiki style)
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export MANPAGER="less -X"

# path
pathmunge /usr/local/sbin
pathmunge /usr/local/opt/openssl/bin

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

