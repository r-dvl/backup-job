FROM alpine:latest

RUN apk add --no-cache bash curl rsync

WORKDIR /scripts

COPY src/backup.sh /scripts/backup.sh

RUN chmod +x /scripts/backup.sh

ENTRYPOINT ["/scripts/backup.sh"]
