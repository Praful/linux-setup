# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# some settings copied from:
# - https://matt.blissett.me.uk/linux/zsh/zshrc
# - https://leahneukirchen.org/dotfiles/.zshrc
#
# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

autoload -Uz compinit && compinit

# zsh specific aliases ============================================
#
# mkcd -- mkdir and cd at once
mkcd() { mkdir -p -- "$1" && cd -- "$1" }
# compdef mkcd=mkdir

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
alias help=run-help

# press alt-h vim insert mode to get help for command
# does not work
# bindkey '\M-H' run-help
# bindkey -v '^b' run-help
# =================================================================

# case insensitive completions

# init vi plugin straight away (not lazily)
ZVM_INIT_MODE=sourcing

# uncomment next two lines to print last error code
# print_last_status() print -u2 Exit status: $?
# precmd_functions+=(print_last_status)

function zvm_config() {
  # change default for new line (otherwise last setting is used)
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

# export LS_COLORS=$LS_COLORS:'di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LS_COLORS='di=1;32:ln=1;30;47:so=30;45:pi=30;45:ex=1;31:bd=30;46:cd=30;46:su=30'
export LS_COLORS="${LS_COLORS};41:sg=30;41:tw=30;41:ow=30;41:*.rpm=1;31:*.deb=1;31"
export LSCOLORS=CxahafafBxagagabababab



export GREP_COLORS LS_COLORS LSCOLORS
export ZDOTDIR="$HOME/.config/zsh"

# for run-help
export HELPDIR=/usr/share/zsh/help

function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

source ~/.commonrc

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

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
setopt NOCLOBBER
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

# --------------------------

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

bindkey '^o' forward-char
bindkey '^w' forward-word
bindkey '^Xh' run-help
bindkey '^X9' _complete_help
# bindkey > /tmp/bindkey-debug-$$
#
enable-fzf-tab
