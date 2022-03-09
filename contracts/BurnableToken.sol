pragma solidity ^0.5.0;

import "@klaytn/contracts/token/KIP7/KIP7Burnable.sol";

import "./OwnableToken.sol";

// ----------------------------------------------------------------------------
// @title Burnable Token
// @dev Token that can be irreversibly burned (destroyed).
// ----------------------------------------------------------------------------
contract BurnableToken is KIP7Burnable, OwnableToken {
    function burn(uint256 amount) onlyOwner public {
        require(amount <= balanceOf(msg.sender));
        super.burn(amount);
    }

    function burnFrom(address account, uint256 amount) onlyOwner public {
        require(amount <= balanceOf(account));
        require(account != super.owner());
        super.burnFrom(account, amount);
    }
}
