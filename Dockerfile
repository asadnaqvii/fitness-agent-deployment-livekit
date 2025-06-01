# Dockerfile
# Based on the Python example in asadnaqvii/livekit-agent-deployment :contentReference[oaicite:1]{index=1}

FROM python:3.10-slim

# Prevent Python from buffering stdout/stderr
ENV PYTHONUNBUFFERED=1

# Create and switch to app directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the codebase
COPY . .

# Download model files at build time so startup is faster
RUN python main.py download-files

# By default, run the coach_agent entrypoint (no extra args)
CMD ["python", "coach_agent.py dev"]
