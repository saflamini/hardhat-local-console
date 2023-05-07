#!/bin/bash

# Remove any existing PIDs file
rm -f pids.txt

# Spin up the hardhat node
(
  cd example-project
  npm install
  sleep 5
  yarn localnode &
  echo $! >> pids.txt

  # Give the hardhat node some time to start
  sleep 10


  yarn execute ./scripts/runDeployContractsAndToken.js
)


# # Wait for the hardhat node to be ready
# sleep 5

# Run this step for subgraph prep
(
  cd ethereum-contracts
  yarn
  yarn build:contracts-hardhat
)

# Wait for contracts to deploy

sleep 10

# Start the subgraph node in a Docker container
(
  cd subgraph
  # cp -r ../ethereum-contracts/artifacts/contracts/**/*[a-zA-z0-9]*.json ./abis ?? how to do this while not copying the .dbg.jsons
  # Run your two preparatory commands here, e.g.:
  yarn
  sleep 5
  yarn prepare-local
  sleep 3
  docker-compose up -d
  sleep 60
  # yarn build-and-deploy-local does may work when run in this context. If it fails, run it outside of the context of this script
  yarn build-and-deploy-local
  sleep 10
  # yarn deploy-local
)

sleep 3 # Wait for the subgraph to be ready

# Run the console project on localhost:3000
(
  cd console
  yarn install
  yarn run dev &
  echo $! >> pids.txt
)

# Wait for child processes to finish
wait
