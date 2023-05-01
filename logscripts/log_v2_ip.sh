sudo  awk '{match($3,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/); ip = substr($3,RSTART,RLENGTH); print $1" "ip" "$4}' /var/log/v2ray/access.log|uniq|sort -k 2

