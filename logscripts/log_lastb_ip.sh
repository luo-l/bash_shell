sudo lastb | grep "$(date "+%b %d")"|awk '{a[$3]++} END {for (i in a){if(a[i]>10) print i,":",a[i]|"sort -r -g +2"}}'


