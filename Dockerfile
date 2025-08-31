FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

# Install system dependencies needed for SSL and runtime
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	   ca-certificates \
	&& rm -rf /var/lib/apt/lists/* \
	&& update-ca-certificates

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

COPY model/ ./model/

# Make the startup script executable
RUN chmod +x start.sh

# Expose the default application port (Render sets PORT at runtime)
EXPOSE 8000

# Use the startup script
CMD ["./start.sh"]
