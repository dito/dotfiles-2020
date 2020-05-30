export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

autoload -Uz colors
colors

autoload -U compinit
compinit

# aliases
alias ls='ls -F -a'
alias ll='ls -l'

alias g=git
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gcf='git commit --fixup'
alias gs='git status'
alias gb='git branch'
alias gd='git diff'
alias gdw='git diff --ignore-all-space'
alias gdc='git diff --cached'
alias gdcw='git diff --cached --ignore-all-space'
alias gr='git rebase'
alias gr='git rebase -i'
alias gf='git fetch --prune'
alias gl='git l'

alias vim=nvim
alias bx='bundle exec'

function agp() {
    ag $1 | peco
}

bindkey -e

setopt print_eight_bit

setopt no_beep

# history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt share_history

# pushd
setopt auto_pushd
setopt pushd_ignore_dups

########################################


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/.cask/bin:$PATH"

# set current directory name to iterm2 tab name
function chpwd() { echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print ""$1"/"}'| rev)\007"}

# load under ~/.zsh/
ZSHHOME="${HOME}/.zsh"
if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.sh ]] &&
        [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
eval "$(anyenv init -)"

export GOENV_ROOT=$HOME/.goenv
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOPATH/bin:$PATH"


# pecoで表示されるコマンド履歴の重複を削除する 改
# http://shigemk2.hatenablog.com/entry/2015/02/01/peco%E3%81%A7%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%82%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E5%B1%A5%E6%AD%B4%E3%81%AE%E9%87%8D%E8%A4%87%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B_%E6%94%B9
# [[peco]peco-select-history.zsh で表示されるコマンド履歴の重複を削除する - Qiita](http://qiita.com/wada811/items/78b14181a4de0fd5b497)
function peco_select_history() {
  local tac
  if which tac > /dev/null; then
      tac="tac"
  else
      tac="tail -r"
  fi
  BUFFER=$(history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  # zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

function peco-src () {
    local repo=$(ghq list | peco --query "$LBUFFER" --initial-filter=Fuzzy)
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# for local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
