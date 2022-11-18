#!/bin/bash
# runner.sh -	Taken From: https://www.linuxjournal.com/content/creating-bash-spinner
#		Modified by TCS Research
#
LogDir=/var/log/KISSChecker
logfile=/var/log/KISSChecker/KISSChecker.log

### Check for root ###
if [[ $(id -u) != "0" ]]; then
    echo "Error: script not running as root or with sudo! Exiting..."
    exit 1
fi

echo >$logfile
trap "rm -f $logfile" EXIT

# Output message to log file.
function log_msg()
{
    echo "$*" >>$logfile
}


# Start spinner
sh spinner.sh &

# Perform really long task.
i=0
log_msg "Starting a really long job"
while [[ $i -lt 100 ]]
do
    sleep 1
    let i+=5
    log_msg "$i% complete"
done

sleep 1
echo
