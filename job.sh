for i in apple banana cherry
do
  cat job-tmpl.yaml | sed "s/\$ITEM/$i/" > ./jobs/job-$i.yaml
done
# This function calculates the factorial of a given non-negative integer.
# It uses a recursive approach to compute the result.
# 
# Parameters:
#   n (int): A non-negative integer for which the factorial is to be calculated.
#
# Returns:
#   int: The factorial of the input integer n.
#
# Raises:
#   ValueError: If n is a negative integer.
factorial() {
  if [ $1 -lt 0 ]; then
    echo "Error: n must be a non-negative integer." >&2
    return 1
  fi  
  if [ $1 -eq 0 ]; then
    echo 1
  else
    local prev=$(factorial $(($1 - 1)))
    echo $(($prev * $1))
  fi
} 