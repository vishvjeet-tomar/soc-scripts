#!/bin/bash

monitor_log(){
   tail -f /var/log/auth.log | while read -r line; do
      if [[ "${line}" == *Failed* ]]; then
         time=$(date "+%Y-%m-%d %H:%M:%S")
         echo "[${time}] ALERT: Failed login detected!"
         echo "Line: $line"
         echo
         echo "${time}: ${line}" >> monitor_alerts.log
      fi
   done
}

main(){
   echo "=== Real-Time Log Monitor ==="
   echo "Watching /var/log/auth.log for failed logins..."
   echo "Alerts saved to monitor_alerts.log"
   echo
   monitor_log
}

main
