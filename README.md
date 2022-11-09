# ETHDenver-Bootcamp-2022
8-week coding bootcamp to learn Solidity and blockchain from scratch


# Homework 1

***Discuss in your teams what a decentralised version of a game like monopoly would be like,
if there was no software on a central server. This is just a general discussion, there is no need to write any code or do any detailed
design.***

What are the essential pieces of functionality? 
....

How would people cheat?
....

How could you prevent them from cheating?
....


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

**- Compile the contract:** Done using 0.8.17 compiler version. Available in the folder "Homework_2".

**- Deploy the contract to the Remix VM environment:** Done. Artifacts uploaded in the folder "Homework_2".

# Homework 3

***Modify the contract "Bootcamp.sol" in order to:***

***1. Add a variable to hold the address of the deployer of the contract.***

***2. Update that variable with the deployer's address when the contract is deployed.***

***3. Write an external function to return:***  
  ***- Address 0x000000000000000000000000000000000000dEaD if called by the deployer***  
  ***- The deployer's address otherwise***  

Available in the folder "Homework_3".  

# Homework 4

**VolcanoCoin contract**  
At each point where you change your contract you should re deploy to the JavascriptVM and test your changes.

***1. In Remix, create a new file called VolcanoCoin.sol.***

***2. Define the pragma compiler version to ^0.8.0.***

***3. Before the pragma version, add a license identifer: // SPDX-License-Identifier: UNLICENSED.***

***4. Create a contract called VolcanoCoin.***

***5. Create a variable to hold the total supply of 10000.***

***6. Make a public function that returns the total supply.***

***7. Make a public function that can increase the total supply. Inside the function, add 1000 to the current total supply.***

***8. We probably want users to be aware of functions in the contract for greater transparency, but to make them all public will create some security risks (e.g. we    don't want users to be able to change the total supply). Declare an address variable called owner.***

***9. Next, create a modifier which only allows an owner to execute certain functions.***

***10. Make your change total supply function public , but add your modifier so that only the owner can execute it.***

***11. The contract owner's address should only be updateable in one place. Create a constructor and within the constructor, store the owner's address.***

***12. It would be useful to broadcast a change in the total supply. Create an event that emits the new value whenever the total supply changes. When the supply changes, emit this event.***

***13. In order to keep track of user balances, we need to associate a user's address with the balance that they have.  
a) What is the best data structure to hold this association?  
b) Using your choice of data structure, set up a variable called balances to keep track of the number of volcano coins that a user has.***

***14. We want to allow the balances variable to be read from the contract, there are 2 ways to do this. What are those ways? Use one of the ways to make your balances variable visible to users of the contract.***

***15. Now change the constructor, to give all of the total supply to the owner of the contract.***

***16. Now add a public function called transfer to allow a user to transfer their tokens to another address. This function should have 2 parameters:***  
   ***- the amount to transfer;***  
   ***- the recipient address.*** 
   ***Why do we not need the sender's address here?***  
   ***What would be the implication of having the sender's address as a parameter?***
       
***17. Add an event to the transfer function to indicate that a transfer has taken place, it should log the amount and the recipient address.***

***18. We want to keep a record for each user's transfers. Create a struct called Payment that stores the transfer amount and the recipient's address.***

***19. We want to have a payments array for each user sending the payment. Create a mapping which returns an array of Payment structs when given this user's address.***

Available in the folder "Homework_4". Added a .txt file "Test_flow.txt" to check the flow of execution and retrieved data.

# Homework 5

***1. Install a browser wallet such as Metamask***  
    *- Connect to the Goerli Test network*  
    *- Set up a wallet that will be used by your team for the team games*  
    *- If you need some test ETH, lets us know and we can send some to your team.*
   
***2. Update your Volcano coin contract to inherit from the Open Zeppelin "Ownable" contract, and use this to replace the owner functionality in your contract.***

Available in the folder "Homework_5".

# Homework 6

***Team Game***

# Homework 7

**Adding more functionality to the Volcano Coin contract**

***1. We made a payment mapping, but we haven’t added all the functionality for it yet. Write a function to view the payment records, specifying the user as an input.***  
***What is the difference between doing this and making the mapping public?***

**Mapping public**: Need to pass as argument to "transfers" mapping data type variable also the index of transaction. This implies to keep track in mind about how many transactions have been executed by a specific address.

**Writing a function to view payment records**: Create automatically a tuple of arrays for each transaction executed by a specific address, pushing into consequent transactions done by the same address. There is no more need to keep in mind how many transactions have been executed by a specific address.

***2. For the payments record mapping, create a function called recordPayment that takes as inputs:***  
  ***- the sender’s address;***  
  ***- the receiver’s address and;***  
  ***- the amount.***  
***Then creates a new payment record and adds the new record to the user’s payment record.***

***3. Each time we make a transfer of tokens, we should call the this recordPayment function to record the transfer.***

Available in the folder "Homework_7".

# Homework 8

**Using your choice of hardhat, foundry or truffle:**

***1. Create a project for your Volcano coin***  
***2. Write unit tests for your Volcano coin contract***

**The tests should show that:**

***1. The total supply is initially 10000***  
***2. That the total supply can be increased in 1000 token steps***  
***3. Only the owner of the contract can increase the supply***

Available in the folder "Homework_8".

# Homework 9

**Volcano NFT**  
We now want to create an NFT. We will use the Open Zeppelin libraries to help with this.

***1. Create a new project in the IDE of you choice called NFTProject***

***2. Create a VolcanoNFT contract. This should inherit from any ERC721 implementation from the Open Zeppelin standard libraries ([Link](https://docs.openzeppelin.com/contracts/2.x/erc721))***

***3. Give your NFT a name and a symbol.***

***4. Write unit tests to check that you can:***  
  ***- Mint new NFTs***  
  ***- Transfer an NFT***
  
***5. Deploy your contract to Goerli and send some NFTs to your colleagues.***

Available in the folder "Homework_9".  
Added .jpeg files to show:  
- contract deployment tx hash on Goerli  
- contract address overview  
- VolcanoNFT transactions

# Homework 10
