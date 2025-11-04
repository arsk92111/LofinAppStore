FROM python:3.13-slim

WORKDIR /app
COPY . /app/

# Install system dependencies for mysqlclient 
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
