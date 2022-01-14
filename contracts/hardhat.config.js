require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

const PRIVATE_KEY = "";


/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  gasReporter: {
    enabled: false,
    token: 'AVAX',
    gasPriceApi: 'https://api.snowtrace.io/api?module=proxy&action=eth_gasPrice'
  },
  networks: {
    hardhat: {
    },
    velasTestnet: {
      chainId: 111,
      url: `https://evmexplorer.testnet.velas.com/rpc`,
      accounts: [`${PRIVATE_KEY}`]
    }
  }
};
