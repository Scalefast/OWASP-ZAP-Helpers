#!/bin/bash

# Add a file, to use global variables 
source /zap/env/.env

echo "Zap .env file:"
cat /zap/env/.env

mkdir /zap/env/report

echo "Zap headers file:"
cat /zap/env/auth_post_request.json

# Make a request to the API, to get authorization (The token)
# The "$@" parameter adds the ability to add headers from within this script, 
# So there is no need for script modification.
/zap/env/genJSON.sh Authorization "$ACCESS_TOKEN" "$@" > /zap/env/headers.json

echo "Zap configs:"
cat /zap/env/zapConfigs

# First execution of zap, to install addons and configure ZAP to run.
# add-headers.py script on every request
zap.sh -port 1234 -cmd -addoninstall jython -configfile /zap/env/zapConfigs
# Second execution of zap, to run actual tests against specified endpoints.
zap.sh -port 1234 -cmd -autorun /zap/"$ZAP_CONFIG_FILE"
