
# Homework 2

***1. Using a blockchain explorer, have a look at the following transactions, what do they do?***

**- 0x0ec3f2488a93839524add10ea229e773f6bc891b4eb4794c3337d4495263790b:**  
   Transactions from 0x969837498944ae1dc0dcac2d0c65634c88729b2d to contract 0xc0ee9db1a9e07ca63e4ff0d5fb6f86bf68d47b89 (the DAO token transferred to the DarkDAO).
   This corresponds to the beginning of the DAO hack of 17th Jun 2016, when The DAO has been attacked using the split function, and that caused the fork of Ethereum.
   
**- 0x4fc1580e7f66c58b7c26881cce0aab9c3509afe6e507527f30566fbf8039bcd0:**  
   Deployment of Uniswap's V2 smart contract

**- 0x552bc0322d78c5648c5efa21d2daa2d0f14901ad4b15531f1ab5bbe5674de34f:**  
   PolyNetwork exploiting on 10/08/2021 ([Link](https://twitter.com/PolyNetwork2/status/1425073987164381196)). Sent 0 ETH from/to the same address.  
   Hacker address on ETH: 0xc8a65fadf0e0ddaf421f28feab69bf6e2e589963  
   Hacker message:  
   IT WOULD HAVE BEEN A BILLION HACK IF I HAD MOVED REMAINING SHITCOINS! DID I JUST SAVE THE PROJECT? NOT SO INTERESTED IN MONEY, NOW CONSIDERING RETURNING SOME TOKENS    OR JUST LEAVING THEM HERE
                   
**- 0x7a026bf79b36580bf7ef174711a3de823ff3c93c65304c3acc0323c77d62d0ed:**  
   refund of $97,039,004 from previous hacker towards the smart contract with address: 0x6B175474E89094C44Da98b954EedeAC495271d0F interacting with contract with address: 0x6b175474e89094c44da98b954eedeac495271d0f
   
**- 0x814e6a21c8eb34b62a05c1d0b14ee932873c62ef3c8575dc49bcf12004714eda:**  
   PolyNetwork exploit. Transaction from 0x583e25de879e90cf5fc637f8dc16db8f10d91c17 to PolyNetwork Exploiter 2. Amount: 160 Ether


***2. What is the largest account balance you can find?***

account address: 0x00000000219ab540356cBB839Cbe05303d7705Fa  
This corresponds to the Beacon Deposit Contract. Balance: 14,373,623.00771856 Ether
 
***3. What is special about these accounts:***

**- 0x1db3439a222c519ab44bb1144fc28167b4fa6ee6:**  
   Beacon Depositor. An address that has deposited ETH into the Beacon Chain to become a validator.
   
**- 0x000000000000000000000000000000000000dEaD:**  
   Null Address. This address is commonly used by projects to burn tokens (reducing total supply).
   Tokens are commonly considered burned after sending to an address whose private keys are impossible (or extremely improbable) for anyone to have access to.
   Another recommended method is to create a contract which immediately self destructs and sends to its own address.
 
***4. Using remix add the contract "Bootcamp.sol" as a source file***

**- Compile the contract:** Done using 0.8.17 compiler version.

**- Deploy the contract to the Remix VM environment:** Done. Artifacts uploaded in the folder "artifacts".
