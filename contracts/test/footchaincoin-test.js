const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Footchain Coin", function () {
    
    beforeEach(async function () {
        const FootChainCoin = await ethers.getContractFactory("FootChainCoin");
        footChainCoin = await FootChainCoin.deploy();

        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        
    });

    it("Should mint", async function () {
        const amount = ethers.utils.parseEther("1");
        await footChainCoin.mint(addr1.address, amount);
        console.log("mint");
    });
});