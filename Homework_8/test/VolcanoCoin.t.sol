// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// Standard test libs
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Vm.sol";

// Contract under test
import {VolcanoCoin} from "../src/VolcanoCoin.sol";

contract VolcanoCoinContractTest is Test {
    // Variable for contract instance
    VolcanoCoin private vc;

    function setUp() public {
        // Instantiate new contract instance
        vc = new VolcanoCoin();
    }

    // Test initial supply
    function test_GetValue() public {
        assertTrue(vc.getSupply() == 10_000);
    }

    // Test increment tokens by owner
    function testIncrementAsOwner() public {
        assertEq(vc.getSupply(), 10_000);
        vc.setSupply();
        assertEq(vc.getSupply(), 11_000);
    }

    // Test increment tokens by not owner
    function testFailIncrementAsNotOwner() public {
        assertEq(vc.getSupply(), 10_000);
        vm.prank(address(0));
        vc.setSupply();
        assertEq(vc.getSupply(), 11_000);
    }

}