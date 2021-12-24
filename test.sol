// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract test{
    uint a;
    uint timeInterval = 86400; // 配息時間 單位是秒
    uint lastTimeStamp; // 上個維護的時間
    constructor(){
        lastTimeStamp = block.timestamp;
    }

    function Counter() public view returns(uint) {
        return a;
    }

    function checkUpkeep(bytes calldata checkData) public view returns(bool, bytes memory) {
        return (block.timestamp - lastTimeStamp >= timeInterval , bytes(""));
    }

    function performUpkeep(bytes calldata performData) public {
        lastTimeStamp = block.timestamp;
        a++;
    }

}
