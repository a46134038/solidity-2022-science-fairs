// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract equity {
    mapping (address => uint) shares;

    uint supply = 0;

    function equityTransfer(address addr,uint amount) {
        
    }

    function equityMint(address addr,uint amount) public {
        shares[addr] += amount;
        supply += amount;
    }

    function showEquity() public view returns(uint) {
        return shares[msg.sender];
    }

    function equityShowTotalSupply() public view returns(uint) {
        return supply;
    }

}
