#!/bin/bash

# Encrypted backup script
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backups"
GPG_RECIPIENT="admin@company.com"
RETENTION_DAYS=7

# Create backup
TIMESTAMP=$(date +%Y%m%d-%H%M)
rsync -a --link-dest="$BACKUP_DIR/latest" "$SOURCE_DIR" "$BACKUP_DIR/$TIMESTAMP"
ln -sfn "$BACKUP_DIR/$TIMESTAMP" "$BACKUP_DIR/latest"

# Encrypt and compress
tar -czf - "$BACKUP_DIR/$TIMESTAMP" | gpg --encrypt --recipient "$GPG_RECIPIENT" > "$BACKUP_DIR/$TIMESTAMP.tar.gz.gpg"

# Apply retention policy
find "$BACKUP_DIR" -name "*.gpg" -type f -mtime +$RETENTION_DAYS -delete