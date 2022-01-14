// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Airdrop is Pausable, Ownable, ReentrancyGuard {
    address public admin;

    mapping(address => bool) public processedAirdrops;

    IERC20 public token;
    uint256 public currentAirdropAmount;
    uint256 public maxAirdropAmount = 1000000 * 10**18;

    event AirdropProcessed(address recipient, uint256 amount, uint256 date);

    constructor(address _token) ReentrancyGuard() {
        token = IERC20(_token);
    }

    function claimTokens(
        address recipient,
        uint256 amount,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external whenNotPaused nonReentrant {
        bytes32 payloadHash = keccak256(abi.encode(recipient, amount));

        bytes32 messageHash = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", payloadHash)
        );

        address actualSigner = ecrecover(messageHash, v, r, s);

        require(actualSigner == owner(), "Invalid Signature. Are you a bot?");
        require(
            processedAirdrops[recipient] == false,
            "You already claimed your tokens. Dont be greedy!"
        );
        require(
            currentAirdropAmount + amount <= maxAirdropAmount,
            "We are closed for Holidays! Airdrop Finished. :)"
        );
        processedAirdrops[recipient] = true;
        currentAirdropAmount += amount;
        token.transfer(recipient, amount);
        emit AirdropProcessed(recipient, amount, block.timestamp);
    }

    function pause() external onlyOwner {        
        _pause();
    }
    
}
