const run = require("hardhat");
const hre = require("hardhat");
async function deploy() {
    const PersonInNeed = await ethers.getContractFactory("PersonInNeed")
    const PersonInNeedContact = await PersonInNeed.deploy()
    const WAIT_BLOCK_CONFIRMATIONS = 6;
    await PersonInNeedContact.deployed()
    console.log("Contract deployed to address:", PersonInNeedContact.address)
     await PersonInNeedContact.deployTransaction.wait(WAIT_BLOCK_CONFIRMATIONS);
    console.log(`Deployed contract to: ${PersonInNeedContact.address}`)
    console.log(`Verifying contract on Etherscan...`);

  await hre.run(`verify:verify`, {
    address: PersonInNeedContact.address,
    constructorArguments: [],
  });
}

deploy()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
