#!/bin/sh

# Alpine doesn't have cURL by default
#curl --fail http://$hostname/ || exit 1

set -eu

function is_host_up () {
    netstat -tulpn | grep :80 | grep nginx
    return $?
}

count=1
count_max=30
while ! is_host_up; do
  echo "Waiting to boot Nginx(${count}/${count_max})"
  if [ $count -gt $count_max ]; then
    echo 'Can not boot nginx.'
    exit 1
  fi
  sleep 1
  count=$(expr $count + 1)
done

echo "Fetching from: ${hostname}"
wget -q --spider "http://${hostname}/" || exit 1
