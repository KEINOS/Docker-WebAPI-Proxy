#!/bin/sh

# Alpine doesn't have cURL by default
#curl --fail http://$(hostname)/ || exit 1

set -eu

hostname=${hostname:-$(cat /etc/hostname)}

function is_host_up () {
    #netstat -tulpn | grep :80 | grep nginx
    wget -q --spider "http://$(hostname)/"
    return $?
}

count_now=0
count_max=30
secs_sleep=5

while ! is_host_up; do
  if [ $count_now -gt $count_max ]; then
    echo 'Can not boot nginx.'
    exit 1
  fi
  echo "Waiting to boot Nginx. Host:${hostname} (${count_now}/${count_max})"
  sleep $secs_sleep
  count_now=$(expr $count_now + 1)
done

echo 'Host is up. Now fetching from:' $(hostname)
wget --spider "http://$(hostname)/" || exit 1
