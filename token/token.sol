// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract token {


    struct TransferHistory{
        string transferType;
        address sender;
        address receiver;
        uint amount;
    }

    mapping (address => uint) balance;
    mapping (address => TransferHistory[]) transferHistory;

    function setBalance(address addr,uint amount) public { // 設定帳戶餘額
        balance[addr] = amount;
        transferHistory[addr].push(TransferHistory("setBalance",address(this),addr,amount));
    }

    function changeBalance(address addr,int amount) public { // 改變帳戶餘額
        int new_balance = int(balance[addr]) + amount;
        require(new_balance >= 0 ,"Your balance is not enough");
        balance[addr] = uint(new_balance);

        if(amount < 0) {
            transferHistory[addr].push(TransferHistory("deduction",address(0),addr,uint(-amount)));
        }else {
            transferHistory[addr].push(TransferHistory("induction",address(0),addr,uint(amount)));
        }
    }

    function transfer(address addr,uint160 amount) public { // 轉帳
        require(balance[msg.sender] >= amount,"Your balance is not enough");
        balance[msg.sender] -= amount;
        balance[addr] += amount;
        transferHistory[msg.sender].push(TransferHistory("transfer",msg.sender,addr,amount));
        transferHistory[addr].push(TransferHistory("transfer",msg.sender,addr,amount));
    }
  
    function showLastTransferHistory(uint amount) public view returns(TransferHistory[] memory) { // 查詢最後n筆交易

        if(amount > transferHistory[msg.sender].length) {
            amount = transferHistory[msg.sender].length;
        }

        TransferHistory[] memory data = new TransferHistory[](amount);
        for(uint i = amount ; i > 0 ; i--) {
            data[amount-i] = transferHistory[msg.sender][transferHistory[msg.sender].length-(amount-i+1)];
        }
        return data;
    }

    function showAllTransferHistory() public view returns(TransferHistory[] memory) { // 查詢所有交易
        return transferHistory[msg.sender];
    }


    function showBalance() public view returns(uint) { // 查詢帳戶餘額
        return balance[msg.sender];
    }

    function getContractAddress() public view returns(address) { // 獲取合約地址
        return address(this);
    }

}
