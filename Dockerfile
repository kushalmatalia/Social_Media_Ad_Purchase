# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install system dependencies and Python build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Install numpy, scipy, and Cython first to ensure scikit-learn can be built
RUN pip install --no-cache-dir numpy scipy Cython

# Install the remaining dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Command to run the Flask application
CMD ["python", "app.py"]

# Expose port 5000 to the outside world
EXPOSE 5000
