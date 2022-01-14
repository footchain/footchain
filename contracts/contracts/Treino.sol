// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Treino is Pausable {
    using SafeMath for uint256;

    modifier onlyOwner(uint256 playerId) {
        address owner = playerContract.ownerOf(playerId);
        require(msg.sender == owner);
        _;
    }

    struct PlayerTraining {
        uint256 playerId;
        address owner;
        bool working;
        uint256 beginTime;
        bool isExist;
    }

    mapping(uint256 => PlayerTraining) playersTraining;

    ERC20PresetMinterPauser public footchainCoin;
    IERC721 public playerContract;
    uint256 private THIRTY_MINUTES =  1 * 60;

    constructor(address footchain, address playerContractAddress) {
        playerContract = IERC721(playerContractAddress);
        footchainCoin = ERC20PresetMinterPauser(footchain);
    }

    function start(uint256 playerId) public onlyOwner(playerId) {
        if (playersTraining[playerId].isExist) {
            require(
                playersTraining[playerId].working == false,
                "ALREADY WORKING"
            );
            playersTraining[playerId].working = true;
            playersTraining[playerId].beginTime = block.timestamp;
        } else {
            playersTraining[playerId] = PlayerTraining(
                playerId,
                msg.sender,
                true,
                block.timestamp,
                true
            );
        }
    }

    function finish(uint256 playerId) public onlyOwner(playerId) {
        //verifica se esta em modo working
        require(playersTraining[playerId].working);
        uint256 elapsedTime = playersTraining[playerId].beginTime.add(
            THIRTY_MINUTES
        );
        require(elapsedTime < block.timestamp, "TRAINING NOT FINISHED");
        //verifica se a data de inicio é superior a 30 minutos
        playersTraining[playerId].working = false;
        footchainCoin.mint(msg.sender, 1 ether);

    }

    function getPlayerStatus(uint256 playerId) public view returns (bool) {
        return playersTraining[playerId].working;
    }
}
