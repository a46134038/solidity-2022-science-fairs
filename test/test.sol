// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;



import "defi/creditAccount.sol";

contract bank is creditAccount {

    uint count;
    uint timeInterval = 86400; // 定期維護(股息、利息、清算....)時間 單位是秒
    uint lastTimeStamp; // 上個維護的時間

    constructor(){
        lastTimeStamp = block.timestamp;
    }

    function checkUpkeep(bytes calldata checkData) public view returns(bool, bytes memory) {
        if(block.timestamp - lastTimeStamp >= timeInterval) {

        }
        return (block.timestamp - lastTimeStamp >= timeInterval , bytes(""));
    }

    function performUpkeep(bytes calldata performData) public {
        lastTimeStamp = block.timestamp;
        count++;
    }

    function time() public view returns(bool,bytes memory) {
        return ((block.timestamp - timeInterval > lastTimeStamp) || (block.timestamp % 86400 < 120) , bytes(""));
    }

    function counter() public view returns(uint) {
        return count;
    }

}
