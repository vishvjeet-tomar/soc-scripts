#!/bin/bash

timestamp(){
   local time=$(date "+%Y-%m-%d %H:%M:%S")
   echo "=== Login Failure Report ==="
   echo "Generated: $time"
   echo
}

extract_ip(){
   result=$(grep "Failed" /var/log/auth.log | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | sort | uniq -c | sort -nr)
}

count_attempt(){
   local add=0
   while read -r count ip; do
      (( add += count ))
   done <<< "$result"
   echo "Total failed attempts: $add"
   echo "Threshold: 3"
   echo
}

check_login(){
   echo "--- Brute Force Suspects (3+ attempts) ---"
   while read -r count ip; do
      if (( count >= 3 )); then
         echo "$count $ip  <-- BRUTE FORCE"
      fi
   done <<< "$result"
   echo
   echo "--- Other Failed IPs ---"
   while read -r count ip; do
      if (( count < 3 )); then
         echo "$count $ip"
      fi
   done <<< "$result"
   echo
   echo "--- Report saved to login_report.txt ---"
}

main(){
   timestamp
   extract_ip
   count_attempt
   check_login
}

main
