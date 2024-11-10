![CnvJEcYXEAEooL7](https://github.com/user-attachments/assets/5cf485aa-a38f-4950-9c25-df808c9121a8)

# Kyb3r

## Overview

**Kyb3r** is a Dockerized web server that uses Tor to provide an anonymous, hidden service. It allows users to securely host a website on the Tor network, ensuring that the site is only accessible via a `.onion` address. The application sets up an Nginx web server that is served through a Tor hidden service, providing both anonymity and security for the web server and its users. Kyb3r is ideal for developers and organizations who need to host a site with privacy and security considerations in mind.

## Features
- **Dockerized**: Easily deploy the service in a containerized environment using Docker.
- **Tor Hidden Service**: The application runs behind a Tor hidden service, making the site accessible only via a Tor `.onion` address.
- **Nginx Web Server**: Uses Nginx as the reverse proxy to serve web pages over HTTP.
- **Security Headers**: Configured with several security headers, including X-Frame-Options, Content-Security-Policy, and X-XSS-Protection.
- **No Logs**: By default, no logs are saved by Nginx, ensuring a minimal footprint.
- **Easy Setup**: Simple Docker setup for quick deployment with minimal configuration.

## Setup

### Prerequisites
Before starting, you need to have the following installed:
- [Git](https://git-scm.com/downloads)
- [Docker](https://docs.docker.com/get-docker/)

### Clone the repository
First, clone the repository to your local machine:
```bash
git clone https://github.com/z0ne323/Kyb3r
cd Kyb3r
```

### Docker Setup
Follow the steps below to build and run the Docker container for Kyb3r:
1. **Build the Docker image:**  Build the Docker image using the following command. The `--no-cache` option ensures that the build doesn't use any cached layers.
```bash
sudo docker build --no-cache -t kyb3r-image .
```
2. **Run the Application:** 
You can run the Docker container in two modes:
   - **Interactive mode:**
      To start the container interactively (e.g., for debugging or directly interacting with the container), run:
      ```bash
      sudo docker run -it --name kyb3r-service kyb3r-image
      ```
   - **Detached mode:** To run the container in detached mode (background), run: 
      ```bash
      sudo docker run -d --name kyb3r-service kyb3r-image
      ```
3. **Interact with the Application:** If you need to interact with the running container (e.g., to check configurations or troubleshoot), you can access the container through a bash shell like that:
```bash
sudo docker exec -it kyb3r-service /bin/bash 
```

### Access the Application
The application will be available via a Tor **.onion** address that is generated by the Tor service within the container. There are two ways to find this **.onion** address:
1. **Automatic Fetch:** when launching the container, you can fetch the generated **.onion** address directly from the output:
- Start the container in interactive mode and retrieve the **.onion** address:
```bash
sudo docker run -it --name kyb3r-service kyb3r-image
```
2. **Fetch After Tor Startup:** Alternatively, the **.onion** address can be found within the container after it's already launched.
- Grab the **.onion** address by running this command inside the container:
```bash
cat /var/lib/tor/hidden_service/hostname
```

**Important:** You may need to wait a few moments for Tor to finish setting up the hidden service and generate the **.onion** address to access it.

### Logging
By default, **Nginx does not keep any logs** in the container. Both access and error logs are directed to `/dev/null`, effectively disabling logging. This ensures minimal traceability and enhances privacy.

### Troubleshooting
If you encounter any issues with the container, you can reset it by stopping and removing any existing containers:
```bash
sudo docker stop $(sudo docker ps -aq) && sudo docker rm $(sudo docker ps -aq)
```
Afterward, rebuild and restart the container using the setup commands above.

### Contributing
Feel free to fork the repository and submit a pull request. 
