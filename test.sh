#!/bin/bash

# Define the directory where the repository should be cloned
TARGET_DIR="/journa-training-data"

# Define the repository URL
REPO_URL="https://github.com/Journa-ly/Training-images.git"

# Read Personal Access Token from a secure location
# It's assumed here that your token is stored in a file at /path/to/your/token
TOKEN=$(cat /path/to/your/token)

# Check if the directory already exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Directory $TARGET_DIR does not exist. Creating now..."
    mkdir -p $TARGET_DIR
    if [ $? -ne 0 ]; then
        echo "Failed to create directory $TARGET_DIR"
        exit 1
    fi
else
    echo "Directory $TARGET_DIR already exists."
fi

# Change to the target directory
cd $TARGET_DIR

# Clone the repository using the token
echo "Cloning repository..."
git clone https://${TOKEN}@$(echo $REPO_URL | sed 's/https:\/\///')

# Verify the clone was successful
if [ $? -eq 0 ]; then
    echo "Repository cloned successfully."
else
    echo "Failed to clone the repository."
    exit 1
fi

