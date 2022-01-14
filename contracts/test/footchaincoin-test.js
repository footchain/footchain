const { expect } = require("chai");
const { ethers } = require("hardhat");

//npx hardhat test test/footchaincoin-test.js

describe("Footchain Coin", function () {

    beforeEach(async function () {
        const FootChainCoin = await ethers.getContractFactory("FootChainCoin");
        const amount = ethers.utils.parseEther("2");
        footChainCoin = await FootChainCoin.deploy(amount);

        [owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners();

    });

    it("Should mint", async function () {
        const amount = ethers.utils.parseEther("1");
        await footChainCoin.mint(addr1.address, amount);
        const balance = await footChainCoin.balanceOf(addr1.address);
        expect(balance).to.equal(amount);
    });


    describe("Access Control", function () {
        let role;
        beforeEach(async function () {
            role = ethers.utils.solidityKeccak256(["string"], ["MINTER_ROLE"]);
            await footChainCoin.grantRole(role, addr1.address);
        });

        it("Should grant role minter to Addr1", async function () {
            const hasRole = await footChainCoin.hasRole(role, addr1.address);
            expect(hasRole).to.equal(true);
        });

        it("Should new minter to mint", async function () {
            const amount = ethers.utils.parseEther("1");
            await footChainCoin.connect(addr1).mint(addr2.address, amount);
            const balance = await footChainCoin.balanceOf(addr2.address);
            expect(balance).to.equal(amount);
        });

        it("Should not add new minter", async function () {
            await expect(footChainCoin.connect(addr2).grantRole(role, addr3.address)).to.be.reverted;
        });
    });

    it("Should revert when paused", async function () {
        const amount = ethers.utils.parseEther("1");
        await footChainCoin.pause();        
        await expect(footChainCoin.mint(addr1.address, amount)).to.be.reverted;
    });

});