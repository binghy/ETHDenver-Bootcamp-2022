// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/openzeppelin-contracts/contracts/security/PullPayment.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Counters.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

error MintPriceNotPaid();
error MintPriceNotValid();
error MaxSupply();
error NonExistentTokenURI();
error WithdrawTransfer();

contract OZ_Nft is ERC721, PullPayment, Ownable {

    using Counters for Counters.Counter;
    using Strings for uint256;
    Counters.Counter private _tokenIdCounter;
    uint256 public tokenId;
    uint256 public constant TOTAL_SUPPLY = 5;
    uint256 public constant MINT_PRICE = 0.01 ether;

    constructor() ERC721("VolcanoNft", "VCnft") {}

    function mintTo(address to) public payable returns (uint256) {
        if (msg.value < MINT_PRICE) {
            revert MintPriceNotPaid();
        }
        if (msg.value > MINT_PRICE) {
            revert MintPriceNotValid();
        }
        require(to == msg.sender, "Payer must be equal to caller");         // otherwise minting to an address that it is not paying (another account could be selected for the minting price)
        _tokenIdCounter.increment();
        tokenId = _tokenIdCounter.current();
        require(tokenId <= TOTAL_SUPPLY, "Max supply reached");
        _safeMint(to, tokenId);
        return tokenId;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://752b-2-229-27-106.eu.ngrok.io/api/nfts/";           // last valid link (last VolcanoNFT_metadata run, ngrok generates new random link on every new run)
    }

    function withdrawPayments(address payable payee) public override onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{value: balance}("");
        if (!transferTx) {
            revert WithdrawTransfer();
        }
    }
    
}
