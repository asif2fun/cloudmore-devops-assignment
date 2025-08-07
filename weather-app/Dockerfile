FROM python:3.11-slim

# Set workdir
WORKDIR /app

# Copy only what’s needed
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY weather-app.py .

# Expose the Flask port
EXPOSE 5000

# Use ENV from .env or docker-compose (don't hardcode)
CMD ["python", "weather-app.py"]

