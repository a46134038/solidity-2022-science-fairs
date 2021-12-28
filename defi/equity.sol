// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract equity {
    
    struct EquityTransferHistory {
        string transferType;
        address sender;
        address receiver;
        uint amount;
    }
    
    mapping (address => uint) shares;
    mapping (address => EquityTransferHistory[]) private transferHistory;

    uint supply = 0;

    function equityTransfer(address addr,uint amount) public { // 股權過戶
        require(shares[msg.sender]>=amount,"Your shares is not enough");
        shares[msg.sender] -= amount;
        shares[addr] += amount;
        transferHistory[msg.sender].push(EquityTransferHistory("Transfer",msg.sender,addr,amount));
        transferHistory[addr].push(EquityTransferHistory("Transfer",msg.sender,addr,amount));
    }

    function equityMint(address addr,uint amount) public { // 股權鑄造
        shares[addr] += amount;
        supply += amount;a
        transferHistory[addr].push(EquityTransferHistory("Mint",address(0),addr,amount));
    }

    function equityDestory(address addr,uint amount) public { // 股權銷毀
        require(shares[addr]>=amount,"Your shares is not enough");
        shares[addr] -= amount;
        supply -= amount;
        transferHistory[addr].push(EquityTransferHistory("Destory",address(0),addr,amount));
    }

    function equityShowLastTransferHistory(uint amount) public view returns(EquityTransferHistory[] memory) { // 查詢最後n筆交易
        if(amount > transferHistory[msg.sender].length) {
            amount = transferHistory[msg.sender].length;
        }

        EquityTransferHistory[] memory data = new EquityTransferHistory[](amount);
        for(uint i = amount ; i > 0 ; i--) {
            data[amount-i] = transferHistory[msg.sender][transferHistory[msg.sender].length-(amount-i+1)];
        }
        return data;
    }

    function equityShowAllTransferHistory() public view returns(EquityTransferHistory[] memory) { // 查詢所有交易
        return transferHistory[msg.sender];
    }


    function showEquity() public view returns(uint) { // 查詢持有股權
        return shares[msg.sender];
    }

    function equityShowTotalSupply() public view returns(uint) { // 查詢總流通股權
        return supply;
    }

}
