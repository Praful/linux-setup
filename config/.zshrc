# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# some settings copied from:
# - https://matt.blissett.me.uk/linux/zsh/zshrc
# - https://leahneukirchen.org/dotfiles/.zshrc
# - https://askubuntu.com/questions/1577/moving-from-bash-to-zsh
# - https://grml.org/zsh/
# - https://grml.org/zsh/zsh-lovers.html
#
# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

autoload -Uz compinit && compinit

# zsh specific aliases ============================================
#
# md -- mkdir and cd at once
md() { mkdir -p -- "$1" && cd -- "$1" }
compdef md=mkdir
# alias md='mkdir -p'

# Allows C-Z to suspend current command
# Pressing C-Z twice will suspend currently running command 
fancy-ctrl-z () {
  emulate -LR zsh
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z'          fancy-ctrl-z



# zsh specific aliases ============================================

# run-help=========================================================
# https://postgresqlstan.github.io/cli/zsh-run-help/
#run-help
autoload -Uz run-help
# add other help
autoload run−help−git
autoload run−help−ip
autoload run−help−openssl
autoload run−help−p4
autoload run−help−sudo

# press alt-h vim insert mode to get help for command
# does not work
# bindkey '\M-H' run-help
# bindkey -v '^b' run-help
# =================================================================

# uncomment next two lines to print last error code 
# print_last_status() print -u2 Exit status: $?
# precmd_functions+=(print_last_status)

# init vi plugin straight away (not lazily) to avoid it clashing with other plugins
ZVM_INIT_MODE=sourcing

# ZVM_TERM=xterm-256color

function zvm_config() {

  # change default in vi plugin for new line (otherwise last setting is used)
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

  # Retrieve default cursor styles
  # local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  # local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)

  # Append your custom color for your cursor
  # ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;red\a'
  # ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#108800\a'
  # ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#008800\a'
}

# For help, see https://linuxhint.com/ls_colors_bash/

# called by zsh-vi-mode plugin
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

# call in .zprofile
# source ~/.commonrc
#
# moved to commenrc
# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# for run-help (key C^X-H)
# export HELPDIR=/usr/share/zsh/help

source ~/.common_aliases

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# meaning of setopt options
# https://zsh.sourceforge.io/Doc/Release/Options.html#Description-of-Options
#
# Zsh settings for history
# export HISTORY_IGNORE="(d|dl|ls|[bf]g|exit|reset|clear|env|u|uu|uuu|cd|cd ..|cd..)"
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_ignore_space #don't include commands starting with space in history file
setopt nobeep
# change to correct, which corrects misspelled commands instead of all words on line
# setopt correct_all
setopt correct

# one history for all open shells
setopt sharehistory
# add more info eg timestamp and elapsed time since command
setopt extendedhistory

# Ref: https://linux.die.net/man/1/zshoptions
setopt extendedglob nomatch notify globcomplete nomenucomplete nocaseglob

# directory stack: see https://zsh.sourceforge.io/Intro/intro_6.html#SEC6
# these make cd behave live pushd/popd; 
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups 

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
setopt NOCLOBBER

# I have alias d set to use exa. Typing d <TAB> doesn't list directories; this fixes it.
setopt COMPLETE_ALIASES

# Don't complete with first option: show menu instead to allow to tab through 
# options.
# zstyle ':autocomplete:*' widget-style menu-complete
# zstyle ':autocomplete:*' widget-style menu-select

# --------------------------
# fzf-tab from https://github.com/Aloxaf/fzf-tab
#
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# repeat FZF_DEFAULT_OPTS here since they're not picked up
zstyle ':fzf-tab:complete:*' fzf-flags --ansi --color=bg+:\#005FFF,hl:\#95FFA4,gutter:-1
# zstyle ':fzf-tab:complete:*' fzf-flags --color=bg\+:#005FFF

# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# typing / <tab> keeps completing path; useful for cd into deep paths
zstyle ':fzf-tab:*' continuous-trigger '/'

# <space> accepts item from completion list 
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
# <enter> accepts answer and presses <enter> for line
zstyle ':fzf-tab:*' accept-line enter
# --------------------------
# zsh-autosuggestions plugins
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# --------------------------
#
#
#
# ============================== 
# trying to addresses slow autocomplete on network drives
# https://superuser.com/questions/585545/how-to-disable-zsh-tab-completion-for-nfs-dirs
# zstyle ':completion:*:*files' ignored-patterns '/mnt/*'
# zstyle ':completion:*:*directories' ignored-patterns '/mnt/*'
# ============================== 

# Fuzzy matching from:
# https://superuser.com/questions/415650/does-a-fuzzy-matching-mode-exist-for-the-zsh-shell#:~:text=This%20is%20a%20mode%20where,TextMate
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
# zstyle ':completion:*' matcher-list '' \
  # 'm:{a-z\-}={A-Z\_}' \
  # 'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  # 'r:|?=** m:{a-z\-}={A-Z\_}'
# case insensitve
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source ~/.fzf/shell/completion.zsh
source ~/.fzf/shell/key-bindings.zsh

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/pk-posh-theme.omp.json)"

fast-theme -q forest

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# set prompt for kitty tab title
precmd () {print -Pn "\e]0;%~\a"}

# for zsh-autosuggestions
bindkey '^o' forward-char
bindkey '^w' forward-word

bindkey '^X0' run-help
# bindkey '^X9' _complete_help
# bindkey > /tmp/bindkey-debug-$$
#
enable-fzf-tab

# [ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh
