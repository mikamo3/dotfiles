#options
setopt no_beep
setopt nolistbeep
setopt ignoreeof
setopt prompt_subst

# tmux plugin
if [[ ! -d ~/.tmux/plugins/tpm ]];then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
fi
autoload -U compinit promptinit colors
compinit
promptinit
colors

zstyle ':completion:*' list-colors "${LS_COLORS}"

zstyle ':completion:*:default' menu select=2
setopt completealiases
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#source
source /usr/share/zsh/scripts/zplug/init.zsh
source /usr/lib/kawazu/kawazu.sh
source ~/.shell/colors
source ~/.shell/aliases
source ~/.shell/init
source ~/.shell/fzf_ghq
source ~/.shell/fzf_git
source ~/.shell/fzf_misc
source ~/.shell/cd
#export
export KAWAZU_ROOT_DIR=/usr/lib/kawazu

path=(
	~/bin
  ~/.local/bin
  ~/.node_modules/bin
	$path
)

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

#fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#zplug
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3
zplug "lukechilds/zsh-nvm"
zplug "x-motemen/ghq", as:command, from:gh-r
zplug "rupa/z", use:z.sh
zplug "changyuheng/zsh-interactive-cd"


if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
zplug load

# init
if [[ -z "$TMUX" ]];then
  init_environment
fi
#tmux
if [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]] ;then
    ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        exec tmux new-session
    else
        exec tmux attach-session -t "$ID" # if available attach to it
    fi
fi
