// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;

    // Add a variable to hold the address of the deployer of the contract
    address owner;

    // Update that variable with the deployer's address when the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    // Fuction to store a value
    function store(uint256 num) public {
        number = num;
    }

    // Fuction to read the value
    function retrieve() public view returns (uint256){
        return number;
    }

    // Write an external function to return
    // 1. Address 0x000000000000000000000000000000000000dEaD if called by the deployer
    // 2. The deployer's address otherwise
    function retAddr() external view returns (address) {
        address addr = 0x000000000000000000000000000000000000dEaD;
        if (msg.sender == owner) {
            return addr;
        }
        else {
            return owner;
        }
    }
}
