# flask-docker-cicd-demo

[![CI/CD Pipeline](https://github.com/IT21276446/flask-docker-cicd-demo/workflows/cicd.yml/badge.svg)](https://github.com/IT21276446/flask-docker-cicd-demo/actions/workflows/cicd.yml)

## Overview

This project demonstrates a basic DevOps workflow for a simple Python Flask web application. It covers:

1.  **Application Development:** A minimal Flask app displaying a greeting, version, and timestamp.
2.  **Containerization:** Packaging the application into a Docker image.
3.  **Continuous Integration (CI):** Using GitHub Actions to automatically build the Docker image and run a basic container health check on every push or pull request to the `main` branch.
4.  **Continuous Delivery (CD):** Automatically pushing the built Docker image to Docker Hub upon successful build and test on the `main` branch.

The goal is to showcase foundational DevOps practices like version control, containerization, and automated CI/CD pipelines.

**Note:** This project currently implements CI and CD up to the point of publishing the image to a container registry (Docker Hub). Deployment to a cloud environment like AWS is a potential next step.

## Features

* Simple Flask web server (`app.py`).
* Displays "Hello World!", the application version (read from environment variable `APP_VERSION`), and the current server time.
* Containerized using Docker (`Dockerfile`).
* Automated build, basic test, and push pipeline using GitHub Actions (`.github/workflows/cicd.yml`).

## Technology Stack

* **Language/Framework:** Python 3.9 / Flask
* **Containerization:** Docker
* **CI/CD Tool:** GitHub Actions
* **Container Registry:** Docker Hub
* **Version Control:** Git & GitHub

## DevOps Pipeline (CI/CD)

The CI/CD pipeline is defined in `.github/workflows/cicd.yml` and managed by GitHub Actions.

1.  **Trigger:** The workflow runs automatically on:
    * `push` events to the `main` branch.
    * `pull_request` events targeting the `main` branch.
2.  **Checkout Code:** The repository code is checked out in the runner environment.
3.  **Setup Docker Buildx:** Initializes Docker's build capabilities.
4.  **Build Docker Image:** Builds the Docker image using the `Dockerfile`. The image is tagged with the unique Git commit SHA (e.g., `sha-a1b2c3d4`). If triggered by a push to `main`, it's also tagged as `latest`. The image name format is `ashviniw/flask-devops-project`.
5.  **Basic Test:** A simple test runs the built container, waits a few seconds, and uses `curl` to check if the application's root URL (`/`) responds successfully.
6.  **Login to Docker Hub:** (Only on `push` to `main`) Logs into Docker Hub using credentials stored securely in GitHub Secrets (`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`).
7.  **Push to Docker Hub:** (Only on `push` to `main`) Pushes the tagged Docker image (`sha-...` and `latest`) to the specified Docker Hub repository.

## Setup and Running Locally (Without Docker)

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/IT21276446/flask-docker-cicd-demo.git](https://www.google.com/search?q=https://github.com/IT21276446/flask-docker-cicd-demo.git)
    cd flask-docker-cicd-demo
    ```
2.  **Create and activate a virtual environment:**
    ```bash
    python -m venv venv
    # Windows
    .\venv\Scripts\activate
    # macOS/Linux
    source venv/bin/activate
    ```
3.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```
4.  **Run the Flask app:**
    ```bash
    flask run
    # Or: python app.py
    ```
5.  Open your browser and navigate to `http://127.0.0.1:5000`.

## Running with Docker

1.  **Ensure Docker is running.**
2.  **Build the Docker image:**
    ```bash
    # Replace with your Docker Hub username (or any preferred image name)
    docker build -t YOUR_DOCKERHUB_USERNAME/flask-devops-project:local .
    ```
3.  **Run the Docker container:**
    ```bash
    # Runs the container, mapping host port 5001 to container port 5000
    # Sets the APP_VERSION inside the container
    docker run -d -p 5001:5000 --name my-local-flask-app \
      -e APP_VERSION="local-docker-run" \
      YOUR_DOCKERHUB_USERNAME/flask-devops-project:local
    ```
4.  Open your browser and navigate to `http://localhost:5001`.
5.  **To stop the container:** `docker stop my-local-flask-app`
6.  **To remove the container:** `docker rm my-local-flask-app`

## Docker Hub Image

The CI/CD pipeline automatically pushes the built image to Docker Hub upon merges to the `main` branch.

You can find the public image here:
[https://hub.docker.com/r/ashviniw/flask-devops-project](https://hub.docker.com/r/ashviniw/flask-devops-project)

You can pull the latest image using:
```bash
docker pull ashviniw/flask-devops-project:latest
