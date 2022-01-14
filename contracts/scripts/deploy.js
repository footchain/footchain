/**
 LAST DEPLOY RESULT:
Deploying contracts with the account: 0x885D82FCc13f8E313FdED6FE0016B1b5EcF70437
Account balance:  10999843758236000000000
Token address: 0x514E1b729335d93F886E80E5Dd04c31c6CC50868
Airdrop address: 0x0baccaFCa6a296a2EE24c176738514b0dC773C5d
Maintainer address: 0x3124527D4884864Efce8884bF5bb41c8cc901f8c
Player address: 0x518bA768C9955F91d9755aA8956266f9B4f87eeD
Training address: 0x1E07A3dEa59725CAd2c1189b1499B4c362C87bF0
 */

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    console.log("Account balance: ", (await deployer.getBalance()).toString());

    const footchain = await deployToken();
    const airdrop = await deployAirdrop(footchain);
    const maintainers = await deployMaintainers(footchain);
    const players = await deployPlayer(footchain, maintainers);    
    const trainning = await deployTrainning(footchain, players);    
}

async function deployToken() {
    const amount = ethers.utils.parseEther("100000000");
    const Token = await ethers.getContractFactory("FootChainCoin");
    const footChainCoin = await Token.deploy(amount);

    console.log("Token address:", footChainCoin.address);

    return footChainCoin;
}

async function deployAirdrop(footChainCoin) {
    const Airdrop = await ethers.getContractFactory("Airdrop");
    const airdrop = await Airdrop.deploy(footChainCoin.address);
    const airdropAmount = ethers.utils.parseEther("1000000");
    await footChainCoin.mint(airdrop.address, airdropAmount);
    console.log("Airdrop address:", airdrop.address);

    return airdrop;
}

async function deployMaintainers(footChainCoin) {

    const Maintainer = await ethers.getContractFactory("Maintainers");
    const maintainer = await Maintainer.deploy(footChainCoin.address);

    console.log("Maintainer address:", maintainer.address);

    return maintainer;
}

async function deployPlayer(footChainCoin, maintainer) {

    const Player = await ethers.getContractFactory("Player");
    const player = await Player.deploy(footChainCoin.address, maintainer.address);

    console.log("Player address:", player.address);

    return player;
}

async function deployTrainning(footChainCoin, player) {

    const Training = await ethers.getContractFactory("Training");
    const training = await Training.deploy(footChainCoin.address, player.address);

    console.log("Training address:", training.address);

    return training;
}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
    