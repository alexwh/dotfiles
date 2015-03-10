# run ls every time pwd changes
chpwd() { ls }
checkip() { dig +short myip.opendns.com @resolver1.opendns.com }
cx () { xclip -i < "$1" }
pss() { ps ax | grep $(sed "s/^\(.\)/[\1]/g" <<< "$1") }

ccc() { # Convert CurenCy
	[[ $# -ge 3 ]] && curl -s "http://www.google.com/finance/converter?a=${1}&from=${2}&to=${3}" | sed '/res/!d;s/<[^>]*>//g' || \
	echo "usage: $0 amount from to"
}

sshp() {
	ps x | grep '[s]sh -D 5123 -f -N'| awk '{print $1}'|xargs -r kill && \
	[[ -n "$1" ]] && ssh -D 5123 -f -N "$1" || echo killed all
}
