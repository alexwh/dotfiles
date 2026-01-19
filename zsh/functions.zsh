# run ls every time pwd changes
chpwd() { ls }
checkip() { curl ip.me }
checkip4() { curl -4 ip.me }
cx () { xclip -i < "$1" }
pss() { ps aux | grep $(sed "s/^\(.\)/[\1]/g" <<< "$1") }
pb() { curl -F "c=@${1:--}" https://ptpb.pw/ }
findi() { find -iname "*${1}*" }
rand() { echo $((($RANDOM % ${1:-2})+1)) }
peek() { tmux split-window -p 33 $EDITOR $@ || exit }

ccc() { # Convert CurenCy
    if [[ $#  -ne 3 ]];then
        echo "usage: $0 amount from to"
        return
    fi
    # lowercase $2 and $3
    _rate=$(curl -s "https://latest.currency-api.pages.dev/v1/currencies/${2:l}.json" | jq ".${2:l}.${3:l}")
    # scale only works on div, not mul, so /1 at end
    _ans=$(echo "scale=2; ${1}*${_rate} / 1" | bc | tail -1)
    echo "${1} ${2} = ${_ans} ${3}"
}

sshp() {
    ps x | awk '/[s]sh -D 5123 -f -N/ {print $1}'|xargs -r kill && \
    [[ -n "$1" ]] && ssh -D 5123 -f -N "$1" || echo killed all
}

# from https://gist.github.com/jpouellet/5278239
# get $EPOCHSECONDS. builtins are faster than date(1)
zmodload zsh/datetime || return

# make sure we can register hooks
autoload -Uz add-zsh-hook || return

# initialize zbell_duration and zbell_ignore if not set
(( ${+zbell_duration} )) || zbell_duration=15
(( ${+zbell_ignore} )) || zbell_ignore=($EDITOR $PAGER mutt weechat mpv sxiv)

# initialize it because otherwise we compare a date and an empty string
# the first time we see the prompt. it's fine to have lastcmd empty on the
# initial run because it evaluates to an empty string, and splitting an
# empty string just results in an empty array.
zbell_timestamp=$EPOCHSECONDS

# right before we begin to execute something, store the time it started at
zbell_begin() {
    zbell_timestamp=$EPOCHSECONDS
    zbell_lastcmd=$1
}

# when it finishes, if it's been running longer than $zbell_duration,
# and we dont have an ignored command in the line, then print a bell.
zbell_end() {
    ran_long=$(( $EPOCHSECONDS - $zbell_timestamp >= $zbell_duration ))

    has_ignored_cmd=0
    for cmd in ${(s:;:)zbell_lastcmd//|/;}; do
        words=(${(z)cmd})
        util=${words[1]}
        if (( ${zbell_ignore[(i)$util]} <= ${#zbell_ignore} )); then
            has_ignored_cmd=1
            break
        fi
    done

    if (( ! $has_ignored_cmd )) && (( ran_long )); then
        print -n "\a"
    fi
}

# register the functions as hooks
add-zsh-hook preexec zbell_begin
add-zsh-hook precmd zbell_end
