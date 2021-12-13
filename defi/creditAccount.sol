// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract creditAccount {

    mapping (address => int) equity;

    function lend(uint amount) public {

        equity[msg.sender] -= int(amount); 
    }

    function payDebt(uint amount) public {
        equity[msg.sender] += int(amount);
    }

    function showAccountEquity() public view returns(int) {
        return equity[msg.sender];
    }

}