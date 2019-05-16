#!/bin/sh

# Test script
# ===========
# Run this script in entrypoint instead fo default
# to see if the containers are working.

# Boot nginx and gets header
/app/docker-entrypoint.sh forego start -r && \
wget --spider http://whoami:8000/
