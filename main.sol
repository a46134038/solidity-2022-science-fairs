// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


import "token/token.sol";
import "defi/creditAccount.sol";
import "defi/equity.sol";

contract bank is token,creditAccount,equity {

    uint count;
    uint timeInterval = 86400; // 定期維護(股息、利息、清算....)時間 單位是秒
    uint lastTimeStamp; // 上個維護的時間

    constructor(){
        lastTimeStamp = block.timestamp;
    }

    function transferToCreditAccount(uint amount) public {
        require(balance[msg.sender] >= amount,"Your balance is not enough");
        balance[msg.sender] -= amount;
        creditAccount.liability[msg.sender].balance += amount;
    }

    function transferToGeneralAccount(uint amount) public {
        require(creditAccount.liability[msg.sender].balance >= amount,"Your balance is not enough");
        creditAccount.liability[msg.sender].balance -= amount;
        balance[msg.sender] += amount;
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
