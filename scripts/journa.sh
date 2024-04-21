#!/bin/bash

# Retrieve the token from the environment variable
TOKEN=${GIT_TOKEN}
if [ -z "$TOKEN" ]; then
  echo "Error: The GIT_TOKEN environment variable is not set."
  exit 1
fi

# Define other variables
REPO_URL="https://github.com/Journa-ly/Training-images" # Change this to your repository URL
DEST_DIR="journa-training-data"

# Check if the destination directory already exists
if [ -d "$DEST_DIR" ]; then
  echo "The directory $DEST_DIR already exists."
  exit 1
fi

# Clone the repository
echo "Cloning the repository into $DEST_DIR..."
git clone https://$TOKEN@${REPO_URL#https://} "$DEST_DIR"

# Verify the clone and provide feedback
if [ $? -eq 0 ]; then
    echo "Repository successfully cloned into $DEST_DIR."
else
    echo "Failed to clone the repository."
    exit 1
fi
