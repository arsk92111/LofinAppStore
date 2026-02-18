# Use the official Python image
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Install system dependencies (including GDAL)
RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    gcc \
    g++ \
    build-essential \
    pkg-config \
    python3-dev \
    libproj-dev \
    libgeos-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app/

# Create virtual environment and install dependencies
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose port
EXPOSE 8000

ENV PATH="/opt/venv/bin:$PATH"
CMD ["gunicorn", "LofinApp_Project.wsgi:application", "--bind", "0.0.0.0:8000"]
