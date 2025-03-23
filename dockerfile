# Usar una imagen base de Python más ligera
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    rsync \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

ENV STREAMLIT_SERVER_HEADLESS=true
ENV STREAMLIT_SERVER_PORT=8501
ENV STREAMLIT_SERVER_ENABLECORS=false
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

CMD ["streamlit", "run", "app.py", "--server.enableCORS=false", "--server.headless=true", "--server.port=8080"]
