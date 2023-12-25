#!/bin/bash
ZORA_NODE_DIR="/opt/zora-node"


# Check if the system is Ubuntu
if ! grep -q "Ubuntu" /etc/lsb-release; then
    echo "This script is for Ubuntu only. Exiting."
    exit 1
fi


# Check if the script is not running as root
if [ "$EUID" -ne 0 ]; then
    echo "Enter password to Switching to root"
    sudo su
fi

mkdir -p /opt/zora-node
cd  /opt/zora-node


sudo apt-get update && sudo apt-get upgrade -y

sudo apt install curl build-essential git screen jq pkg-config libssl-dev libclang-dev ca-certificates gnupg lsb-release -y

#install docker
# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed. Skipping installation."
else
    # Install Docker
    sudo apt-get install ca-certificates curl gnupg -y
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
    systemctl start docker
    systemctl enable docker
fi

# Check if Docker Compose is installed
if command -v docker-compose &> /dev/null; then
    echo "Docker Compose is already installed. Skipping installation."
else
    # Install Docker Compose
    sudo apt-get install docker-compose -y
fi

# install git


git clone https://github.com/conduitxyz/node.git
cd node
./download-config.py zora-mainnet-0


read -p "Enter ETH_RPC link: " OP_NODE_L1_ETH_RPC

# Write to the .env file
echo "OP_NODE_L1_ETH_RPC=$OP_NODE_L1_ETH_RPC" > "$ZORA_NODE_DIR/node/.env"

export CONDUIT_NETWORK=zora-mainnet-0

docker-compose up --build -d

