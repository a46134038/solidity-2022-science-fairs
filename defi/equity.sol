// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract equity {
    
    struct Proposal {
        uint proposalNumber;
        string proposalName;
        string proposalInfo;
        uint disagreeCount;
        uint agreeCount;
        uint proposalTime;
        uint proposalDeadline;
    }

    struct ProposeHistory {
        Proposal proposal;
    }

    struct EquityTransferHistory {
        string transferType;
        address sender;
        address receiver;
        uint amount;
    }

    mapping (address => uint) shares;
    mapping (address => uint) shareHolderToIndex;
    mapping (address => uint) lastProposeTimeStamp;
    mapping (address => EquityTransferHistory[]) private transferHistory;

    uint supply = 0;
    address shareHolderList[];
    Proposal[] proposal;

    function equityTransfer(address addr,uint amount) public { // 股權過戶
        require(shares[msg.sender]>=amount,"Your shares is not enough");
        shares[msg.sender] -= amount;
        shares[addr] += amount;
        transferHistory[msg.sender].push(EquityTransferHistory("Transfer",msg.sender,addr,amount));
        transferHistory[addr].push(EquityTransferHistory("Transfer",msg.sender,addr,amount));

        if(shares[msg.sender] == 0 && shareHolderToIndex[addr] > 0) {
            shareHolderList.
        }
        if(shares[addr] > 0 && shareHolderToIndex[addr] == 0) {
            shareHolderList.push(addr);
            shareHolderToIndex[addr] = shareHolderList.length - 1;
        }
    }

    function equityMint(address addr,uint amount) public { // 股權鑄造
        shares[addr] += amount;
        supply += amount;
        shareHolderList.push(addr);
        transferHistory[addr].push(EquityTransferHistory("Mint",address(0),addr,amount));
    }

    function equityDestory(address addr,uint amount) public { // 股權銷毀
        require(shares[addr]>=amount,"Your shares is not enough");
        shares[addr] -= amount;
        supply -= amount;
        transferHistory[addr].push(EquityTransferHistory("Destory",address(0),addr,amount));
    }

    function propose(string memory proposalName,string memory proposalInfo) public {
        require(block.timestamp - lastProposeTimeStamp[msg.sender] > 86400*7,"You have already proposed , Please wait for 7 days to propose again");
        proposal.push(Proposal(proposal.length,proposalName,proposalInfo,0,0,block.timestamp,block.timestamp-(block.timestamp%86400)+(86400*30)));
        lastProposeTimeStamp[msg.sender] = block.timestamp;
    }

    


    function vote(uint proposalNumber,uint8 choose) public {
        if() {

        }
        
        shares[msg.sender];
    }

    function payDividends() internal {
        uint dividendsTotal = token.balance[address(this)]*payoutRatio;
        token.balance[address(this)] -= dividendsTotal;
        for() {

        }
    }

    function showAllProposal() public view returns(Proposal[] memory) {
        return proposal;
    }

    function showAllActiveProposal() view public returns(Proposal[] memory) {

        uint amount = proposal.length;
        uint activeProposalCount = 0;

        for(uint i=0;i<amount;i++) {
            if(proposal[i].proposalDeadline > block.timestamp) {
                activeProposalCount++;
            }
        }

        Proposal[] memory data = new Proposal[](activeProposalCount);
        for(uint i=0;i<amount;i++) {
            if(proposal[i].proposalDeadline > block.timestamp) {
                data[--activeProposalCount] = proposal[i];
            }
        }
        return data;
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
