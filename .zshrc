# ==== PROMPT ======================================================================================
autoload -Uz promptinit
promptinit
prompt adam2
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


# ==== HISTORY =====================================================================================
setopt histignorealldups sharehistory

bindkey '^R' history-incremental-search-backward

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
# ==================================================================================================


# ==== AUTOCOMPLETE ================================================================================
# ---- Enable Autocomplete -------------------------------------------------------------------------
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zmodload zsh/complist
_comp_options+=(globdots)
# --------------------------------------------------------------------------------------------------


# ---- Enable Vim-Style Selection Menu Navigation --------------------------------------------------
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[' undo
# --------------------------------------------------------------------------------------------------
# ==================================================================================================


# ==== SYNTAX HIGHLIGHTING =========================================================================
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# ==================================================================================================


alias vim=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# ==== DOTFILE MANAGEMENT ==========================================================================
# Load default configuration
[[ -f '.dotfiles/config' ]] && source '.dotfiles/config'

# Load local configuration
[[ -f '.dotfiles/config_local' ]] && source '.dotfiles/config_local'

# Set up dotfiles command (alias)
alias dotfiles='git --git-dir=$DOTFILES_GIT --work-tree=$HOME'
alias install_dotfiles='$HOME/.dotfiles/install.sh'
# ==================================================================================================

