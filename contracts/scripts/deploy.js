
/*
FOOTCHAIN ADDRESS: 0x201Fdf27716357FeA4e554Aae55a7B9b4Bd5Ff9B
PLAYER ADDRESS: 0x2B9c23A050C77b1b3282f941aA865C0F31D4A5E1
TEAM ADDRESS: 0xDeeFaAF8490f72c935bfaF52Bd34A863C8f5e308
MARKETPLACEPLAYER V1 ADDRESS: 0x2Bb76C3805257AAAb57D2ad32fF1De1Dd5a195a8
AIRDROP ADDRESS: 0xc6b595cBF135FFCb3f62d2D916089963be8D0B3F
PLAYER TRAINING ADDRESS: 0xf418C4AD5827e01b0caBAbD94E560A6895CAc581
*/
async function main() {
    // Hardhat always runs the compile task when running scripts with its command
    // line interface.
    //
    // If this script is run directly using `node` you may want to call compile
    // manually to make sure everything is compiled
    // await hre.run('compile');
  
    // We get the contract to deploy
    const Footchain = await hre.ethers.getContractFactory("FootChain");
    let footchain = await Footchain.deploy();
  
    console.log("FOOTCHAIN ADDRESS:", footchain.address);
  
    const Player = await hre.ethers.getContractFactory("Player");
    let player = await Player.deploy();
  
    console.log("PLAYER ADDRESS:", player.address);
  
    const Team = await hre.ethers.getContractFactory("Team");
    let team = await Team.deploy(footchain.address);
  
    console.log("TEAM ADDRESS:", team.address);
  
    const MarketplacePlayerV1 = await hre.ethers.getContractFactory("MarketplacePlayerV1");
    const amount = hre.ethers.utils.parseEther("1");
    let marketplacePlayerV1 = await MarketplacePlayerV1.deploy(footchain.address, player.address, team.address, amount);
  
    console.log("MARKETPLACEPLAYER V1 ADDRESS:", marketplacePlayerV1.address);
  
    const Airdrop = await hre.ethers.getContractFactory("Airdrop");
    let airdrop = await Airdrop.deploy(footchain.address);
  
    console.log("AIRDROP ADDRESS:", airdrop.address);
  
    const PlayerTraining = await hre.ethers.getContractFactory("PlayerTraining");
    let playerTraining = await PlayerTraining.deploy(footchain.address, player.address);
  
    console.log("PLAYER TRAINING ADDRESS:", playerTraining.address);
  
    const minterRole = ethers.utils.solidityKeccak256(["string"],["MINTER_ROLE"]);
          
    const txRoleMarketplacePlayerV1 = await player.grantRole(minterRole, marketplacePlayerV1.address);
  
    await txRoleMarketplacePlayerV1.wait();
  
    const txRolePlayerTraining = await footchain.grantRole(minterRole, playerTraining.address);
  
    await txRolePlayerTraining.wait();
  
    const amountAirdrop = hre.ethers.utils.parseEther("1000000");
  
    const txMintAirdrop = await footchain.mint(airdrop.address, amountAirdrop);
  
    await txMintAirdrop.wait();
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  