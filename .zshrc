# ~/.zshrc
export TERM="xterm-256color"

export PATH=/usr/local/share/metasploit-framework:$PATH
export PATH=$PATH:. # I hate having to ./executable.

export GOPATH="/usr/local/opt/go/libexec/bin"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOPATH/src/github.com
export AWS_CONFIG_FILE=$HOME/.aws/config
export DOT="${ZDOTDIR:-$HOME}/.dotfiles"
export DOTZSH="$DOT/zsh"
zstyle ':completion:*' menu select

# Add bin directory of DOTFILES to path
path=("$DOT/bin" $path)

# Safari Google search
search() {
  open -a Safari "http://google.com/search?q=$*"
}


# Google translate in-terminal.
translate() { 
  lng1="$1";lng2="$2";shift;shift; wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=${@// /+}&langpair=$lng1|$lng2" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; 
}

# Autosuggestions.
# Enable autosuggestions automatically
zle-line-init() {
	zle autosuggest-start
}
zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^T' autosuggest-toggle

alias -s git="git clone"
alias -s c="emacsclient -t"

alias vim="nvim"
alias screen="screen -U"
alias myip="curl ifconfig\.me/ip "
alias ec="emacsclient -t"
alias colourify="grc -es --colour=auto"
alias configure='colourify ./configure'

HELPDIR=/usr/local/share/zsh/help

alias diff='colourify diff'
alias t="trans"
alias make='colourify make'

alias gcc='gcc -fdiagnostics-color=auto'
alias g++='g++ -fdiagnostics-color=auto'

alias netstat='colourify netstat'
alias ping='colourify ping'
alias ping6='colourify ping6'
alias traceroute='colourify traceroute'
alias tcpdump="colourify tcpdump"
# manpages

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=-r


# Antigen

source ~/.antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen bundle common-aliases

antigen use oh-my-zsh
antigen bundle git
antigen bundle pyenv
antigen bundle go
antigen bundle git-flow
antigen bundle git-extras

antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle chrissicool/zsh-256color
antigen bundle Tarrasch/zsh-bd
antigen bundle berkshelf/berkshelf-zsh-plugin
antigen bundle ruby
antigen bundle tmuxinator
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen bundle rupa/z
antigen bundle history

export GPGKEY=FE37DCAD

# Node Plugins
antigen bundle coffee
antigen bundle node
antigen bundle npm
antigen bundle ruby

# Python Plugins
antigen bundle python
antigen bundle virtualenv

antigen bundle brew
antigen bundle brew-cask
antigen bundle gem
antigen bundle osx

# Tell antigen that you're done.
antigen apply

# Source Prezto.

[[ -s "$DOTZSH/init.zsh" ]] && source "$DOTZSH/init.zsh"
[[ -s "$DOT/priv/env.zsh" ]] && source "$DOT/priv/env.zsh"

source ~/.zprofile
	
# colors for ls
if [[ -f ~/.dir_colors ]] ; then
    eval $(gdircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(gdircolors -b /etc/DIR_COLORS)
fi

# Google

google () { 
  open "http://www.google.com/search?q=$*"; 
}


export PAGER="less"
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS
bindkey -v
typeset -g -A key
bindkey '^r' history-incremental-pattern-search-backward
bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[2~' overwrite-mode
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char

alias buu="brew update ; brew upgrade --all"

editor="emacsclient -t"
visual="emacsclient -t"

alias e='emacsclient -t'

alias init=".dotfiles/libexec/dotfiles init"
alias ls="ls -G -F"
alias ll="ls -G -lh"
alias lt="ls -G -lthr"
alias la='ls -a'

alias bi='brew install'
alias br='brew remove'

zmodload -a colors
autoload -Uz compinit
compinit
setopt autocd

zstyle -e ':completion:*:rm:*' file-patterns 'reply=( "*(/):directories" );(( $+opt_args[-r] )) || reply[1,0]=( "*.tar.gz(-.):gzip:gzip" "*(-.):all-files" )'
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.dotfiles/zsh/cache
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' command 'ps fx -o pid,user,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

flacnot () {
for f in "$@"; do
    [[ "$f" != *.flac ]] && continue
    album="$(metaflac --show-tag=album "$f" | sed 's/[^=]*=//')"
    artist="$(metaflac --show-tag=artist "$f" | sed 's/[^=]*=//')"
    date="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    title="$(metaflac --show-tag=title "$f" | sed 's/[^=]*=//')"
    year="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    genre="$(metaflac --show-tag=genre "$f" | sed 's/[^=]*=//')"
    tracknumber="$(metaflac --show-tag=tracknumber "$f" | sed 's/[^=]*=//')"

    flac --decode --stdout "$f" | lame --preset extreme --add-id3v2 --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$tracknumber" --tg "$genre" - "${f%.flac}.mp3"
   done
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)        tar xjf $1        ;;
            *.tar.gz)         tar xzf $1        ;;
            *.bz2)            bunzip2 $1        ;;
            *.rar)            unrar x $1        ;;
            *.gz)             gunzip $1         ;;
            *.tar)            tar xf $1         ;;
            *.tbz2)           tar xjf $1        ;;
            *.tgz)            tar xzf $1        ;;
            *.zip)            unzip $1          ;;
            *.Z)              uncompress $1     ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function archive() {
    if [[ $# -lt 2 ]]; then
        echo "usage:  pack archive.extension [dir|file]+"
        return 1
    fi

    [[ -f $1 ]] && echo "error: destination $1 already exists." && return 1

    local lower
    lower=${(L)1}
    case $lower in
        *.tar.bz2) tar cvjf $@;;
        *.tar.gz) tar cvzf $@;;
        *.tar.xz) tar cvJf $@;;
        *.tar.lzma) tar --lzma -cvf $@;;
        *.bz2) 7za a -tbzip2 $@;;
        *.gz) 7za a -tgzip $@;;
        *.tar) tar cvf $@;;
        *.tbz2) tar cvjf $@;;
        *.tgz) tar cvzf $@;;
        *.zip) zip -r $@;;
        *.7z) 7za a -t7z -mmt $@;;
        *) echo "'$1' unsupported archive format / extension.";;
    esac
}

