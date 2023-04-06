#!/bin/bash

# Remove any existing PIDs file
rm -f pids.txt

# Spin up the hardhat node
(
  cd example-project
  npm install
  sleep 5
  npx hardhat node &
  echo $! >> pids.txt

  # Give the hardhat node some time to start
  sleep 10

  yarn hardhat run scripts/runDeployContractsAndToken.js --network localhost
)


# # Wait for the hardhat node to be ready
# sleep 5

# Run this step for subgraph prep
(
  cd ethereum-contracts
  yarn run-hardhat compile
)

# Wait for contracts to deploy

sleep 10

# Start the subgraph node in a Docker container
(
  cd subgraph
  # Run your two preparatory commands here, e.g.:
  yarn
  sleep 5
  yarn prepare-local
  sleep 5
  docker-compose up -d

  sleep 10

  yarn build-and-deploy-local
)

sleep 3 # Wait for the subgraph to be ready

# Run the console project on localhost:3000
(
  cd console
  yarn install
  yarn dev &
  echo $! >> pids.txt
)

# Wait for child processes to finish
wait
