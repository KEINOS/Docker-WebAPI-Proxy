#!/bin/sh

# Alpine doesn't have cURL by default
#curl --fail http://localhost/ || exit 1

function is_host_up () {
    netstat -tulpn | grep :80 | grep nginx
    return $?
}

while ! is_host_up; do
  sleep 1
done

wget -q --spider http://localhost/ || exit 1
