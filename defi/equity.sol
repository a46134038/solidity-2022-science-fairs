// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract equity {
    
    struct TransferHistory{
        string transferType;
        address sender;
        address receiver;
        uint amount;
    }
    
    mapping (address => uint) shares;
    mapping (address => TransferHistory[]) transferHistory;

    uint supply = 0;

    function equityTransfer(address addr,uint amount) public { // 股權過戶
        require(shares[msg.sender]>=amount,"Your shares is not enough");
        shares[msg.sender] -= amount;
        shares[addr] += amount;
        transferHistory[msg.sender].push(TransferHistory("Transfer",msg.sender,addr,amount));
        transferHistory[addr].push(TransferHistory("Transfer",msg.sender,addr,amount));
    }

    function equityMint(address addr,uint amount) public { // 股權鑄造
        shares[addr] += amount;
        supply += amount;
        transferHistory[addr].push(TransferHistory("Mint",address(0),addr,amount));
    }

    function equityDestory(address addr,uint amount) public { // 股權銷毀
        require(shares[addr]>=amount,"Your shares is not enough");
        shares[addr] -= amount;
        supply -= amount;
        transferHistory[addr].push(TransferHistory("Destory",address(0),addr,amount));
    }

    function equityShowLastTransferHistory(uint amount) public view returns(TransferHistory[] memory) { // 查詢最後n筆交易
        if(amount > transferHistory[msg.sender].length) {
            amount = transferHistory[msg.sender].length;
        }

        TransferHistory[] memory data = new TransferHistory[](amount);
        for(uint i = amount ; i > 0 ; i--) {
            data[amount-i] = transferHistory[msg.sender][transferHistory[msg.sender].length-(amount-i+1)];
        }
        return data;
    }

    function equityShowAllTransferHistory() public view returns(TransferHistory[] memory) { // 查詢所有交易
        return transferHistory[msg.sender];
    }


    function showEquity() public view returns(uint) { // 查詢持有股權
        return shares[msg.sender];
    }

    function equityShowTotalSupply() public view returns(uint) { // 查詢總流通股權
        return supply;
    }

}
