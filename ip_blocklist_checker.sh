#!/bin/bash

timestamp(){
   local time=$(date "+%Y-%m-%d %H:%M:%S")
   echo "=== IP Blocklist Report ==="
   echo "Generated: $time"
   echo
}

check_ip(){
   echo "--- Checking Suspicious IPs Against Blocklist ---"
   echo
   while read -r ip; do
      if grep -qF "$ip" blocklist.txt; then
         echo "BLOCKED: $ip is on the blocklist"
      else
         echo "CLEAN:   $ip not on blocklist"
      fi
   done < suspicious.txt
   echo
   echo "--- Report saved to blocklist_report.txt ---"
}

main(){
   timestamp
   check_ip
}

main >> blocklist_report.txt
