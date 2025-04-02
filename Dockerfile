 FROM python:3.9-slim

 # Set the working directory in the container
 WORKDIR /app

 # Copy the requirements file into the container at /app
 COPY requirements.txt .

 # Install any needed packages specified in requirements.txt
 RUN pip install --no-cache-dir -r requirements.txt

 # Copy the current directory contents into the container at /app
 COPY . .

 # Make port 5000 available to the world outside this container
 EXPOSE 5000

 # Define environment variables (optional, can be overridden)
 ENV FLASK_APP=app.py
 ENV FLASK_RUN_HOST=0.0.0.0
 ENV APP_VERSION=1.0.0 

 # Run app.py when the container launches
 # Use exec form to ensure signals are handled correctly
 CMD ["flask", "run"] 
 # Alternative using python directly: CMD ["python", "app.py"]
