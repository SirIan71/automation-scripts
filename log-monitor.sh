#!/bin/bash

# Log analysis and Slack alerts
LOG_FILE="/var/log/syslog"  # Use "/var/log/messages" for CentOS
SLACK_WEBHOOK="https://hooks.slack.com/services/XXXXXX"
ERROR_KEYWORDS="error|fail|critical"

# Scan logs for errors
ERRORS=$(grep -E -i "$ERROR_KEYWORDS" "$LOG_FILE" | tail -n 5)

if [ -n "$ERRORS" ]; then
    # Send Slack alert
    curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"🚨 **System Alert**: Recent errors detected:\n\`\`\`$ERRORS\`\`\`\"}" \
    "$SLACK_WEBHOOK"
fi

# Generate daily summary (run via cron at 23:59)
echo "Daily Log Summary - $(date)" > /var/log/daily_summary.txt
grep -E -i "$ERROR_KEYWORDS" "$LOG_FILE" | wc -l >> /var/log/daily_summary.txt