#!/bin/zsh
# git-prompt / git-completion
# https://qiita.com/mikan3rd/items/d41a8ca26523f950ea9d

source ~/.zsh/git-prompt.sh
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash

autoload -Uz compinit && compinit
compinit -u
autoload colors
colors

export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

# コマンドの実行時間をプロンプトに表示するやつ
function show_command_end_time() {
  PREV_COMMAND_END_TIME=`date "+%H:%M:%S"`
  PROMPT="%{$fg[green]%}%n%{$fg[white]%}(${PREV_COMMAND_END_TIME}) %{$fg[yellow]%}%~%{$reset_color%}$ "
}


show_command_begin_time() {
  NEXT_COMMAND_BGN_TIME=`date "+%H:%M:%S"`
  PROMPT="%{$fg[green]%}%n%{$fg[white]%}(${NEXT_COMMAND_BGN_TIME}) %{$fg[yellow]%}%~%{$reset_color%}$ "
  zle .accept-line
  zle .reset-prompt
}

# gitのブランチ名を右端に表示するやつ
_set_env_git_current_branch() {
    GIT_CURRENT_REPOSITORY=`git config --local -l 2>/dev/null | awk -F/ '/^remote.origin.url/{print $NF}'`
    GIT_CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    if [ "$GIT_CURRENT_REPOSITORY" = "" ] || [ "$GIT_CURRENT_BRANCH" = "" ]
    then
        GIT_CURRENT_REPOSITORY="repos"
        GIT_CURRENT_BRANCH="none"
    fi
}

_update_rprompt () {
    RPROMPT="[$GIT_CURRENT_REPOSITORY:$GIT_CURRENT_BRANCH]"
}

zle -N accept-line show_command_begin_time
autoload -Uz add-zsh-hook
add-zsh-hook precmd _set_env_git_current_branch
add-zsh-hook precmd _update_rprompt
add-zsh-hook chpwd _set_env_git_current_branch
add-zsh-hook chpwd _update_rprompt
add-zsh-hook precmd show_command_end_time

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
setopt append_history
setopt list_packed
setopt no_beep
setopt hist_ignore_all_dups
HISTFILE=~/.histfile
HISTSIZE=30000
SAVEHIST=30000

PATH="/Users/the96/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/the96/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/the96/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/the96/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/the96/perl5"; export PERL_MM_OPT;