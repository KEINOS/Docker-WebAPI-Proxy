#!/bin/sh

# Alpine doesn't have cURL by default
#curl --fail http://localhost/ || exit 1

wget -q --spider http://localhost/ || exit 1
