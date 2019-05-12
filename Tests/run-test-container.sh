#!/bin/sh

# Run this script from a container.
# This script cURLs the localhost's API endpoint to see work.

set -eu

cd $(dirname $0)

# Function to Ping host
function is_host_up () {
    result=1
    ping -c 3 -t 3 -s 32 $NAME_HOST > /dev/null;
    if [ $? -eq 0 ]; then
        #success
        result=0
    fi
    return $result
}

# Check is host up
echo "Host Name: ${NAME_HOST}"
echo "Host Port: ${PORT_HOST_TEST}"
retry_max=5
while ! is_host_up; do
    retry=$(expr ${retry:-0} + 1)
    echo 'Pinging host ...'
    sleep 3
    if [ $retry -gt $retry_max ]; then
      echo '  * Host is down'
      exit 1
    fi
    echo "Retry: ${retry}"
done
echo '  - Host is up'

# Get random value to send
text_expect=$(cat /dev/urandom | base64 | fold -w 10 | head -n 1 | sed 's/\+/X/g')

# Test
text_result=$(curl "http://${NAME_HOST}:${PORT_HOST_TEST}/app1/?test=${text_expect}")

echo "Expect   : ${text_expect}"
echo "Result   : ${text_result:-error}"

echo 'Running test ...'
if [ "${text_expect}" = "${text_result}" ]; then
   echo 'Test passed.'
   exit 0
fi

echo 'Test failed.'
exit 1
