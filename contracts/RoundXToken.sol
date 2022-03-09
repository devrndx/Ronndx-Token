pragma solidity ^0.5.0;

import "@klaytn/contracts/token/KIP7/KIP7Metadata.sol";
import "./BurnableToken.sol";
import "./MintableToken.sol";
import "./LockableToken.sol";

// ----------------------------------------------------------------------------
// @Project Round X
// ----------------------------------------------------------------------------
contract RoundXToken is BurnableToken, MintableToken, LockableToken, KIP7Metadata {
    constructor (string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) KIP7Metadata(name, symbol, decimals) public {
      mint(msg.sender, initialSupply);
    }
}
