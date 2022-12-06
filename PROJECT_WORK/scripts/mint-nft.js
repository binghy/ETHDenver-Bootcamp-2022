require('dotenv').config();
const { ethers } = require("hardhat");

const PUBLIC_KEY = process.env.PUBLIC_KEY;

const contract = require("../artifacts/contracts/HelperStaff.sol/HelperStaff.json");
const contractAddress = "0xFba49fE0fbBa1CE95af1B7C3b402d96E7517BF66";

async function mint() {
    const myNFT = await ethers.getContractAt(contract.abi, contractAddress);
    const tx = await myNFT.mintNFT(PUBLIC_KEY);
    const receipt = await tx.wait();
    console.log("The hash of the transaction: ", receipt.transactionHash);
}

mint()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });