# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy files
COPY . .


# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variable for Google credentials path (if you're not using default service account)
#ENV GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}

# Command to run
CMD ["python", "main.py"]


