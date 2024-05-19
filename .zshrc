# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ==== ZINIT =======================================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not present
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
# ==================================================================================================


# ==== HISTORY =====================================================================================
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# ==================================================================================================


# ==== VIM MODE ====================================================================================
bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
export KEYTIMEOUT=1
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = '' ]] ||
         [[ $1 = 'line' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[1 q' # Default to block cursor
preexec() { echo -ne '\e[1 q' ;} # Use block cursor on each new prompt
# ==================================================================================================


# ==== PROMPT ======================================================================================
zinit ice depth-1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# ==================================================================================================


# ==== SYNTAX HIGHLIGHTING =========================================================================
zinit light zsh-users/zsh-syntax-highlighting
# ==================================================================================================


# Requires fzf 0.48 or later
eval "$(fzf --zsh)"


# ==== AUTOCOMPLETIONS =============================================================================
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit
zinit cdreplay -q

zinit light zsh-users/zsh-autosuggestions
bindkey '^f' autosuggest-accept

zinit light Aloxaf/fzf-tab

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*:*' fzf-preview 'ls --color $realpath'
# ==================================================================================================


# ==== NEOVIM ======================================================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# ==================================================================================================


# ==== ALIASES =====================================================================================
alias vim='nvim'
alias ls='ls --color'
# ==================================================================================================


# ==== DOTFILE MANAGEMENT ==========================================================================
# Load local configuration
source '.dotfiles/config'
[[ -f '.dotfiles/config_local' ]] && source '.dotfiles/config_local'

# Set up dotfiles command (alias)
alias dotfiles='git --git-dir=$DOTFILES_GIT --work-tree=$HOME'
alias install_dotfiles='$HOME/.dotfiles/install.sh'
# ==================================================================================================


# ==== ADDITIONAL CONFIG ===========================================================================
ZDOTDIR="$HOME/.config/zsh"
fpaths+=${ZDOTDIR:-~}/.zsh_functions

[[ -f '.config/zsh/zshrc.local' ]] && source '.config/zsh/zshrc.local'
# ==================================================================================================
