const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CryptoNFT", function () {
    
    beforeEach(async function () {
        const FootChainCoin = await ethers.getContractFactory("FootChainCoin");
        footChainCoin = await FootChainCoin.deploy();

        const Player = await ethers.getContractFactory("Player");
        player = await Player.deploy();

        const Training = await ethers.getContractFactory("Training");
        training = await Training.deploy(footChainCoin.address, player.address);

        //setar a role de mint para o contrato de training
        footChainCoin.addMintRole(training.address);

        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        
    });

    it("Should mint", async function () {
        function timeout(ms) {
            return new Promise(resolve => setTimeout(resolve, ms));
        }            
        const tx = await player.mint(owner.address, "https://google.com");
        await tx.wait();

        await training.start(1);
        
        await timeout(2000);

        await training.finish(1);

        const balance = await player.balanceOf(owner.address);
        expect(balance).to.equal(1);
    });
});