#!/bin/bash

subdomain="192.168.1.0"
submask=24

target_list () {

        targets_path="/home/awiley805/Desktop/nmap/TargetLogs/targets.txt"
        machine_path="/home/awiley805/Desktop/nmap/TargetLogs/machines.txt"

        if [[ ! -e "$targets_path" ]]; then
                touch "$targets_path"
        fi

        if [[ ! -e "$machine_path" ]]; then
                touch "$machine_path"
        fi

        subdomain=$1
        submask=$2

        echo "All IP Addresses on Subnet: " >> "$targets_path"
        nmap -sL "${subdomain}/${submask}" >> "$targets_path"

        echo "Potential Live Machines on Subnet: " >> "$machine_path"
        nmap -sL "${subdomain}/${submask}" | awk '{print $5}' | grep -v [0-9] >> "$machine_path"

}

target_list "$subdomain" "$submask"
