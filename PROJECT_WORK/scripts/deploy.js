async function deploy() {
    const HelperStaff = await ethers.getContractFactory("HelperStaff")
    const helperStaff = await HelperStaff.deploy()
    const WAIT_BLOCK_CONFIRMATIONS = 6;
    await helperStaff.deployed()
    console.log("Contract deployed to address:", helperStaff.address)
     await helperStaff.deployTransaction.wait(WAIT_BLOCK_CONFIRMATIONS);
    console.log(`Deployed contract to: ${helperStaff.address}`)
    console.log(`Verifying contract on Etherscan...`);

  await hre.run(`verify:verify`, {
    address: helperStaff.address,
    constructorArguments: [],
  });
}

deploy()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
