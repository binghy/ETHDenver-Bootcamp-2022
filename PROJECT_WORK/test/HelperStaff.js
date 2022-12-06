const {expect} = require("chai");
const {ethers} = require("hardhat");

describe("Mint NFT Contract", function () {
    let HelperStaff;
    let helperStaff;
    let owner;

    beforeEach(async function () {
        HelperStaff = await ethers.getContractFactory("HelperStaff");
        [owner, addrs1, addrs2] = await ethers.getSigners();
        helperStaff = await HelperStaff.deploy();
    })

    describe("Deployment", function () {
        it("Should have the correct owner", async function () {
            expect(await helperStaff.owner()).to.equal(owner.address);
        })

        it("Should have the correct balance after minting", async function () {
            const initialBalance = await helperStaff.balanceOf(owner.address)
            expect(initialBalance.toString()).to.equal("0");

            await helperStaff.mintNFT(owner.address);

            const finalBalance = await helperStaff.balanceOf(owner.address)
            expect(finalBalance.toString()).to.equal("1");
        })
    })
})