#!/bin/bash

if [ "$WEB_UI" = "true" ]; then
    echo "Starting web UI..."
    streamlit run /ui/app.py --server.enableCORS=false --server.headless=true --server.port=8080
else
    echo "Runing backup..."
    scripts/backup.sh $SRC_PATH $BACKUP_PATH
fi