const { expect } = require("chai");
const { ethers } = require("hardhat");


//npx hardhat test test/airdrop-test.js
describe("Footchain Coin", function () {

    let sig;
    let airdropAmount;
    let airdrop;

    beforeEach(async function () {
        const amount = ethers.utils.parseEther("100");
        const FootChainCoin = await ethers.getContractFactory("FootChainCoin");
        footChainCoin = await FootChainCoin.deploy(amount);

        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

        const Airdrop = await ethers.getContractFactory("Airdrop");
        airdrop = await Airdrop.deploy(footChainCoin.address);

        airdropAmount = ethers.utils.parseEther("10");
        //COLOCOU SALDO NO CONTRATO DE AIRDROP  
        footChainCoin.mint(airdrop.address, ethers.utils.parseEther("10"));

        //AREA QUE SERA EXECUTADA NO SERVIDOR
        //ENTRADA: ENDEREÇO DA CARTEIRA
        //SAIDA: ASSINATURA DIGITAL, LIN. 32

        let payload = ethers.utils.defaultAbiCoder.encode(["address", "uint256"], [addr1.address, airdropAmount]);
        //console.log("Payload:", payload);

        let payloadHash = ethers.utils.keccak256(payload);
        //console.log("PayloadHash:", payloadHash);

        let signature = await owner.signMessage(ethers.utils.arrayify(payloadHash));
        //FIM - AREA QUE SERA EXECUTADA NO SERVIDOR

        //AREA QUE SERA EXECUTADA NO CLIENTE
        sig = ethers.utils.splitSignature(signature);
        //console.log("Signature:", sig);

    });

    it("Should claim token from Airdrop", async function () {
        //console.log("Recovered:", ethers.utils.verifyMessage(ethers.utils.arrayify(payloadHash), sig));
        await airdrop.connect(addr1).claimTokens(addr1.address, airdropAmount, sig.v, sig.r, sig.s);
        const balance = await footChainCoin.balanceOf(addr1.address);
        expect(balance).to.be.equal(airdropAmount);
        //console.log("Transaction:", tx.hash);
        //FIM - AREA QUE SERA EXECUTADA NO CLIENTE
    });

    it("Should revert when paused", async function () {
        await airdrop.pause();
        await expect(airdrop.connect(addr1).claimTokens(addr1.address, airdropAmount, sig.v, sig.r, sig.s)).to.be.reverted;
    });

    it("Should revert when paused by stranger", async function () {
        await expect(airdrop.connect(addr1).pause()).to.be.reverted;
    });
});