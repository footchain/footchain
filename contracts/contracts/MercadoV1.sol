// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "./Jogador.sol";

contract MercadoV1 is Ownable, Pausable {
    IERC20 public token;
    Jogador public nft;
    uint256 public nftPrice;
    address payable recipient;

    constructor(IERC20 token_, Jogador nft_, address payable recipient_, uint256 nftPrice_) {
        token = token_;
        nft = nft_;
        recipient = recipient_;
        nftPrice = nftPrice_;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function updateRecipient(address payable newRecipient) external onlyOwner {
        require(newRecipient != address(0));
        require(newRecipient != address(this));
        recipient = newRecipient;
    }

    function updateNftPrice(uint256 newNftPrice) external onlyOwner {
        require(newNftPrice > 0);
        nftPrice = newNftPrice;
    }

    function buyNFT() external {
        require(
            token.balanceOf(_msgSender()) >= nftPrice,
            "Insufficient token balance"
        );
        token.transferFrom(_msgSender(), recipient, nftPrice);
        nft.safeMint(_msgSender());
    }
}
