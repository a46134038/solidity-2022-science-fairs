// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract creditAccount {

    mapping (address => int) liability;
    
    uint stakePool;

    function lend(uint amount) public {
        liability[msg.sender] -= int(amount); 
        stakePool -= amount;
    }

    function payDebt(uint amount) public {
        liability[msg.sender] += int(amount);
        stakePool += amount;
    }

    function showAccountEquity() public view returns(int) {
        return liability[msg.sender];
    }

    function getPoolSize() public view returns(uint) {
        return stakePool;
    }

    function getInterestRate() public view returns(uint) {
        
    }

}
