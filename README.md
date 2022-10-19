# ETHDenver-Bootcamp-2022
8-week coding bootcamp to learn Solidity and blockchain from scratch


# Homework 1

Discuss in your teams what a decentralised version of a game like monopoly would be like,
if there was no software on a central server. This is just a general discussion, there is no need to write any code or do any detailed
design.

What are the essential pieces of functionality? 
....

How would people cheat?
....

How could you prevent them from cheating?
....


# Homework 2

Using a blockchain explorer, have a look at the following transactions, what do they do?
1. 0x0ec3f2488a93839524add10ea229e773f6bc891b4eb4794c3337d4495263790b: invalid string
2. 0x4fc1580e7f66c58b7c26881cce0aab9c3509afe6e507527f30566fbf8039bcd0: Deployment of Uniswap's smart contract
3. 0x552bc0322d78c5648c5efa21d2daa2d0f14901ad4b15531f1ab5bbe5674de34f: PolyNetwork exploiting on 10/08/2021. Sent 0 ETH from/to the same address.
   Hacker addresson ETH: 0xc8a65fadf0e0ddaf421f28feab69bf6e2e589963
   (source: https://twitter.com/PolyNetwork2/status/1425073987164381196)
4. 0x7a026bf79b36580bf7ef174711a3de823ff3c93c65304c3acc0323c77d62d0ed: transaction of $97,039,004 from previous hacker towards
   the smart contract with address: 0x6b175474e89094c44da98b954eedeac495271d0f
5. 0x814e6a21c8eb34b62a05c1d0b14ee932873c62ef3c8575dc49bcf12004714ed: invalid string

What is the largest account balance you can find?
account address: 0x00000000219ab540356cBB839Cbe05303d7705Fa. This corresponds to the Beacon Deposit Contract.
 
What is special about these accounts:
1. 0x1db3439a222c519ab44bb1144fc28167b4fa6ee6: Beacon Depositor
2. 0x000000000000000000000000000000000000dEaD: Null Address. This address is commonly used by projects to burn tokens (reducing total supply)
 
Using remix add the contract "Bootcamp.sol" as a source file
Compile the contract: Done using 0.8.17 compiler version
Deploy the contract to the Remix VM environment: Done

