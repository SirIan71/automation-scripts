#!/bin/bash

# Slack notification wrapper
SLACK_WEBHOOK="https://hooks.slack.com/services/XXXXXX"
MESSAGE="$1"
CHANNEL="#alerts"

curl -X POST -H 'Content-type: application/json' \
--data "{\"channel\": \"$CHANNEL\", \"text\": \"$MESSAGE\"}" \
"$SLACK_WEBHOOK"