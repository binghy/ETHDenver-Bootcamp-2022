//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

interface IPersonInNeed{
    function addBeneficiary(address _address, uint[] memory _amounts_asked, uint[] memory _amounts_owned) external;
    function mintAssetsOwned(address _address) external;
    function mintAssetsAsked(address _address) external;
    function pause() external;
    function unpause() external;
}

contract HelperStaff is ERC721, Ownable, Pausable {

    using Counters for Counters.Counter;
    using Strings for uint256;
    uint256 public tokenId;
    Counters.Counter private _tokenIds;
    mapping(address => uint) private mintedNft;

    constructor() ERC721("PersonInNeed", "PIN") {}

    function mintNFT(address to) public onlyOwner whenNotPaused returns (uint256) {
        require(mintedNft[to] == 0, "PIN token already minted for beneficiary");
        _tokenIds.increment();
        tokenId = _tokenIds.current();
        _safeMint(to, tokenId);
        mintedNft[to] = 1;
        return tokenId;
    }

    function addBeneficiaryOnPIN(
        address _addressPinContract,
        address _addressBeneficiary,
        uint[] memory _amounts_asked,
        uint[] memory _amounts_owned)
        public onlyOwner whenNotPaused {
        IPersonInNeed(_addressPinContract).addBeneficiary(_addressBeneficiary, _amounts_asked, _amounts_owned);
    }

    function mintAssetOwnedOnPIN(address _addressPinContract, address _addressBeneficiary) public onlyOwner whenNotPaused {
        IPersonInNeed(_addressPinContract).mintAssetsOwned(_addressBeneficiary);
    }

    function mintAssetAskedOnPIN(address _addressPinContract, address _addressBeneficiary) public onlyOwner whenNotPaused {
        IPersonInNeed(_addressPinContract).mintAssetsAsked(_addressBeneficiary);
    }

    function pause(address _addressPinContract) public onlyOwner {
        IPersonInNeed(_addressPinContract).pause();
        _pause();
    }

    function unpause(address _addressPinContract) public onlyOwner {
        IPersonInNeed(_addressPinContract).pause();
        _unpause();
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        _requireMinted(_tokenId);
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/QmY5RhCzoQ8v6eUsXr7EiJDDayWUbs4cd9t3rM7prATNVL/",
                Strings.toString(_tokenId),".json"
            )
        );
    }
}
