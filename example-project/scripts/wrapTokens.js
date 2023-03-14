const hre = require("hardhat");
const { Framework } = require("@superfluid-finance/sdk-core");
const { ethers } = require("hardhat");
require("dotenv").config();

async function main() {

//get hardhat accounts 
const [account1, account2, account3, account4] = await ethers.getSigners();

  const sf = await Framework.create({
    chainId: 31337,
    provider: account1.provider,
    resolverAddress: "0x67913A0F4F407BdBA24EBf89421A519b525a235f",
    protocolReleaseVersion: "test",
    customSubgraphQueriesEndpoint: "http://localhost:8000/subgraphs/name/superfluid-test/graphql"
  });

  const ethx = await sf.loadNativeAssetSuperToken("ETHx")

  
  console.log(await ethx.balanceOf({account: account1.address, providerOrSigner: account1}));

  const upgradeOp = ethx.upgrade({amount: "1000000000000000000"});

  await upgradeOp.exec(account1).then(console.log);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
