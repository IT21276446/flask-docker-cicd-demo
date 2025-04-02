# flask-docker-cicd-demo

[![CI/CD Pipeline](https://github.com/IT21276446/flask-docker-cicd-demo/workflows/ci.yml/badge.svg)](https://github.com/IT21276446/flask-docker-cicd-demo/actions/workflows/ci.yml)

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
* Automated build, basic test, and push pipeline using GitHub Actions (`.github/workflows/ci.yml`).

## Technology Stack

* **Language/Framework:** Python 3.9 / Flask
* **Containerization:** Docker
* **CI/CD Tool:** GitHub Actions
* **Container Registry:** Docker Hub
* **Version Control:** Git & GitHub

## DevOps Pipeline (CI/CD)

The CI/CD pipeline is defined in `.github/workflows/ci.yml` and managed by GitHub Actions.

1.  **Trigger:** The workflow runs automatically on:
    * `push` events to the `main` branch.
    * `pull_request` events targeting the `main` branch.
2.  **Checkout Code:** The repository code is checked out in the runner environment.
3.  **Setup Docker Buildx:** Initializes Docker's build capabilities.
4.  **Build Docker Image:** Builds the Docker image using the `Dockerfile`. The image is tagged with the unique Git commit SHA (e.g., `sha-a1b2c3d4`). If triggered by a push to `main`, it's also tagged as `latest`. The image name format is `ashviniw/flask-devops-project`.
5.  **Basic Test:** A simple test runs the built container, waits a few seconds, and uses `curl` to check if the application's root URL (`/`) responds successfully.
6.  **Login to Docker Hub:** (Only on `push` to `main`) Logs into Docker Hub using credentials stored securely in GitHub Secrets (`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`).
7.  **Push to Docker Hub:** (Only on `push` to `main`) Pushes the tagged Docker image (`sha-...` and `latest`) to the specified Docker Hub repository.
