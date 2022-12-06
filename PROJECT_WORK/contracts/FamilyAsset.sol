// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

//contract FamilyAsset is ERC1155, Ownable, Pausable, ReentrancyGuard  {
contract FamilyAsset is ERC1155, Ownable, Pausable {    
    uint256 public constant HOUSE = 0;
    uint256 public constant CAR = 1;
    uint256 public constant BYCICLE = 2;
    uint256 public constant LAND = 3;
    uint256 public constant COW = 4;
    uint[] ids;
    uint[] public amounts;
//    address public owner = "<CONTRACT_ADDRESS_PERSON_IN_NEED>";
    address public beneficiary;

    constructor(
        uint[] memory _amounts,
        address _beneficiary
        ) ERC1155("https://ipfs.io/ipfs/QmRfwdJ48yFDkfstmgj7KvN8AqpuBPeuF7A1SK88Ggd7cn/{id}.json") {
//            require(owner = msg.sender, "Only PersonInNeed contract can mint assets");
            ids = [HOUSE,CAR,BYCICLE,LAND,COW];
            amounts  = _amounts;
            beneficiary = _beneficiary;
    }

    function mintAssets() public onlyOwner whenNotPaused {
        _mintBatch(beneficiary, ids, amounts, "");
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
                "https://ipfs.io/ipfs/QmRfwdJ48yFDkfstmgj7KvN8AqpuBPeuF7A1SK88Ggd7cn/",
                Strings.toString(_tokenid),".json"
            )
        );
    }
}