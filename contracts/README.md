# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
# Contratos

- Footchain.sol
    Contrato responsável por emitir a moeda oficial do jogo.

- Player.sol
    Nesse contrato estão mintados os jogadores

- PlayerTraining.sol
    Nesse contrato são contralados os treinamentos de um jogador. Finalizado o treinamento o dono do jogador (NFT) receberá uma quantidade de tokens.

- MarketplacePlayerV1.sol
    Nesse contrato será possível adquirir um NFT que representará um jogador. Ele manipulará os FTCs do requisitante,
    transferindo para o contrato Team.sol e, por fim, fará o mint do NFT, através do contrato Player.sol.

- Aidrop.sol
    Contrato que mintará FTCs para que os jogadores possam adquirir a ssua primeira box.
