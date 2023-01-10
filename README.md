# Single Reentrancy Attack On Vulnerable Wallet

A single reentrancy attack occurs when a contract makes a transfer funds call to a malicious contract, whose fallback function recursively calls the transfer funds function until all the funds from the first contract are drained. This is enabled when the updating of funds occurs only after the funds are transferred. The steps are as follows:
1. The attacker requests to withdraw funds.
2. The contract verifies that the attacker has a sufficient balance to withdraw, so funds are transferred. 
3. The attacker's fallback function recursively calls the transfer function
4. Since the attacker's balance has not been updated, the contract believes the attacker has a sufficient balance, so funds are transferred.
5. Repeat steps 3 and 4 until the contract is drained of its funds.

It is important that the attacker's recursion stops before the contract is completely drained, since any contract out there will revert if a money transfer is unsuccessful, cancelling the entire attack.
In this project, the attacker stops at a recursion depth of 3. 
