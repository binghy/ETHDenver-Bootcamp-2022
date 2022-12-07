const {expect} = require("chai");
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
        it("Should have the correct owner", async function () {
            expect(await helperStaff.owner()).to.equal(owner.address);
        });

        it("Should have the correct balance after minting", async function () {
            const initialBalance = await helperStaff.balanceOf(owner.address)
            expect(initialBalance.toString()).to.equal("0");

            await helperStaff.mintNFT(owner.address);

            const finalBalance = await helperStaff.balanceOf(owner.address)
            expect(finalBalance.toString()).to.equal("1");
        });
        
        it('should be able to pause and unpause contract', async () => {
            // Pause the contract
            await helperStaff.pause();
        
            // Try to mint an NFT while the contract is paused
            // This should fail
            let errorThrown = false;
            try {
              await helperStaff.mintNFT(addrs1.address);
            } catch (error) {
              errorThrown = true;
            }
            expect(errorThrown).to.be.true;
        
            // Unpause the contract
            await helperStaff.unpause();
        
            // Mint an NFT again, this should succeed
            await helperStaff.mintNFT(addrs1.address);
        
            // Check that the recipient's balance was updated
            const balance = await helperStaff.balanceOf(addrs1.address);
            let expectedNumberNft = 1;
            expect(Number(balance)).to.equal(expectedNumberNft);
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
            `https://ipfs.io/ipfs/QmbQziNu8fL8fVcmNvXmTPHHQMwSg9gSz1aQBn8QZvSTGj/${tokenId}.json`
          );
  
  });
    })
})
