// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";


contract VolcanoCoin is Ownable {

    // Variable to hold the token total supply
    uint private totalSupply = 10000;

    // Keep track of user balances
    mapping(address => uint) public balances;

    // Keep track of token transfers
    mapping(address => Payment[]) transfers;

    // Create a record to keep track of token transfers
    struct Payment {
        address recipient;
        uint amount;
    }

    // Events
    event SupplyChange(uint, uint);                                     // when totalSupply increased
    event TransferData(uint, address);                                  // when a transfer has occured

    // Not enough funds for transfer.
    // Requested "requested", but only "available" available.
    error NotEnoughFunds(uint requested, uint available);

    constructor(){
        balances[msg.sender] = totalSupply;
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
        balances[msg.sender] += 1000;                                   // to update owner total supply
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
        transfers[msg.sender].push(Payment(to,amount));                 // keep track of transfers updating Payment struct
        // Emit the event after the transfer
        emit TransferData(amount,to);
    }

    // Function to view transfer records
    function getTransfers(address from) public view returns (Payment[] memory){
        return transfers[from];
    }

}
