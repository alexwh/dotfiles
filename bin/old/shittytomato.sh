#!/usr/bin/bash
# it took me a while to realise this shouldnt be a shell script
shopt -s extglob
source ~/.config/auth/tomato.pass

while true;do

	iptraffic=$(curl -s -X POST -d "exec=iptraffic&_http_id=$httpid" -u "$user:$pass" 192.168.1.1/update.cgi | cut -c 13-|rev|cut -c 3-|rev|perl -ne 'chomp and print')
	iptraffic=${iptraffic//\]/}
	iptraffic=${iptraffic//, /\:}
	iptraffic=${iptraffic// /}
	iptraffic=${iptraffic//\'/}

	IFS=',[' read -a iparray <<< "$iptraffic"

	# remove blanks
	for index in "${!iparray[@]}";do
		if [[ -z ${iparray[index]} ]];then
			iparray=(${iparray[@]:0:$index} ${iparray[@]:$(($index + 1))})
		fi
	done

	# sample: 
	# ip,tx,rx,tcpi,tcpo,udpi,udpo,icmpi,icmpo,tcpconn,udpconn
	# / tx/rx by 1024

	for i in "${!iparray[@]}";do
		IFS=':' read -a ipinfo$i <<< "${iparray[i]}"
	done



	for i in "${!iparray[@]}";do	
		loop="ipinfo$i[1]"
		for k in "${!loop}";do
			#			echo "tx $k"
			oldtx=$k
		done

		loop="ipinfo$i[2]"
		for k in "${!loop}";do
			if [[ -n $oldrx ]];then
				if [[ $((k - oldrx)) -ge 204800 ]];then
					echo "rx $k"
					echo "yep"
				fi
			fi
			oldrx=$k
		done		
	done
	sleep 1
	echo "loop"
done
