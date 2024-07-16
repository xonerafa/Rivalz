#!/bin/bash

echo "Starting the setup process..."

# Step 1: Download and install NVM
echo "Downloading and installing NVM..."
if command -v curl &> /dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    if [ $? -ne 0 ]; then
        echo "Failed to install NVM. Exiting..."
        exit 1
    fi
else
    echo "curl is not installed. Please install curl and rerun this script."
    exit 1
fi

# Load nvm and bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Ensure the shell knows where to find nvm
source ~/.bashrc

# Step 2: Install Node.js
echo "Installing Node.js..."
nvm install node
if [ $? -ne 0 ]; then
    echo "Failed to install Node.js. Exiting..."
    exit 1
fi

# Update npm to a specific version
echo "Updating npm to version 10.8.2..."
npm install -g npm@10.8.2
if [ $? -ne 0 ]; then
    echo "Failed to update npm to version 10.8.2. Exiting..."
    exit 1
fi

# Optional: Fund the npm package maintainers (only if needed, can be removed)
echo "Funding npm package maintainers..."
npm fund

# Step 3: Install rClient CLI
echo "Installing rivalz-node-cli..."
npm install -g rivalz-node-cli
if [ $? -ne 0 ]; then
    echo "Failed to install rivalz-node-cli. Exiting..."
    exit 1
fi

# Step 4: Update rClient to the latest version
echo "Updating rivalz-node-cli to the latest version..."
rivalz update-version
if [ $? -ne 0 ]; then
    echo "Failed to update rivalz-node-cli. Exiting..."
    exit 1
fi

# Step 5: Run rClient
echo "Running rivalz-node-cli..."
rivalz run
if [ $? -ne 0 ]; then
    echo "Failed to run rivalz-node-cli. Exiting..."
    exit 1
fi

echo "Setup completed successfully."
