// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract Test1 is Test {
    struct Ss {
        uint256 a;
        address b;
    }

    function test1() public {
        // create a memory struct `x`
        Ss memory x = Ss({a: 2, b: address(2)});
        // assign memory to memory => creates references
        // changes to one variable changes the other
        Ss memory y = x;

        console.log("x.b", x.b); // 0x0...02
        console.log("y.b", y.b); // 0x0...02

        // change to y.b changes x.b
        y.b = address(1);

        assertEq(x.b, y.b); // true

        console.log("x.b", x.b); // 0x0...01
        console.log("y.b", y.b); // 0x0...01
    }
}
