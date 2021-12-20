// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract creditAccount {
    
    struct StakePool {
        uint poolLendTotal;
        uint poolStakeTotal;
    }
    
    mapping (address => int) liability;

    StakePool stakePool;

    function stake(uint amount) public { // 存入現金賺取利息
        liability[msg.sender] += int(amount);
        stakePool.poolStakeTotal += amount;
    }

    function redeem(uint amount) public { // 取消存款
        liability[msg.sender] -= int(amount);
        stakePool.poolStakeTotal -= amount;
    }

    function lend(uint amount) public { // 借款
        liability[msg.sender] -= int(amount); 
        stakePool.poolLendTotal += amount;
    }

    function payDebt(uint amount) public { // 還款
        liability[msg.sender] += int(amount);
        stakePool.poolLendTotal -= amount;
    }

    function showAccountEquity() public view returns(int) { // 顯示帳戶權益
        return liability[msg.sender];
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
