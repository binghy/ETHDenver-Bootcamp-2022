async function deploy() {
    const HelperStaff = await ethers.getContractFactory("HelperStaff")
    const helperStaff = await HelperStaff.deploy()
    console.log("Contract deployed to address:", helperStaff.address)
}

deploy()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })