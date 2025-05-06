Title: Automating Linux System Administration Tasks Using Shell Scripts
 Author: Ian Kibet Korir
 Date: May 6, 2025

Objective
This document presents a suite of shell scripts developed to automate key system administration tasks in a Linux environment. These tasks include automatic system updates, regular system backups, log file analysis, and email-based notification alerts. Automating these tasks enhances reliability, reduces administrative workload, and supports proactive system management.

Tools & Technologies
Shell Scripting: Bash (Bourne Again Shell)


Cron Jobs: For scheduling recurring tasks


Linux Utilities: apt, rsync, tar, grep, mail, df, uptime


Operating System: Ubuntu-based distributions



1. System Update Automation
Script: auto_update.sh
Purpose: Automates the process of updating the system’s packages using apt.
Highlights:
Runs apt update and apt upgrade -y


Logs update results to /var/log/update_script.log


Ideal for daily or weekly scheduled updates via cron


Sample Command:
sudo apt update && sudo apt upgrade -y


2. Automated System Backup
Script: backup.sh
Purpose: Creates compressed backups of important directories and stores them in a specified backup location.
Features:
Uses tar to archive directories like /etc, /home, or custom paths


Organizes backups by timestamp for version control


Can be integrated into scheduled jobs for daily backups


Sample Command:
tar -czf /backup/backup_$(date +%F).tar.gz /etc /home


3. Log File Analysis
Script: log_analysis.sh
Purpose: Parses system logs (e.g., /var/log/syslog, /var/log/auth.log) for suspicious activities, failed login attempts, or error messages.
Functions:
Uses grep and awk to extract meaningful alerts


Filters based on keywords like “error”, “fail”, or specific IPs


Can be configured to send a summary via email


Sample Command:
grep -i "fail" /var/log/auth.log | awk '{print $1, $2, $3, $9}'


4. System Health Notifications
Script: health_notify.sh
Purpose: Collects system metrics (disk usage, CPU load, uptime) and sends alerts via email if thresholds are exceeded.
Key Features:
Checks disk usage using df -h


Monitors system load with uptime


Sends summary via mail command to admin


Sample Command:
df -h | mail -s "Disk Usage Report" admin@example.com


Scheduling and Automation
These scripts can be scheduled using cron for full automation. Example crontab entry:
0 2 * * * /home/user/scripts/backup.sh

This schedules daily backups at 2:00 AM.

Conclusion
The scripts in this suite demonstrate the use of shell scripting to enhance system reliability and administrator efficiency. By automating common maintenance tasks, these tools reduce human error, provide timely system insights, and ensure the security and stability of the Linux environment. 


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
