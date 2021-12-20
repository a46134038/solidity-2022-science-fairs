// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract creditAccount {
    
    struct StakePool {
        uint poolLendTotal;
        uint poolStakeTotal;
    }

    struct Liability {
        uint balance;
        uint lendTotal;
        uint stakeTotal;
        uint interestRevenue;
        uint interestExpense;
    }
    
    mapping (address => Liability) liability; 

    StakePool stakePool;

    function stake(uint amount) public { // 存入現金賺取利息
        require(liability[msg.sender].balance >= amount,"Your balance is not enough");
        liability[msg.sender].stakeTotal += amount;
        stakePool.poolStakeTotal += amount;
    }

    function redeem(uint amount) public { // 取消存款
        require(liability[msg.sender].stakeTotal >= amount,"Your deposit balance is not enough");
        liability[msg.sender].stakeTotal -= amount;
        stakePool.poolStakeTotal -= amount;
        liability[msg.sender].balance += (amount + liability[msg.sender].interestRevenue);
        liability[msg.sender].interestRevenue = 0;
    }

    function lend(uint amount) public { // 借款
        require(stakePool.poolStakeTotal >= amount,"Stake pool balance is not enough");
        liability[msg.sender].lendTotal += amount;
        stakePool.poolLendTotal += amount;
    }

    function payDebt(uint amount) public { // 還款
        require(liability[msg.sender].lendTotal >= amount,"Your repayment amount is more then lend amount");
        require(liability[msg.sender].balance >= amount,"Your balance is not enough");
        liability[msg.sender].lendTotal -= amount;
        stakePool.poolLendTotal -= amount;
        liability[msg.sender].balance -= (amount + liability[msg.sender].interestExpense);
        liability[msg.sender].interestExpense = 0;
    }

    function showAccountDebtTotal() public view returns(uint) { // 顯示帳戶負債
        return liability[msg.sender].lendTotal;
    }

    function showAccountStakeTotal() public view returns(uint) { // 顯示帳戶存款
        return liability[msg.sender].stakeTotal;
    }

    function getPoolStakeTotal() public view returns(uint) { // 獲取質押池總存款量
        return stakePool.poolStakeTotal;
    }

    function getPoolLendTotal() public view returns(uint) { // 獲取質押池總借款量
        return stakePool.poolLendTotal;
  
    }

    function getInterestRate() public view returns(uint) { // 獲取當前質押池利率
        return 300*stakePool.poolLendTotal / stakePool.poolStakeTotal; // 因 solidity 無浮點數 為保證計算的精準性所以出來的值為萬分比 須乘以 0.01% 才為百分比
    }

}
