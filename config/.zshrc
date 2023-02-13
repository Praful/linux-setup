# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


export ZDOTDIR="$HOME/.config/zsh"

# vim as editor
bindkey -v

# Complete suggestion
bindkey '^o' forward-char
bindkey '^w' forward-word

source ~/.aliases

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nobeep
# Ref: https://linux.die.net/man/1/zshoptions
setopt extendedglob nomatch notify autopushd pushdignoredups globcomplete nomenucomplete nocaseglob
# setopt noautocd nobeep extendedglob nomatch notify noautolist noautomenu autopushd pushdignoredups
# setopt noautocd nobeep extendedglob nomatch notify autopushd pushdignoredups
# setopt extendedglob nomatch notify autopushd pushdignoredups noautocd 

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

pyenv shell 3.11.1

# set prompt for kitty tab title
precmd () {print -Pn "\e]0;%~\a"}

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
