#options
setopt no_beep
setopt nolistbeep

autoload -U compinit promptinit colors
compinit
promptinit
colors

zstyle ':completion:*:default' menu select=2
setopt completealiases

source /usr/share/zsh/scripts/zplug/init.zsh
source .kawazu/repos/kawazu.sh
source .shell/colors
source .shell/aliases

export LANG=ja_JP.UTF-8

#history
setopt histignorealldups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

#zplug
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
zplug load
