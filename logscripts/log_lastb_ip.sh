#!/bin/bash 
if  [[ $1 =~ ^[0-9]+$ ]]
then 
  filter1=$1
else
  filter1=10
fi

printf 'Display failed to login > %s times IP in this month (%s)\n' "$filter1" "$(date "+%Y-%m")"
lastblog="$(sudo lastb -s "$(date "+%Y-%m-01")" -t now)"

# use for check lastlog
# grep "ubuntu" <<<"$lastblog"|head -10

awk -v filter2="$filter1" '{a[$3]++} END {for (i in a){if(a[i]>filter2) print i,":",a[i]|"sort -r -g +2"}}' <<<"$lastblog"

# v1 one line to filter ip display greate than 10 times
# sudo lastb | grep "$(date "+%b %d")"|awk '{a[$3]++} END {for (i in a){if(a[i]>10) print i,":",a[i]|"sort -r -g +2"}}'

