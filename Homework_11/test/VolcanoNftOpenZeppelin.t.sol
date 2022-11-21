// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// Standard test libs
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Vm.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

// Contract under test
import {OZ_Nft} from "../src/VolcanoNftOpenZeppelin.sol";

contract NFTTest is Test {
    using stdStorage for StdStorage;
    address bob = address(1);
    address alice = address(2);

    OZ_Nft private nft;

    function setUp() public {
        // Deploy NFT contract
        nft = new OZ_Nft();
    }

    function testFailNoMintPricePaid() public {
        vm.prank(bob);
        vm.deal(bob, 1 ether);
        nft.mintTo(bob);
    }

    function testMintPricePaid() public {
        vm.prank(bob);
        vm.deal(bob, 1 ether);
        nft.mintTo{value: 0.01 ether}(bob);
    }

    function testFailMintPriceOver() public {
        vm.prank(bob);
        vm.deal(bob, 1 ether);
        nft.mintTo{value: 0.1 ether}(bob);
    }

    function testFailMintToZeroAddress() public {
        nft.mintTo{value: 0.01 ether}(address(0));
    }

    function testCorrectTokenId() public {
        vm.prank(bob);
        vm.deal(bob, 1 ether);
        nft.mintTo{value: 0.01 ether}(bob);
        uint256 currentTokenId = nft.tokenId();
        assertEq(currentTokenId, 1);
    }

    function testFailMaxSupplyReached() public {
        uint8 j;
        uint256 currentTokenId;
        vm.deal(bob, 1 ether);

        for (j=0; j<=nft.TOTAL_SUPPLY()+1; j++) {
            vm.prank(bob);
            nft.mintTo{value: 0.01 ether}(bob);
            currentTokenId = nft.tokenId();
        }
    }

    function testNewMintOwnerRegistered() public {
        vm.deal(bob, 1 ether);
        vm.prank(bob);
        nft.mintTo{value: 0.01 ether}(bob);

        uint256 slotOfNewOwner = stdstore
            .target(address(nft))
            .sig(nft.ownerOf.selector)
            .with_key(1)
            .find();

        uint160 ownerOfTokenIdOne = uint160(
            uint256(
                (vm.load(address(nft), bytes32(abi.encode(slotOfNewOwner))))
            )
        );

        assertEq(address(ownerOfTokenIdOne), bob);
    }

    function testBalanceIncremented() public {
        vm.deal(bob, 1 ether);
        vm.prank(bob);
        nft.mintTo{value: 0.01 ether}(bob);

        uint256 slotBalance = stdstore
            .target(address(nft))
            .sig(nft.balanceOf.selector)
            .with_key(bob)
            .find();

        uint256 balanceFirstMint = uint256(
            vm.load(address(nft), bytes32(slotBalance))
        );
        assertEq(balanceFirstMint, 1);

        vm.prank(bob);
        nft.mintTo{value: 0.01 ether}(bob);

        uint256 balanceSecondMint = uint256(
            vm.load(address(nft), bytes32(slotBalance))
        );
        assertEq(balanceSecondMint, 2);
    }

    function testWithdrawalWorksAsOwner() public {
        vm.deal(alice, 1 ether);
        // Mint an NFT, sending eth to the contract
        address payable payee = payable(bob);
        uint256 priorPayeeBalance = payee.balance;
        vm.prank(alice);
        nft.mintTo{value: 0.01 ether}(alice);
        // Check that the balance of the contract is correct
        assertEq(address(nft).balance, 0.01 ether);
        uint256 nftBalance = address(nft).balance;
        // Withdraw the balance and assert it was transferred
        nft.withdrawPayments(payee);
        assertEq(payee.balance, priorPayeeBalance + nftBalance);
    }

    function testWithdrawalFailsAsNotOwner() public {
        vm.deal(alice, 1 ether);
        // Mint an NFT, sending eth to the contract
        vm.prank(alice);
        nft.mintTo{value: 0.01 ether}(alice);
        // Check that the balance of the contract is correct
        assertEq(address(nft).balance, 0.01 ether);
        // Confirm that a non-owner cannot withdraw
        vm.expectRevert("Ownable: caller is not the owner");
        vm.startPrank(address(0xd3ad));
        nft.withdrawPayments(payable(address(0xd3ad)));
        vm.stopPrank();
    }

}
