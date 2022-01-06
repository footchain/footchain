// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract FootChainCoin is ERC20PresetMinterPauser {
    constructor()
        ERC20PresetMinterPauser("Footchain Coin", "FCC")
    {
    }

    function addMintRole(address account) public {
        _setupRole(MINTER_ROLE, account);
    }
}
