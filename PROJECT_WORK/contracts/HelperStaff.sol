//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
//import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

//contract HelperStaff is ERC721URIStorage, Ownable, Pausable, ReentrancyGuard {
contract HelperStaff is ERC721URIStorage, Ownable, Pausable {

    using Counters for Counters.Counter;
    using Strings for uint256;
    uint256 public tokenId;
    Counters.Counter private _tokenIds;

    constructor() ERC721("PersonInNeed", "PIN") {}

//    function mintNFT(address to) public onlyOwner whenNotPaused nonReentrant returns (uint256) {
    function mintNFT(address to) public onlyOwner whenNotPaused returns (uint256) {    
        _tokenIds.increment();
        tokenId = _tokenIds.current();
        _safeMint(to, tokenId);
        return tokenId;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        _requireMinted(_tokenId);
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/QmbQziNu8fL8fVcmNvXmTPHHQMwSg9gSz1aQBn8QZvSTGj/",
                Strings.toString(_tokenId),".json"
            )
        );
    }
}
