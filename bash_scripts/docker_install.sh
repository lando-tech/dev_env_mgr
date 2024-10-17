   #!/bin/bash

   # Check if Docker is installed
   if ! command -v docker &> /dev/null
   then
       echo "Docker is not installed. Installing..."

       # Update package index
       sudo apt update -y

       # Install prerequisite packages
       sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

       # Add Docker's official GPG key
       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

       # Add Docker's APT repository
       echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

       # Update package index again
       sudo apt update -y

       # Install Docker
       sudo apt install -y docker-ce

       echo "Docker installed successfully."
   else
       echo "Docker is already installed."
   fi
