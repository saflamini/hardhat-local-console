# Superfluid Local Console

The Superfluid Developer Console is a great resource when building any Superfluid related project. You can find the hosted version here when working on any live testnet or main network: https://console.superfluid.finance.

However, it's much easier to tinker with new projects locally. This repo will help you run the console locally so that you can make this happen!

## Prerequisites
1. You must have docker installed and open on your machine. If it's not open, you'll get errors that the 'docker daemon is not running'
2. Make sure that your port 8545 is open and that you don't have any processes already running on port 5001 or port 5432. To check whether or not a process is running on these ports, you can use `lsof -i :8545` and then kill those process by taking the PID number returned by `lsof` and running `kill PID`

## Steps to Run The Console Locally

1. Run sh start.sh
2. If you receive an error that the subgraph was not deployed due to a 'connection refused' error or similar, then cd into ./subgraph and run `yarn build-and-deploy-local`
3. Create a stream in the example project folder to test it out by running the `wrapTokens` and `createFlow` scripts and specifying `--network localhost` like this: `npx hardhat run scripts/wrapTokens.js --network localhost` and `npx hardhat run scripts/createFlow.js --network localhost`
4. Head to your local console running on localhost:3000 and see your newly created stream in the 'Hardhat' tab!

You’re up and running! Now you can use the console locally with your other work!

### IF YOU MAKE A MISTAKE

Here’s how to troubleshoot if you make a mistake somewhere in this process and need to re start

1) Kill everything: shut down your hardhat node and your docker container running the subgraph

2) Delete the automatically generated `data` folder inside of the subgraph folder of the ethereum-contracts package. This is caching data from previous networks & deployments

### IF YOU RUN INTO ISSUES

For example:
- the subgraph isn’t indexing data, or the data it is indexing is old
- or your node is quitting immediately after booting up

Possible remedies: 
- Try deleting the automatically generated `data` folder inside of the subgraph folder of the ethereum-contracts package, then try again.
- You may also need to ensure that you don’t have other proccesses running on port 5432 or port 5001 - your container needs these for running IPFS and Postgres on your machine as a part of the subgraph node

If you have any questions, don't hesitate to reach out in the Superfluid Discord's #dev-support channel: https://discord.superfluid.finance