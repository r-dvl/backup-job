# Backup Job
Rsync backup used as cron job in Kubernetes.

## Example manifest
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: storage-backup
spec:
  schedule: "0 2 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: backup
            image: ghcr.io/r-dvl/backup-job:latest
            args: ["/mnt/Storage/DATA/", "/mnt/Backup/DATA/"]
            env:
            - name: SRC_PATH
              value: /source/
            - name: BACKUP_PATH
              value: /backup/
            - name: WEB_UI
              value: "true"
            - name: WEBHOOK_URL
              value: https://example-webhook.com
            volumeMounts:
            - name: backup-volume
              mountPath: /backup
            - name: storage-volume
              mountPath: /source
          restartPolicy: OnFailure
          volumes:
          - name: backup-volume
            hostPath:
              path: /mnt/Backup
              type: DirectoryOrCreate
          - name: storage-volume
            hostPath:
              path: /mnt/Storage
              type: DirectoryOrCreate
      backoffLimit: 4
```
