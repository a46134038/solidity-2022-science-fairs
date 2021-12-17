// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract creditAccount {

    mapping (address => int) liability;

    function lend(uint amount) public {

        liability[msg.sender] -= int(amount); 
    }

    function payDebt(uint amount) public {
        liability[msg.sender] += int(amount);
    }

    function showAccountEquity() public view returns(int) {
        return equity[msg.sender];
    }

}
