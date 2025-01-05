#!/bin/bash

# Check if sufficient arguments are passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

SOURCE="$1"
DESTINATION="$2"

# Ensure rsync is installed
if ! command -v rsync &>/dev/null; then
  echo "Error: rsync is not installed. Please install it and try again."
  exit 2
fi

# Ensure curl is installed for notifications
if ! command -v curl &>/dev/null; then
  echo "Error: curl is not installed. Please install it and try again."
  exit 2
fi

# Perform the rsync operation
rsync -aHAXv --progress --stats --delete "$SOURCE" "$DESTINATION"
RSYNC_STATUS=$?

# Send notification based on the result
if [ "$RSYNC_STATUS" -eq 0 ]; then
  echo "Backup completed successfully."
  curl -i -H "Accept: application/json" \
       -H "Content-Type:application/json" \
       -X POST \
       --data "{\"content\": \"Backup completed successfully from $SOURCE to $DESTINATION.\"}" \
       "https://discord.com/api/webhooks/1323312161350484120/LiaSGEPX3Mi14EDO_1bEn13ekJGhSexK7Mf3fjAZwa_iZwlzo8mpphPX7YreM6xXSXrh"
else
  echo "Error: rsync encountered an issue."
  curl -i -H "Accept: application/json" \
       -H "Content-Type:application/json" \
       -X POST \
       --data "{\"content\": \"Backup failed.\"}" \
       "https://discord.com/api/webhooks/1323312161350484120/LiaSGEPX3Mi14EDO_1bEn13ekJGhSexK7Mf3fjAZwa_iZwlzo8mpphPX7YreM6xXSXrh"
  exit 3
fi
