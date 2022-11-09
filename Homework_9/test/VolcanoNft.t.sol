// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// Standard test libs
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Vm.sol";

// Contract under test
import {VolcanoNft} from "../src/VolcanoNft.sol";

contract VolcanoNftContractTest is Test {
    // Variable for contract instance
    VolcanoNft private vNft;
    uint256 private currentTokenId;
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    function setUp() public {
        // Instantiate new contract instance
        vNft = new VolcanoNft();
    }

    // Test Nft minting by owner
    function testMintAsOwner() public {
        assertTrue(vNft.mintNft(address(1)) == 0);
        assertTrue(vNft.mintNft(address(1)) == 1);
    }

    // Test Nft minting by not owner
    function testFailMintAsNotOwner() public {
        vm.prank(address(0));
        assertTrue(vNft.mintNft(address(1)) == 0);
    }

    function testMintEmitsEvent() public {
        vm.expectEmit(true, true, false, true);
        currentTokenId = vNft.mintNft(address(1));
        emit Transfer(address(0), address(1), currentTokenId);
    }

}
