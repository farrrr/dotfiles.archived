# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###
# @Author: Far Tseng
# vim: syntax=zsh:foldmarker=[[[,]]]:foldmethod=marker
###

export ZLE_RPROMPT_INDENT=0

# zinit [[[
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# ]]]

# Plugins [[[
zinit load zdharma-continuum/zui
zinit light zdharma-continuum/zinit-annex-meta-plugins 
zinit light-mode lucid for annexes zsh-users+fast zdharma console-tools ext-git

# SSH-AGENT
zinit light bobsoppe/zsh-ssh-agent

zinit light-mode lucid for \
  OMZL::completion.zsh \
  OMZL::correction.zsh \
  OMZL::history.zsh \
  OMZL::key-bindings.zsh \
  OMZL::theme-and-appearance.zsh

zinit wait lucid for \
  OMZP::aws \
  OMZP::colored-man-pages \
  OMZP::command-not-found \
  OMZP::encode64 \
  OMZP::extract \
  OMZP::gcloud \
  OMZP::gh \
  OMZP::sudo \
  OMZP::systemadmin
# ]]]

# Utilities [[[
# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target.
zinit ice wait lucid as"program" depth"1" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# Prettify ls
if (( $+commands[gls] )); then
    alias ls='gls --color=tty --group-directories-first'
else
    alias ls='ls --color=tty --group-directories-first'
fi

# Homebrew completion
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# Modern Unix commands
# See https://github.com/ibraheemdev/modern-unix
zinit as"null" wait lucid from"gh-r" for \
      atload"alias ls='exa -aF --color=auto --group-directories-first'; alias la='ls -laFh'" cp"**/exa.1 -> $ZPFX/share/man/man1" mv"**/exa.zsh -> $ZINIT[COMPLETIONS_DIR]/_exa" sbin"**/exa" if'[[ $OSTYPE != linux* && $CPUTYPE != aarch* ]]' ogham/exa \
      atload"alias cat='bat -p --wrap character'" mv"**/bat.1 -> $ZPFX/share/man/man1" cp"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" sbin"**/bat" @sharkdp/bat \
      mv"**/fd.1 -> $ZPFX/share/man/man1" cp"**/autocomplete/_fd -> $ZINIT[COMPLETIONS_DIR]" sbin"**/fd" @sharkdp/fd \
      mv"**/hyperfine.1 -> $ZPFX/share/man/man1" cp"**/autocomplete/_hyperfine -> $ZINIT[COMPLETIONS_DIR]" sbin"**/hyperfine" @sharkdp/hyperfine \
      cp"**/completion/_btm -> $ZINIT[COMPLETIONS_DIR]" atload"alias top=btm" sbin ClementTsang/bottom \
      atload"alias help=cheat" mv"cheat* -> cheat" sbin cheat/cheat \
      atload"alias diff=delta" sbin"**/delta" dandavison/delta \
      atload"alias df=duf" bpick"*(.zip|tar.gz)" sbin muesli/duf \
      atload"alias du=dust" sbin"**/dust" bootandy/dust \
      atload"alias ping=gping" sbin orf/gping \
      bpick"*.zip" sbin if'[[ $OSTYPE != linux* && $CPUTYPE != aarch* ]]' dalance/procs

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'

# ]]]

# themes [[[
zinit ice depth=1; zinit light romkatv/powerlevel10k
# ]]]

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases [[[
alias vim='nvim'
# ]]]
