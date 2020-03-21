#
# Utility Functions and Options
#

#
# Colours
#
if (( terminfo[colors] >= 8 )); then

  # ls Colours
  if (( ${+commands[exa]} )); then
    # exa
    alias ls="exa -aF --group-directories-first"
  else
    if (( ${+commands[dircolors]} )); then
      # GNU
      (( ! ${+LS_COLORS} )) && if [[ -s ${HOME}/.dir_colors ]]; then
        eval "$(dircolors --sh ${HOME}/.dir_colors)"
      else
        export LS_COLORS='no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:ex=35:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1
        ;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;33:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.gz=1;31:*.tar
        =1;31:*.zip=1;31:*.lha=1;31:*.lzh=1;31:*.arj=1;31:*.tgz=1;31:*.taz=1;31:*.html=1;34:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;3
        6'
      fi

      alias ls="ls -aF --color=auto"
    else
      # BSD
      if (( ! ${+CLICOLOR} )) export CLICOLOR=1
      if (( ! ${+LSCOLORS} )) export LSCOLORS='gxfxbEaEBxxEhEhBaDaCaD'

      alias ls="ls -GaF"

      if [[ ${OSTYPE} == openbsd*  && ${+commands[colorls]} -ne 0 ]]; then
        alias ls="colorls"
      fi
    fi
  fi

  # grep Colours
  if (( ! ${+GREP_COLOR} )) export GREP_COLOR='37;45'                 # BSD
  if (( ! ${+GREP_COLORS} )) export GREP_COLOURS="mt=${GREP_COLOR}"   # GNU
  if [[ ${OSTYPE} == openbsd* ]]; then
    if (( ${+commands[ggrep]} )) alias grep='ggrep --color=auto'
  else 
    alias grep='grep --color=auto'
  fi

  # less Colours
  if [[ ${PAGER} == 'less' ]]; then
    if (( ! ${+LESS_TERMCAP_mb} )) export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
    if (( ! ${+LESS_TERMCAP_md} )) export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
    if (( ! ${+LESS_TERMCAP_me} )) export LESS_TERMCAP_me=$'\E[0m'      # End mode.
    if (( ! ${+LESS_TERMCAP_se} )) export LESS_TERMCAP_se=$'\E[27m'     # End standout-mode.
    if (( ! ${+LESS_TERMCAP_so} )) export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
    if (( ! ${+LESS_TERMCAP_ue} )) export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
    if (( ! ${+LESS_TERMCAP_us} )) export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
  fi
fi

#
# Advance aliases
#
if (( ${+commands[bat]} )); then
  alias cat='bat'
fi

if (( ${+commands[prettyping]} )); then
  alias ping='prettyping --nolegend'
fi

if (( ${+commands[ncdu]} )); then
  alias du='ncdu --color dark -rr'
fi

if (( ${+commands[tree]} )); then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

if (( ${+commands[nvim]} )); then
  alias vim='nvim'
fi
