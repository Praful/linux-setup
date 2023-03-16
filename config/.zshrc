# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# some settings copied from:
# - https://matt.blissett.me.uk/linux/zsh/zshrc
# - https://leahneukirchen.org/dotfiles/.zshrc

# zsh specific aliases ============================================
#
# mkcd -- mkdir and cd at once
mkcd() { mkdir -p -- "$1" && cd -- "$1" }
# compdef mkcd=mkdir

# =================================================================


function zvm_config() {
  # change default for new line (otherwise last setting is used)
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

export ZDOTDIR="$HOME/.config/zsh"

# vim as editor
bindkey -v
bindkey '^o' forward-char
bindkey '^w' forward-word
# override vi plugin


function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

function zvm_after_lazy_keybindings() {
  zvm_bindkey viins '^o' forward-char
  zvm_bindkey viins '^w' forward-word
}

source ~/.aliases

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load


# Lines configured by zsh-newuser-install
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_ignore_space #don't include commands starting with space in history file

setopt nobeep
# Ref: https://linux.die.net/man/1/zshoptions
setopt extendedglob nomatch notify autopushd pushdignoredups globcomplete nomenucomplete nocaseglob
# setopt noautocd nobeep extendedglob nomatch notify noautolist noautomenu autopushd pushdignoredups
# setopt noautocd nobeep extendedglob nomatch notify autopushd pushdignoredups
# setopt extendedglob nomatch notify autopushd pushdignoredups noautocd 


# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
setopt NOCLOBBER
# Don't complete with first option: show menu instead to allow to tab through 
# options.

zstyle ':autocomplete:*' widget-style menu-complete

# Fuzzy matching from:
# https://superuser.com/questions/415650/does-a-fuzzy-matching-mode-exist-for-the-zsh-shell#:~:text=This%20is%20a%20mode%20where,TextMate
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

source ~/.fzf/shell/completion.zsh
source ~/.fzf/shell/key-bindings.zsh

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/pk-posh-theme.omp.json)"

fast-theme -q forest

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# https://github.com/pyenv/pyenv#installation
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# Load pyenv-virtualenv automatically by adding the following to ~/.bashrc:
eval "$(pyenv virtualenv-init -)"

pyenv shell 3.11.2

# set prompt for kitty tab title
precmd () {print -Pn "\e]0;%~\a"}

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



