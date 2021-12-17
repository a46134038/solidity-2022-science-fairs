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

    function setBalance(address addr,uint amount) public {
        balance[addr] = amount;
        transferHistory[addr].push(TransferHistory(address(this),addr,amount));
    }

    function changeBalance(address addr,int amount) public {
        int new_balance = int(balance[addr]) + amount;
        require(new_balance >= 0 ,"Your balance is not enough");
        balance[addr] = uint(new_balance);
        transferHistory[addr].push(TransferHistory(address(this),addr,amount));
    }

    function transfer(address addr,uint160 amount) public {
        require(balance[msg.sender] >= amount,"Your balance is not enough");
        balance[msg.sender] -= amount;
        balance[addr] += amount;
        transferHistory[msg.sender].push(TransferHistory(msg.sender,addr,amount));
        transferHistory[addr].push(TransferHistory(msg.sender,addr,amount));
    }
  /*
    function showLastTransferHistory(uint amount) public view returns() {

    }*/

    function showAllTransferHistory() public view returns(TransferHistory[] memory) {
        return transferHistory[msg.sender];
    }


    function showBalance() public view returns(uint) {
        return balance[msg.sender];
    }

    function getContractAddress() public view returns(address) {
        return address(this);
    }

}
