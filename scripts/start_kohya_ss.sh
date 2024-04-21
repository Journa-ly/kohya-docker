#!/usr/bin/env bash
export PYTHONUNBUFFERED=1

# Function to check if azcopy is installed
check_azcopy() {
    if ! command -v azcopy &> /dev/null; then
        echo "azcopy could not be found, installing..."
        install_azcopy
    else
        echo "azcopy is already installed."
    fi
}

# Function to install azcopy
install_azcopy() {
    # Using snap to install azcopy
    echo "Installing azcopy using snap..."
    sudo snap install azcli
    if [ $? -ne 0 ]; then
        echo "Installation failed. Please install azcopy manually."
        exit 1
    fi
    echo "azcopy installation completed."
}

# Check if azcopy is installed, install if not
check_azcopy

# Sync data using azcopy with SAS token
storage_account_name="journatest"
container_name="training-image-data-ssh-keys-deploy-keys"
directory_in_container="/"
local_directory_path="./"
sas_token="sp=r&st=2024-04-16T16:07:36Z&se=2024-04-17T00:07:36Z&spr=https&sv=2022-11-02&sr=c&sig=iMC%2FlIMhCO8QaV0U829xH5u4YN6RQ%2BKmJNMSGms2Q0g%3D"


echo "copying training data ssh key"
# Using the correct variables and format for the azcopy command
azcopy copy "https://${storage_account_name}.blob.core.windows.net/${container_name}?${sas_token}" "$local_directory_path" --recursive


# Git clone training data
git clone git@github.com:Journa-ly/Training-images.git ~/journa-training-data

# Start Koyha
echo "Starting Kohya_ss Web UI"
cd /workspace/kohya_ss
source venv/bin/activate
export HF_HOME="/workspace"
nohup ./gui.sh --listen 0.0.0.0 --server_port 3001 --headless > /workspace/logs/kohya_ss.log 2>&1 &
echo "Kohya_ss started"
echo "Log file: /workspace/logs/kohya_ss.log"
