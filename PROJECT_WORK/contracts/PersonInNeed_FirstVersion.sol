// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../contracts/HelperStaff_FirstVersion.sol";
//import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

//contract PersonInNeed is ERC1155, Ownable, Pausable, ReentrancyGuard  {
contract PersonInNeed is ERC1155, Ownable, Pausable {

    uint256 public constant HOUSE = 0;
    uint256 public constant CAR = 1;
    uint256 public constant BYCICLE = 2;
    uint256 public constant LAND = 3;
    uint256 public constant COW = 4;

    uint[] ids;
    uint[] public amounts_owned;
    uint[] public amounts_asked;

    mapping(address => uint) private mintedAssetsOwned;
    mapping(address => uint) private mintedAssetsAsked;

    address public contractOwner = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    address public beneficiary;                 // retrieved from json data of PersonInNeed token

    constructor(
        uint[] memory _amounts_owned,
        uint[] memory _amounts_asked,
        address _beneficiary
        ) ERC1155("https://ipfs.io/ipfs/QmRfwdJ48yFDkfstmgj7KvN8AqpuBPeuF7A1SK88Ggd7cn/{id}.json") {
            require(contractOwner == msg.sender, "Only HelperStaff contract can mint assets");
            ids = [HOUSE,CAR,BYCICLE,LAND,COW];
            amounts_owned  = _amounts_owned;
            amounts_asked  = _amounts_asked;
            require(amounts_asked.length == amounts_owned.length, "Assets owned and asked have different lenghts");
            beneficiary = _beneficiary;
    }

    function mintAssetsOwned() public onlyOwner whenNotPaused {
        require(mintedAssetsOwned[beneficiary] == 0);
        _mintBatch(beneficiary, ids, amounts_owned, "");
        mintedAssetsOwned[beneficiary] = 1;
    }

    function mintAssetsAsked() public onlyOwner whenNotPaused {
        require(mintedAssetsAsked[beneficiary] == 0);
        _mintBatch(beneficiary, ids, amounts_asked, "");
        mintedAssetsAsked[beneficiary] = 1;
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