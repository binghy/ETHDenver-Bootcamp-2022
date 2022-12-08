const run = require("hardhat");
const hre = require("hardhat");
async function deploy() {
    const FamilyAssets = await ethers.getContractFactory("FamilyAsset")
    const familyAssetsContact = await FamilyAssets.deploy()
    const WAIT_BLOCK_CONFIRMATIONS = 6;
    await familyAssetsContact.deployed()
    console.log("Contract deployed to address:", familyAssetsContact.address)
     await familyAssetsContact.deployTransaction.wait(WAIT_BLOCK_CONFIRMATIONS);
    console.log(`Deployed contract to: ${familyAssetsContact.address}`)
    console.log(`Verifying contract on Etherscan...`);

  await hre.run(`verify:verify`, {
    address: familyAssetsContact.address,
    constructorArguments: [],
  });
}

deploy()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
