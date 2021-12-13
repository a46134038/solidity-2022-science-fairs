// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


import "token/token.sol";


contract bank is token {


    uint a;


    constructor() {
        a = 15;


    }


    function print() public view returns(uint) {
        return a;
    }


}
