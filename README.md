# Setup Instructions
Save scripts to /scripts/ and make them executable:


$ chmod +x /scripts/*.sh


Replace placeholders:

SLACK_WEBHOOK with your actual Slack URL.

GPG_RECIPIENT with the admin’s GPG email.

Install dependencies:


- $ apt-get install cron rsync gpg   # Ubuntu
- $ yum install cronie rsync gnupg2  # CentOS

These scripts mirror the functionality required in routine tasks 



## Cron Jobs

Schedule tasks in /etc/crontab:
### Daily updates at midnight
0 0 * * * root /scripts/auto_updates.sh

### Log analysis every hour
0 * * * * root /scripts/log_monitor.sh

### Nightly backups at 2 AM
0 2 * * * root /scripts/backup_manager.sh


- scripts and automation are good in performing routine tasks that are lengthy. it saves time and little to no adjustments are required in the code.
