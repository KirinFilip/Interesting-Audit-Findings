// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {RevertOnZeroToken} from "./RevertOnZeroToken.sol";
import {DutchAuction} from "./DutchAuction.sol";

contract RevertOnZeroTest is Test {
    DutchAuction public auction;
    RevertOnZeroToken public token;
    ERC721 public nft;

    function setUp() public {
        nft = new ERC721("NFT", "NFT");
        token = new RevertOnZeroToken(100e18);
        //  startingPrice, discountRate, duration, nft, token
        auction = new DutchAuction(1e18, 25e16, 4, address(nft), address(token));
    }

    function test_RevertOnZeroTransfer() public {
        // get the starting price
        // `block.timestamp` = time of contract deployment
        uint256 price = auction.getPrice();
        console.log("Price:", price); // 1e18

        // skip forward `block.timestamp` by 4 seconds
        skip(4);

        // price has dropped to 0
        price = auction.getPrice();
        console.log("Price:", price); // 0
        assertEq(price, 0); // true

        vm.expectRevert("Zero Value Transfer");
        auction.buy(); // reverts
    }
}
