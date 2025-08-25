# Use Python 3.11 slim image
FROM python:3.11-slim

# Install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create startup script
RUN echo '#!/bin/bash\n\
# Start nginx in background\n\
nginx &\n\
\n\
# Start Flask app with gunicorn\n\
exec gunicorn --bind 0.0.0.0:5000 --workers 2 app:app' > /app/start.sh

RUN chmod +x /app/start.sh

# Expose port 80 for nginx
EXPOSE 80

# Start both services
CMD ["/app/start.sh"]
