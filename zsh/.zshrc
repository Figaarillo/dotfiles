# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"



zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    web-search
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    z
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# Options section
setopt extendedglob             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob               # Case insensitive globbing
setopt rcexpandparam            # Array expension with parameters
setopt nocheckjobs              # Don't warn about running processes when exiting
setopt numericglobsort          # Sort filenames numerically when it makes sense

# Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'      # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' regular true
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' group-order alias builtins functions commands
zstyle ':completion:*' complete-options true
#zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' cache-path ~/.oh-my-zsh/cache/
zstyle ':completion:*' use-cache on

# Uncomment the following line to use hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"


# Exports

export HISTSIZE=1000000000
export HISTFILESIZE=1000000000
export HISTTIMEFORMAT=" "
export HISTCONTROL=ignoreboth:erasedups

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export PYTHONDONTWRITEBYTECODE=1
export PYTHONSTARTUP=~/.python_startup.py
export PROMPT_EOL_MARK=""
export GPG_TTY='tty'
export SUBDOMAIN=ftw
export API_SUBDOMAIN=127.0.0.1
export WINEARCH=win32
export WINEPREFIX="$HOME/.wine"
export JDK_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export CHROME_EXECUTABLE="/usr/lib/chromium-browser/chromium-browser"
export MOZ_ENABLE_WAYLAND=1

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.pub-cache/bin

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/home/figarillo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# deno
export DENO_INSTALL="/home/figarillo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Go
export PATH=$PATH:/usr/local/go/bin


# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# aliases
if [ -f ~/.aliases ]; then
. ~/.aliases
fi


# Neovim
alias neovim="nvim"
alias nvim-kick="NVIM_APPNAME=NvimKickstart nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

function nvims() {
  items=("default" "AstroNvim" "NvChad" "NvimKickstart" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# bindkey -s ^a "nvims\n"

# Created by `pipx` on 2024-04-10 15:30:51
export PATH="$PATH:/home/figarillo/.local/bin"


# Load Angular CLI autocompletion.
source <(ng completion script)

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
