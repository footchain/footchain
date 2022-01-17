// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract Team is AccessControl, ReentrancyGuard, Pausable {
     using SafeMath for uint256;
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MEMBER_ROLE = keccak256("MEMBER_ROLE");

    IERC20 public footchainToken;

    struct Dev {
        bool isActive;
        uint256 lastPayment;
        uint256 salary;
        uint dateAdmission;
    }

    mapping(address => Dev) members;

    event PayDay(address member, uint256 salary);
    event NewMember(address member, uint256 salary);
    event InactiveMember(address member);

    constructor(IERC20 token) ReentrancyGuard() {
        footchainToken = token;
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function addMember(address devAddress, uint256 salary) external onlyRole(ADMIN_ROLE) {
        require(members[devAddress].dateAdmission == 0, "Dev already onboarding");
        members[devAddress] = Dev({ isActive: true, lastPayment: 0, salary: salary, dateAdmission: block.timestamp });
        emit NewMember(devAddress, salary);
    }

    function inactiveMaintainer(address devAddress) external onlyRole(ADMIN_ROLE) {
        require(members[devAddress].isActive == true, "Dev not active");
        members[devAddress].isActive = false;
        emit InactiveMember(devAddress);
    }

    function widthdraw() external nonReentrant onlyRole(MEMBER_ROLE) {
        require(
            members[msg.sender].isActive == true,
            "You are not a active project maintainer"
        );
        uint256 balance = footchainToken.balanceOf(address(this));
        require(balance > 0, "No money! Sorry, you worked for free. ;)");
        require(
            balance >= members[msg.sender].salary,
            "Sorry, you are to much expansive."
        );

        uint256 thirtyDaysAgo = block.timestamp.sub(60 * 60 * 24 * 30);
        require(
            members[msg.sender].lastPayment < thirtyDaysAgo,
            "Hey! You need to work first."
        );
        members[msg.sender].lastPayment = block.timestamp;
        footchainToken.transfer(msg.sender, members[msg.sender].salary);
        emit PayDay(msg.sender, members[msg.sender].salary);
    }

    function pause() external onlyRole(ADMIN_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(ADMIN_ROLE) {
        _unpause();
    }
}
