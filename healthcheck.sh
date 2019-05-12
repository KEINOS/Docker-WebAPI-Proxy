#!/bin/sh

# Alpine doesn't have cURL by default
#curl --fail http://$hostname/ || exit 1

set -eu

function is_host_up () {
    netstat -tulpn | grep :80 | grep nginx
    return $?
}

count_now=1
count_max=30
secs_sleep=3
while ! is_host_up; do
  echo "Waiting to boot Nginx(${count_now}/${count_max})"
  if [ $count_now -gt $count_max ]; then
    echo 'Can not boot nginx.'
    exit 1
  fi
  sleep $secs_sleep
  count_now=$(expr $count_now + 1)
done

echo "Fetching from: ${hostname}"
wget -q --spider "http://${hostname}/" || exit 1
