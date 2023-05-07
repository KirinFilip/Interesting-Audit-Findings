// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/// This contract is for demonstration purposes only !

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract RevertOnZeroToken is ERC20 {
    constructor(uint256 _totalSupply) ERC20("RevertOnZero", "ROZ") {
        _mint(msg.sender, _totalSupply);
    }

    function transfer(address _to, uint256 _amount) public override returns (bool) {
        require(balanceOf(_to) + _amount > balanceOf(_to), "Zero Value Transfer");
        // simplified: require(_amount != 0, "Zero Value Transfer");
        return super.transferFrom(msg.sender, _to, _amount);
    }
}
