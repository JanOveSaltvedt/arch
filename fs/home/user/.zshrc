HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HIST_IGNORE_DUPS

bindkey -e

zstyle :compinstall filename $HOME/.zshrc

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit
prompt clint

zstyle ':completion:*' rehash true

# ADD ctrl+left/right bindings
bindkey "Od" backward-word
bindkey "Oc" forward-word
bindkey "[7~" beginning-of-line
bindkey "[8~" end-of-line

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias diff='diff --color=always'

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi
