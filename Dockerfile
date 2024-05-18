# Use the official slim Python image from the Docker Hub
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
# Install numpy first to satisfy scikit-learn dependency
RUN pip install --no-cache-dir numpy \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set the environment variable for Flask
ENV FLASK_APP=app.py

# Command to run the Flask application
CMD ["python", "app.py"]
