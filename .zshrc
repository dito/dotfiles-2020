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

export PATH=$HOME/.anyenv/envs/nodenv/versions/*/bin:$PATH
export GOPATH=$HOME/workspace
export PATH=$PATH:$GOPATH/bin

bindkey '^]' peco-src
function peco-src() {
    local src=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        BUFFER="cd $src"
        zle accept-line
    fi
    zle -R -c }
zle -N peco-src

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
