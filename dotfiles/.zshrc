########################################
# general
########################################

# ヒストリ（履歴）保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# ヒストリを共有する
setopt share_history

# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# prompt, complitions, autosuggestions, syntax-highlighting
if type brew &>/dev/null; then
  fpath+=($(brew --prefix)/share/zsh/site-functions)
  fpath+=($(brew --prefix)/share/zsh-complitions)
  fpath+=(~/.zsh/completions)
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  autoload -Uz compinit && compinit
  autoload -U promptinit && promptinit
  prompt pure
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

########################################
# functions
########################################

# docker and fzf
function docker-container(){
  docker ps --format "{{.Names}}"
}

function docker-containers(){
  docker container ls -a --format "{{.Names}}"
}

function docker-volume(){
  docker volume ls --format "{{.Names}}"
}

########################################
# alias
########################################

alias relogin='exec $SHELL -l'
alias c='clear'
alias ls='ls -G'
alias python='python3'

# docker
alias d='docker'

# docker container
alias dcnt='docker container'

# docker componse
alias dc='docker compose'
alias dcup='docker compose up'
alias dcupd='docker compose up -d'
alias dcstop='docker compose stop'
alias dcrun='docker compose run'

alias da='docker attach `docker-container | fzf-tmux`'
alias de='docker exec -it `docker-container | fzf-tmux` /bin/bash'
alias dl='docker logs `docker-container | fzf-tmux`'
alias dla='docker logs `docker-containers | fzf-tmux`'
alias drmc='docker container rm `docker-containers | fzf-tmux`'
alias drmv='docker volume rm `docker-volume | fzf-tmux`'

