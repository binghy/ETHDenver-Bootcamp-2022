require("@nomicfoundation/hardhat-chai-matchers")
const {expect, assert} = require("chai");
const {ethers} = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
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
      //Test that the contract is properly deployed and has the correct name and symbol
        it("Should have the correct owner", async function () {
            expect(await helperStaff.owner()).to.equal(owner.address);
        });

        it('should have the correct name', async () => {
          const name = await helperStaff.name();
          assert.equal(name, "PersonInNeed", "The contract should have the correct name");
        });

        it('should have the correct symbol', async () => {
          const symbol = await helperStaff.symbol();
          assert.equal(symbol, "PIN", "The contract should have the correct symbol");
        });

      //Test that the mintNFT function correctly mints a NFT for a given beneficiary address
      it('should mint a NFT for the given beneficiary address', async () => {
        const tokenId = await helperStaff.mintNFT(addrs2.address);
        assert.notEqual(Number(tokenId), 0, "The function should mint a NFT with a non-zero token ID");
      });
    
      it('should not allow minting a NFT for the same beneficiary address twice', async () => {
            expect(await helperStaff.mintNFT(addrs2.address)).to.be.reverted
            
      });


        it("Should have the correct balance after minting", async function () {
            const initialBalance = await helperStaff.balanceOf(owner.address)
            expect(initialBalance.toString()).to.equal("0");

            await helperStaff.mintNFT(owner.address);

            const finalBalance = await helperStaff.balanceOf(owner.address)
            expect(finalBalance.toString()).to.equal("1");
        });
      
        // Define a test to verify that the mintNFT() method works as expected
it("should mint a new NFT", async () => {
  // Mint a new NFT
  await helperStaff.mintNFT(addrs2.address);
  const tokenId = await helperStaff.tokenId();
  console.log(tokenId)
  // Verify that the token ID is not null
  expect(Number(tokenId)).to.not.be.null;
  
  // Verify that the token URI is correct
  const tokenURI = await helperStaff.tokenURI(tokenId);
  console.log(tokenURI)
  expect(tokenURI).to.equal(
    `https://ipfs.io/ipfs/QmY5RhCzoQ8v6eUsXr7EiJDDayWUbs4cd9t3rM7prATNVL/${tokenId}.json`
  );
  
  });
    })
})
