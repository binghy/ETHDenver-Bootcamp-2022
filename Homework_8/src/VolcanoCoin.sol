// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract VolcanoCoin {

    // Variable to hold the address of the contract's deployer
    address private owner;

    // Variable to hold the token total supply
    uint private totalSupply = 10000;

    // Keep track of user balances
    mapping(address => uint) public balances;

    // Create a record to keep track of token transfers
    struct Payment {
        address recipient;
        uint amount;
    }

    // Keep track of token transfers
    mapping(address => Payment[]) transfers;

    // Events
    event SupplyChange(uint, uint);                                     // when totalSupply increased
    event TransferData(uint, address);                                  // when a transfer has occured

    // Not enough funds for transfer.
    // Requested "requested", but only "available" available.
    error NotEnoughFunds(uint requested, uint available);

    // Initialization
    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    // Restrict some functions to be called only by the owner
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    // Function to return the total supply
    function getSupply() public view returns(uint) {
        return totalSupply;
    }

    // Function to increase the total supply.
    // Inside the function, add 1000 to the current total supply.
    // Function callable only by the owner.
    function setSupply() public onlyOwner {
        uint previousTotalSupply = totalSupply;
        totalSupply += 1000;                                            // added tokens = 1000
        balances[owner] = totalSupply;                                  // to update owner total supply
        // Emit event for new total supply
        if (totalSupply != previousTotalSupply) {
            emit SupplyChange(previousTotalSupply,totalSupply);
        }
    }

    // Function to transfer tokens
    function transfer(address to, uint amount) public {
        uint balance = balances[msg.sender];
        if (balance < amount)                                           // check token availability of current sender
            revert NotEnoughFunds(amount,balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        recordPayment(msg.sender,to,amount);                            // record token transfer
        // Emit the event after the transfer
        emit TransferData(amount,to);
    }

    // Function to view transfer records
    function getTransfers(address from) public view returns (Payment[] memory) {
        return transfers[from];
    }

    function recordPayment(address from, address to, uint amt) private {
        transfers[from].push(Payment(to,amt));                          // keep track of transfers updating Payment struct
    }

}
