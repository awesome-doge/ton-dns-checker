#!/bin/bash
set -e

# Set the default environment or use the first argument of the script
export TONCENTER_ENV=${1:-stage}
STACK_NAME="${TONCENTER_ENV}-dns-checker"
echo "Stack: ${STACK_NAME}"

# Check for the existence of an environment-specific .env file
ENV_FILE=".env.${TONCENTER_ENV}"
if [ ! -f "${ENV_FILE}" ]; then
    ENV_FILE=".env"
fi

if [ -f "${ENV_FILE}" ]; then
    echo "Found environment file: ${ENV_FILE}"
    set -a  # Automatically export all variables
    source ${ENV_FILE}
    set +a
else
    echo "No environment file found."
    exit 1
fi

# Create the private directory if it does not exist
mkdir -p private

# Download configuration files
wget -q https://raw.githubusercontent.com/ton-blockchain/ton-blockchain.github.io/main/global.config.json -O private/mainnet.json
wget -q https://raw.githubusercontent.com/ton-blockchain/ton-blockchain.github.io/main/testnet-global.config.json -O private/testnet.json

# Choose configuration file based on environment
if [[ "${TONCENTER_ENV}" == "testnet" ]]; then
    echo "Using testnet config"
    export TON_LITESERVER_CONFIG=private/testnet.json
else
    echo "Using mainnet config"
    export TON_LITESERVER_CONFIG=private/mainnet.json
fi

# Build and push Docker images
docker-compose build
docker-compose push

# Deploy the stack using docker-compose.yaml
docker stack deploy -c docker-compose.yaml ${STACK_NAME}

# Connect the service to the global network if it exists
GLOBAL_NET_NAME=$(docker network ls --format '{{.Name}}' --filter NAME=toncenter-global)
if [ -n "$GLOBAL_NET_NAME" ]; then
    echo "Found network: ${GLOBAL_NET_NAME}"
    docker service update --detach --network-add name=${GLOBAL_NET_NAME},alias=${TONCENTER_ENV}-dns-checker ${STACK_NAME}_dns-checker
fi
