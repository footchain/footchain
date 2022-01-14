
async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    console.log("Account balance: ", (await deployer.getBalance()).toString());

    const players = await deployPlayer("0x514E1b729335d93F886E80E5Dd04c31c6CC50868", "0x3124527D4884864Efce8884bF5bb41c8cc901f8c");  
}

async function deployPlayer(footChainCoin, maintainer) {

    const Player = await ethers.getContractFactory("Player");
    const player = await Player.deploy(footChainCoin, maintainer);

    console.log("Player address:", player.address);

    return player;
}

main()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
});
