// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Mantenedores is AccessControl, ReentrancyGuard {
     using SafeMath for uint256;
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MAINTAINER_ROLE = keccak256("MAINTAINER_ROLE");

    IERC20 public footchainToken;

    struct Dev {
        bool isActive;
        uint256 lastPayment;
        uint256 salary;
        uint dateAdmission;
    }

    mapping(address => Dev) maintainers;
    mapping(address => uint) adminVoting;

    event PayDay(address maintainer, uint256 salary);
    event NewMaintainer(address maintainer, uint256 salary);
    event InactiveMaintainer(address maintainer);

    constructor(IERC20 token) ReentrancyGuard() {
        footchainToken = token;
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function addMaintainer(address devAddress, uint256 salary) external onlyRole(ADMIN_ROLE) {
        require(maintainers[devAddress].dateAdmission == 0, "Dev already onboarding");
        maintainers[devAddress] = Dev({ isActive: true, lastPayment: 0, salary: salary, dateAdmission: block.timestamp });
        emit NewMaintainer(devAddress, salary);
    }

    function inactiveMaintainer(address devAddress) external onlyRole(ADMIN_ROLE) {
        require(maintainers[devAddress].isActive == true, "Dev not active");
        maintainers[devAddress].isActive = false;
        emit InactiveMaintainer(devAddress);
    }

    function widthdraw() external nonReentrant {
        require(
            maintainers[msg.sender].isActive == true,
            "You are not a active project maintainer"
        );
        uint256 balance = footchainToken.balanceOf(address(this));
        require(balance > 0, "No money! Sorry, you worked for free. ;)");
        require(
            balance >= maintainers[msg.sender].salary,
            "Sorry, you are to much expansive."
        );

        uint256 thirtyDaysAgo = block.timestamp.sub(60 * 60 * 24 * 30);
        require(
            maintainers[msg.sender].lastPayment < thirtyDaysAgo,
            "Hey! You need to work first."
        );
        maintainers[msg.sender].lastPayment = block.timestamp;
        footchainToken.transfer(msg.sender, maintainers[msg.sender].salary);
        emit PayDay(msg.sender, maintainers[msg.sender].salary);
    }

}
