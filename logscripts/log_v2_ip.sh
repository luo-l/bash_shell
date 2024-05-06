#!/bin/bash 
# The regular expression ^[0-9]{6,8}$ checks if the input is  6-8 digits long. 
#If the input is >= 6 digits, we use parameter expansion to extract the first 4 digits (${1:0:4}) and the last 2 digits (${1:4:2}), and format them as yyyy/mm. 
# If the input is not 6 digits, we default to the current year and month using date "+%Y/%m".
if [[ $1 =~ ^[0-9]{6,8}$ ]]; then
  filter1=${1:0:4}/${1:4:2}
else
  filter1=$(date "+%Y/%m")
fi

#printf 'Display failed to login > %s times IP in this month (%s)\n' "$filter1" "$(date "+%Y-%m")"

#------------------------
#awk '{match($3,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); ip = substr($3,RSTART,RLENGTH); count[ip][$4]++} END {for (ip in count) {print $1 "  "ip" accepted "count[ip]["accepted"]+0" "times" rejected "count[ip]["rejected"]+0" "times}}' <<<"$v2log"
#sudo  awk '{match($3,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); ip = substr($3,RSTART,RLENGTH); print $1" "ip" "$4}' /var/log/v2ray/access.log|uniq|sort -k 2

#awk '{match($3,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); ip = substr($3,RSTART,RLENGTH); count[ip][$4]++} END {for (ip in count) {print ip" accepted "count[ip]["accepted"]" "times" rejected "count[ip]["rejected"]" "times}}' access.log | grep '2024/05'

#awk '{match($3,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); ip = substr($3,RSTART,RLENGTH); date = $1; count[date,ip][$4]++} END {for (date in count) {for (ip in count[date]) {print date" "ip" accepted "count[date,ip]["accepted"]" times rejected "count[date,ip]["rejected"]" times"}}' access.log | grep '2024/05'

#------------------------

# Extract IP address and count occurrences of "accepted" and "rejected" for each date and IP

# Use Case:
# This script is used to process a log file containing lines with the following format:
# date ip-address status
# Where status can be either "accepted" or "rejected".
# The script extracts the IP address and counts the occurrences of "accepted" and "rejected" for each date and IP address.
# The output is formatted as:
# date ip-address rejected <count> times accepted <count> times;
v2log="$(sudo grep "$(date "+%Y/%m")" /var/log/v2ray/access.log)"
awk '{
  # Extract IP address from field 3
  match($3, /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
  ip = substr($3, RSTART, RLENGTH)
  
  # Set date and initialize count array
  date = $1" "
  count[date, ip][$4]++
} 
END {
  # Loop through dates and IPs
  for (date in count) {
    for (ip in count[date]) {
      # Print count of rejected and accepted occurrences
      printf "%s %s rejected %s times accepted %s times;\n", 
             date, ip, (count[date, ip]["rejected"]+0), (count[date, ip]["accepted"]+0)
    } 
    # Print newline after each date
    print ""
  }
}' <<<"$v2log"
