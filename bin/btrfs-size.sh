#!/bin/bash

used=$(sudo  btrfs filesystem show /dev/mapper/root | grep Total | awk '{print $7}' | tr -d A-Za-z)
total=$(sudo btrfs filesystem show /dev/mapper/root | grep path  | awk '{print $4}' | tr -d A-Za-z)
unit=$(sudo  btrfs filesystem show /dev/mapper/root | grep Total | awk -F'[0-9]' '{print $NF}')

[[ $1 == "int" ]] && echo $(bc <<< "($total-$used)/1") || echo $(bc <<< "$total-$used")$unit
