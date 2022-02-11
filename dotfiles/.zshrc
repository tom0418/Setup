#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# zsh-completions
fpath=(path/to/zsh-completions/src $fpath)

if [ -e ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi


## general

# 補完
autoload -Uz compinit
compinit

# ヒストリ（履歴）保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 同時に起動した zsh の間でヒストリを共有する
setopt share_history

# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

## path

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# anyenv
eval "$(anyenv init -)"

# MySQL
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

## alias
alias c='clear'

# git

# 新規にブランチを切る
function checkoutb() {
  git checkout -b $1
}

# トラッキングブランチを元にブランチを切る
function checkoutr() {
  git checkout -b $1 origin/$1
}

alias status='git status'
alias reflog='git reflog'
alias branch='git branch'
alias checkout='git checkout `git branch | fzf-tmux`'
alias stage='git add'
alias commit='git commit'
alias fetch='git fetch --prune'
alias merge='git merge'
alias deleteb='git branch -D `git branch | fzf-tmux`'

# docker command
alias d='docker'
alias dpsa='docker ps -a'
alias dbuild='docker build -t'
alias drun='docker run'
alias drund='docker run -d'
alias dstart='docker start'
alias dstarta='docker start $(docker ps -a -q)'
alias dstop='docker stop'
alias dstopa='docker stop $(docker ps -q)'
alias drma='docker rm $(docker ps -q -a)'
alias drmia='docker rmi $(docker images -q)'
alias dvrma='docker volume rm $(docker volume ls -qf dangling=true)'
alias da='docker attach'

# docker container command
alias dcnt='docker container'

# docker compose command
alias dc='docker-compose'
alias dcbuild='docker-compose build'
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcrun='docker-compose run'
alias dcrunrm='docker-compose run --rm'
alias dcstop='docker-compose stop'

# docker compose(Rails)
alias dcbundle='docker-compose run --rm web bundle install'
alias dcgemrm='docker-compose run --rm web bundle exec gem uninstall'

# Solargraph Language Server
alias solarstart='docker start solargraph'

# docker and fzf
function docker-container() {
  docker ps --format "{{.Names}}"
}

function docker-containers() {
  docker container ls -a --format "{{.Names}}"
}

function docker-volume() {
  docker volume ls --format "{{.Name}}"
}

alias da='docker attach `docker-container | fzf-tmux`'
alias de='docker exec -it `docker-container | fzf-tmux` /bin/bash'
alias dl='docker logs `docker-container | fzf-tmux`'
alias dla='docker logs `docker-containers | fzf-tmux`'
alias drmc='docker container rm `docker-containers | fzf-tmux`'
alias drmv='docker volume rm `docker-volume | fzf-tmux`'
