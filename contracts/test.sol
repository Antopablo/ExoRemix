// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract test {
    
    struct wallet {
        uint amount;
        uint numPayment;
    }

    mapping(address => wallet) Wallets;

    function getTotalBalanceOfContract() public view returns (uint) {
        return address(this).balance;
    }

    function getAmount() public view returns (uint)
    {
        return Wallets[msg.sender].amount;
    }

    function withdrawAllAmount(address payable _to) public {
        uint _mount = Wallets[msg.sender].amount;
        Wallets[msg.sender].amount = 0;

        _to.transfer(_mount);
    }

    receive() external payable {
        Wallets[msg.sender].amount += msg.value;
        Wallets[msg.sender].numPayment++;
    }

}