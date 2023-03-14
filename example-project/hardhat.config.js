require("@nomiclabs/hardhat-truffle5")
require("@nomiclabs/hardhat-ethers")
// require("hardhat-deploy")

// require("@nomiclabs/hardhat-etherscan");

 require("dotenv").config();
 const GAS_LIMIT = 10000000;
  // const defaultNetwork = 'hardhat';

module.exports = {
  // defaultNetwork,
    solidity: {
        version: "0.8.16",
        settings: {
            optimizer: {
                enabled: true
            }
        }
    },
    namedAccounts: {
        deployer: 0
    },
    networks: {
    localhost: {
      url: "http://0.0.0.0:8545/",
    },
  }
    
}