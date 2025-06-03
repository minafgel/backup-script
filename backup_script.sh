#!/bin/bash

# ------------------------------------------
# System Backup Script using rsync
# ------------------------------------------
# Description:
# - Copies system files to a backup directory using rsync
# - Creates a timestamped folder for each backup
# - Logs the backup activity
# ------------------------------------------

# Directories to back up (space-separated)
BACKUP_SRC="/etc /home /var/log"

# Destination for backups
BACKUP_ROOT="/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DEST="$BACKUP_ROOT/backup_$TIMESTAMP"
LOGFILE="$BACKUP_ROOT/backup_log.txt"

# Create the main backup directory if it doesn't exist
echo "Creating backup destination directory."
sudo mkdir -p "$BACKUP_DEST"

# Start the backup using rsync
echo "Starting backup using rsync."
for DIR in $BACKUP_SRC; do
    BASENAME=$(basename $DIR)
    echo "Backing up $DIR to $BACKUP_DEST/$BASENAME"
    sudo rsync -a --delete "$DIR" "$BACKUP_DEST/" 2>> $LOGFILE
done

# Log the operation
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] Backup completed successfully at $BACKUP_DEST" | tee -a $LOGFILE
else
    echo "[$TIMESTAMP] Backup failed!" | tee -a $LOGFILE
    exit 1
fi

# Optional: delete backups older than 7 days
echo "Removing old backups (older than 7 days)."
sudo find "$BACKUP_ROOT" -maxdepth 1 -type d -name "backup_*" -mtime +7 -exec rm -rf {} \;

echo "Script finished. All activity logged in $LOGFILE."
