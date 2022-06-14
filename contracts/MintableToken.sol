pragma solidity ^0.5.0;

import "@klaytn/contracts/token/KIP7/KIP7Mintable.sol";

import "./OwnableToken.sol";
// ----------------------------------------------------------------------------
// @title Mintable token
// @dev Simple KIP7 Token example, with mintable token creation
// Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
// ----------------------------------------------------------------------------
contract MintableToken is KIP7Mintable, OwnableToken{
    event MintFinished();

    bool public mintingFinished = false;

    modifier canMint() { require(!mintingFinished); _; }

    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool){
        return super.mint(_to, _amount);
    }

    function addMinter(address account) onlyOwner public {
        return
    }

    function renounceMinter() onlyOwner public {
        return;
    }

    function renounceMinter(address account) onlyOwner public {
         require (account != super.owner());
        _removeMinter(account);
    }

    function finishMinting() onlyOwner canMint public returns (bool) {
        mintingFinished = true;
        emit MintFinished();
        return true;
    }
}
