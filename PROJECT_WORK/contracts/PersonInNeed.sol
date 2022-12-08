// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./HelperStaff.sol";

contract PersonInNeed is ERC1155, Ownable, Pausable {

    uint256 public constant HOUSE = 0;
    uint256 public constant CAR = 1;
    uint256 public constant BYCICLE = 2;
    uint256 public constant LAND = 3;
    uint256 public constant COW = 4;

    struct AssetsAmount{
        uint[] amounts_owned;
        uint[] amounts_asked;
        bool valid;
    }

    uint[] ids;
    address[] public beneficiaries;                         // retrieved from json data of PersonInNeed token

    mapping(address => uint) private mintedAssetsOwned;
    mapping(address => uint) private mintedAssetsAsked;
    mapping(address => AssetsAmount) private beneficiariesAvailable;

    constructor(
        ) ERC1155("https://ipfs.io/ipfs/QmQLR2mdQjtwB8UxjuMTCfCBPdMhb2kfnjixjQe2K2nXQx/{id}.json") {
            ids = [HOUSE,CAR,BYCICLE,LAND,COW];
    }

    function addBeneficiary(
        address _address, 
        uint[] memory _amounts_asked, 
        uint[] memory _amounts_owned) 
        external onlyOwner whenNotPaused {
        require(!beneficiariesAvailable[_address].valid, "Beneficiary already exists");
        require(_amounts_asked.length == _amounts_owned.length, "Assets owned and asked have different lenghts");
        beneficiaries.push(_address);
        beneficiariesAvailable[_address] = AssetsAmount(_amounts_owned, _amounts_asked, true);
    }

    function mintAssetsOwned(address _address) external onlyOwner whenNotPaused {
        require(mintedAssetsOwned[_address] == 0, "Asset already minted for beneficiary");
        _mintBatch(_address, ids, beneficiariesAvailable[_address].amounts_owned, "");
        mintedAssetsOwned[_address] = 1;
    }

    function mintAssetsAsked(address _address) external onlyOwner whenNotPaused {
        require(mintedAssetsAsked[_address] == 0, "Asset already minted for beneficiary");
        _mintBatch(_address, ids, beneficiariesAvailable[_address].amounts_asked, "");
        mintedAssetsAsked[_address] = 1;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function uri(uint256 _tokenid) override public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/QmQLR2mdQjtwB8UxjuMTCfCBPdMhb2kfnjixjQe2K2nXQx/",
                Strings.toString(_tokenid),".json"
            )
        );
    }
    
}