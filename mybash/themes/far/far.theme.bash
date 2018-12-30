#!/usr/bin/env bash

SCM_THEME_PROMPT_PREFIX='('
SCM_THEME_PROMPT_SUFFIX=')'
THEME_BATTERY_PERCENTAGE_CHECK=false
SCM_GIT_CHAR=''
SCM_NONE_CHAR=''

function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));
    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

#function git_diff() {
#    git diff --no-ext-diff -w "$@" | vim -R -
#}

function prompt_command() {
	PS1="${cyan}\A${normal} ${green}\u${normal}@${cyan}\h${normal}:[${green}\w${normal}] ${purple}$(scm_prompt_char_info) ${yellow}$(git_since_last_commit)${normal}~\n$ "
    PS2="${blue}→ ${normal}"
}

safe_append_prompt_command prompt_command
