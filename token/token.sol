// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract token {


    struct TransferHistory{
        address sender;
        address receiver;
        uint amount;
    }


    mapping (address => uint) balance;
    mapping (address => TransferHistory[]) transferHistory;


    function changeBalance(address addr,uint amount) public {
        balance[addr] = amount;
    }


    function transfer(address addr,uint160 amount) public {
        require(balance[msg.sender] >= amount,"Your balance is not enough");
        balance[msg.sender] -= amount;
        balance[addr] += amount;
        transferHistory[msg.sender].push(TransferHistory(msg.sender,addr,amount));
    }


  /*  function showLastTransferHistory(uint amount = 1) public view returns() {


    }
*/
    function showAllTransferHistory() public view returns(TransferHistory[]) {
        return transferHistory[msg.sender];
    }


    function showBalance() public view returns(uint) {
        return balance[msg.sender];
    }


}