# run ls every time pwd changes
chpwd() { ls }
checkip() { dig +short myip.opendns.com @resolver1.opendns.com }
cx () { xclip -i < "$1" }
pss() { ps ax | grep $(sed "s/^\(.\)/[\1]/g" <<< "$1") }
pb() { curl -F "c=@${1:--}" https://ptpb.pw/ }
findi() { find -iname "*${1}*" }
rand() { echo $((($RANDOM % ${1:-2})+1)) }
peek() { tmux split-window -p 33 $EDITOR $@ || exit }

ccc() { # Convert CurenCy
	[[ $# -ge 3 ]] && curl -s "http://www.google.com/finance/converter?a=${1}&from=${2}&to=${3}" | sed '/res/!d;s/<[^>]*>//g' || \
	echo "usage: $0 amount from to"
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
