# Use an official Python runtime as a parent image
FROM python:3.11

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose port 8000 (Django default)
EXPOSE 8000

# Run Django server
CMD ["gunicorn", "-b", "0.0.0.0:8000", "shipping.wsgi:application"]
