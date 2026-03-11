#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "You must be root to run this script"
        exit 1
fi

TARGET="192.168.1.0"
MASK=24
OPTIONS="-T4 -oX"

port_scan() {

	target=$1
	mask=$2
	options=$3

	log_path="/home/wiley/scans"
	diff_path="/home/wiley/scans/diff"

	paths=("$log_path" "$diff_path")

	for i in "${paths[@]}"; do
		if [[ ! -e ${i} ]]; then
			mkdir -p ${i}
		fi
	done

	date_today=$(date +"%Y-%m-%d_%H-%M")
	date_yesterday=$(date -d yesterday +"%Y-%m-%d_%H-%M")

	scan_today="$log_path/scan-$date_today.xml"
	scan_yesterday="$log_path/scan-$date_yesterday.xml"

	nmap $1/$2 $3 > $scan_today >> 2/dev/null

	if [[ -e $scan_yesterday ]]; then
		ndiff $scan_today $scan_yesterday > $diff_path/diff-$date_today
		echo "Differences have occured... Check Logs"
	else
		echo "No differences have occured..."
	fi

}


port_scan "$TARGET" "$MASK" "$OPTIONS"







