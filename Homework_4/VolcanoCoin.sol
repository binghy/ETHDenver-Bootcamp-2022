// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;


contract VolcanoCoin {

    // Variable to hold the address of the contract's deployer          // point n.8
    address private owner;

    // Variable to hold the token total supply                          // point n.5
    uint private totalSupply = 10000;

    // Keep track of user balances
    mapping(address => uint) public balances;                           // point n.13 - n.14

    // Keep track of token transfers
    mapping(address => Payment[]) transfers;                            // point n.19

    // Create a record to keep track of token transfers
    struct Payment {                                                    // point n.18
        address recipient;
        uint amount;
    }

    // Events
    event SupplyChange(uint, uint);                                     // when totalSupply increased
    event TransferData(uint, address);                                  // when a transfer has occured

    // Not enough funds for transfer.
    // Requested "requested", but only "available" available.
    error NotEnoughFunds(uint requested, uint available);

    // Initialization
    constructor() {
        owner = msg.sender;                                             // point n.11
        balances[owner] = totalSupply;                                  // point n.15
    }

    // Restrict some functions to be called only by the owner
    modifier onlyOwner {                                                // point n.9
        if (msg.sender == owner) {
            _;
        }
    }

    // Function to return the total supply                              // point n.6
    function getSupply() public view returns(uint) {
        return totalSupply;
    }

    // Function to increase the total supply.                           // point n.7 - n.10
    // Inside the function, add 1000 to the current total supply.
    // Function callable only by the owner.
    function setSupply() public onlyOwner {
        uint previousTotalSupply = totalSupply;
        totalSupply += 1000;                                            // added tokens = 1000
        balances[owner] = totalSupply;                                  // to update owner total supply (point n.15)
        // Emit event for new total supply
        if (totalSupply != previousTotalSupply) {
            emit SupplyChange(previousTotalSupply,totalSupply);         // point n.12
        }
    }

    // Function to transfer tokens                                      // point n.16
    function transfer(address to, uint amount) public {
        uint balance = balances[msg.sender];
        if (balance < amount)                                           // check token availability of current sender
            revert NotEnoughFunds(amount,balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        transfers[msg.sender].push(Payment(to,amount));                 // keep track of transfers updating Payment struct
        // Emit the event after the transfer
        emit TransferData(amount,to);                                   // point n.17
    }

    // Function to view transfer records
    function getTransfers(address from) public view returns (Payment[] memory){
        return transfers[from];
    }

}
