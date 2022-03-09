pragma solidity ^0.5.0;

import "@klaytn/contracts/token/KIP7/KIP7Pausable.sol";

import "./OwnableToken.sol";

// ----------------------------------------------------------------------------
// @title Pausable token
// @dev StandardToken modified with pausable transfers.
// ----------------------------------------------------------------------------
contract PausableToken is KIP7Pausable, OwnableToken {
    function transfer(address _to, uint256 _value) public whenNotPaused returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public whenNotPaused returns (bool) {
        return super.approve(_spender, _value);
    }

    function addPauser(address account) public onlyOwner{
      super.addPauser(account);
    }

    function renouncePauser() onlyOwner public {
        return;
    }

    function renouncePauser(address account) onlyOwner public {
         require (account != super.owner());
        _removePauser(account);
    }
}

// ----------------------------------------------------------------------------
// @title Lockable token
// @dev StandardToken modified with pausable transfers.
// ----------------------------------------------------------------------------
contract LockableToken is PausableToken {
    event Lock(address indexed LockedAddress);
    event Unlock(address indexed UnLockedAddress);

    mapping( address => bool ) public lockedList;

    modifier isLocked { require(lockedList[msg.sender] != true); _; }

    function SetLockAddress(address _lockAddress) public onlyOwnerOrOperator returns (bool) {
        require(_lockAddress != address(0));
        require(_lockAddress != super.owner());
        require(lockedList[_lockAddress] != true);
        
        lockedList[_lockAddress] = true;
        
        emit Lock(_lockAddress);

        return true;
    }

    function UnLockAddress(address _unlockAddress) public onlyOwner returns (bool) {
        require(lockedList[_unlockAddress] != false);
        
        lockedList[_unlockAddress] = false;
        
        emit Unlock(_unlockAddress);

        return true;
    }

    function transfer(address _to, uint256 _value) public isLocked returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public isLocked returns (bool) {
        require(lockedList[_from] != true);
        require(lockedList[_to] != true);

        return super.transferFrom(_from, _to, _value);
    }
}
