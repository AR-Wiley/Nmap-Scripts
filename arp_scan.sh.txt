#!/bin/bash

subdomain="192.168.1.0"
sub_mask=24

arp () {

        log_path="/home/wiley/Desktop/nmap_scripts/host_log.txt"

        if [[ ! -e $log_path ]]; then
                touch $log_path
        fi

        subdomain=$1
        sub_mask=$2

        timestamp() {
                date '+%Y-%m-%d %H:%M:%S'
        }

        hosts="$(nmap -sn "${subdomain}/${sub_mask}")"

        echo "$hosts" >> "$log_path"

        echo "$(timestamp)" >> "$log_path"
        echo "____________" >> "$log_path"

        echo "Live Hosts on System"
        echo "$hosts" | awk '{print $6}' | sed 's/[()]//g' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'

}


arp "$subdomain" "$sub_mask"
