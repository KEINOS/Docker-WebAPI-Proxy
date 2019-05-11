#!/bin/sh

# Run this script from a container.
# This script cURLs the localhost's API endpoint to see work.

set -eu

cd $(dirname $0)

# Random value
text_expect=$(cat /dev/urandom | base64 | fold -w 10 | head -n 1)

text_result=$(curl "http://${NAME_HOST}:${PORT_HOST_TEST}/app1/?test=${text_expect}") && \
docker-compose down

# Test
echo "Host Port: ${PORT_HOST_TEST}"
echo "Expect   : ${text_expect}"
echo "Result   : ${text_result:-error}"
if [ "${text_expect}" = "${text_result}" ]; then
   echo 'Test passed.'
   exit 0
fi

echo 'Test failed.'
exit 1
