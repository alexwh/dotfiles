apikey=nah
n=1
min=0
max=1

notif() {
	notify-send "random.org" "$1"
}

truefalse() {
	tf="true"
}

range() {
	min=$(dmenu -p min <<< "1")
	max=$(dmenu -p max <<< "")
}

$(echo -e "truefalse\nrange" | dmenu -p rand) || exit

req='{
    "jsonrpc": "2.0",
    "method": "generateIntegers",
    "params": {
        "apiKey": "'$apikey'",
        "n": '$n',
        "min": '$min',
        "max": '$max',
        "replacement": true
    },
    "id": 42
}'

resp=$(curl -sH "Content-Type: application/json-rpc" -d "$req" https://api.random.org/json-rpc/1/invoke)
rands=$(sed -r 's|.*"data":\[(.*)\],.*|\1|' <<< "$resp")
if [[ $tf = "true" ]];then
	grep -q 0 <<< $rands && rands="false"
	grep -q 1 <<< $rands && rands="true"
	notif $rands
else
	notif $rands
fi
