# System Backup Automation Script (Linux)

This Bash script performs automated backups of essential Linux system files and directories. It is designed to help beginner system administrators understand basic backup strategies using native tools.

---

## What It Does

- rsync `/etc`, `/home`, and `/var/log` into a `/backups` directory
- Appends a timestamp and hostname to the backup filename
- Stores backups in `/backups/`
- Automatically deletes old backups older than 7 days
- Logs all backup operations

---

## Requirements

- Linux system (tested on Ubuntu/Debian)
- `rsync`, `date`, `find` commands (default on most distros)
- `sudo` privileges for accessing system directories

---

## How to Use

1. Make the script executable:
```bash
chmod +x backup_script.sh
sudo ./backup_script.sh
```

 Output
* Example backup file: hostname_backup_2025-06-03_22-40-15.tar.gz
* Stored in: /opt/backups/
* Log file: /opt/backups/backup_log.txt
