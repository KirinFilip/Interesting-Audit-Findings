// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {RevertOnZeroToken} from "./RevertOnZeroToken.sol";
import {DutchAuction} from "./DutchAuction.sol";

contract RevertOnZeroTest is Test {
    DutchAuction public auction;
    RevertOnZeroToken public token;
    ERC721 public nft;
    uint256 totalSupply = 100 ether;

    function setUp() public {
        nft = new ERC721("NFT", "NFT");
        token = new RevertOnZeroToken(totalSupply);

        // new DutchAuction(startingPrice, discountRate, duration, nft, token)
        // 4 seconds to get to price of 0
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