dict () {
     curl dict://dict.org/d:"${1}"
}

setprompt () {
  # load some modules
  autoload -U colors zsh/terminfo # Used in the colour alias below
  colors
  setopt prompt_subst

  # make some aliases for the colours: (coud use normal escap.seq's too)
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
  done
  PR_NO_COLOR="%{$terminfo[sgr0]%}"

  # Check the UID
  if [[ $UID -ge 1000 ]]; then # normal user
    eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
  elif [[ $UID -eq 0 ]]; then # root
    eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
    eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
  fi

  # Check if we are on SSH or not --{FIXME}-- always goes to |no SSH|
  if [[ -z "$SSH_CLIENT" || -z "$SSH2_CLIENT" ]]; then
    eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
  else
    eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
  fi
bindkey -e  ## emacs key bindings
#
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word
#
bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
bindkey '^[^I' reverse-menu-complete
bindkey '^X^N' accept-and-infer-next-history
bindkey '^W' kill-region
bindkey '^I' complete-word

  # set the prompt
  rstatus() {
    if [[ $? -eq 0 ]];then
      echo 0
    else
      echo ${PR_RED}$?
    fi
  }

echo `fortune`
PS1='%(?:%{$fg_bold[green]%}# :%{$fg_bold[red]%}# %s)%{$fg_bold[green]%}%p%{$fg[cyan]%}%c%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

}

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
setprompt

PERL_MB_OPT="--install_base \"/Users/m/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/m/perl5"; export PERL_MM_OPT;
export PROMPT="$PROMPT$(git-radar --zsh --fetch) "

