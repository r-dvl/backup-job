# Usar una imagen base de Python más ligera
FROM python:3.11-slim

WORKDIR /

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    rsync \
    && rm -rf /var/lib/apt/lists/*

COPY . .

# Change scripts permissions
RUN chmod +x /scripts/entrypoint.sh && \
    chmod +x /scripts/backup.sh

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Expose web UI port
EXPOSE 8080

# Additional configuration
ENV SRC_PATH="/source/"
ENV BACKUP_PATH="/backup/"
ENV WEB_UI=true
ENV WEBHOOK_URL="https://discord.com/api/webhooks/1323312161350484120/LiaSGEPX3Mi14EDO_1bEn13ekJGhSexK7Mf3fjAZwa_iZwlzo8mpphPX7YreM6xXSXrh"

# Streamlit configuration
ENV STREAMLIT_SERVER_HEADLESS=true
ENV STREAMLIT_SERVER_PORT=8080
ENV STREAMLIT_SERVER_ENABLECORS=false
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false
ENV STREAMLIT_SERVER_ENABLEXSRFPROTECTION=false

CMD ["/scripts/entrypoint.sh"]