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
