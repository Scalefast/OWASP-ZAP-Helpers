#!/bin/bash

# Get auth token, using auth_post_request.json POST data.
# We use this approach to prevent secrets being uploaded to git.

APIRESPONSE=$(curl --silent -X POST -H "Content-Type: application/json" \
	-d @/zap/env/auth_post_request.json \
	https://<your API URL>/authentication/oauth )

# Modify so the regex matches only the token from your response
echo $APIRESPONSE | sed 's/^{.*"access_token":"\(.*\)",.*$/\1/' 
