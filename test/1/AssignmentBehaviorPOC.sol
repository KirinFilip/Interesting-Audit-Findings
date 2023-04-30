// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract Test2 is Test {
    // storage array
    uint256[2] sArray;

    function test2() public {
        // create a memory array `mArray`
        uint256[2] memory mArray;
        mArray[0] = 0;
        mArray[1] = 1;

        // 1. assign memory to storage
        // copies the whole `mArray` to storage
        sArray = mArray;

        console.log("sArray[0]", sArray[0]); // 0
        console.log("mArray[0]", mArray[0]); // 0
        console.log("sArray[1]", sArray[1]); // 1
        console.log("mArray[1]", mArray[1]); // 1
        console.log("-------------");

        assertEq(sArray[0], mArray[0]); // true (0 == 0)
        assertEq(sArray[1], mArray[1]); // true (1 == 1)

        // if we change memory, storage does not change
        mArray[0] = 2;

        console.log("sArray[0]", sArray[0]); // 0
        console.log("mArray[0]", mArray[0]); // 2
        console.log("sArray[1]", sArray[1]); // 1
        console.log("mArray[1]", mArray[1]); // 1
        console.log("-------------");

        assertNotEq(sArray[0], mArray[0]); // true (0 != 2)
        assertEq(sArray[1], mArray[1]); // true (1 == 1)

        // if we change storage, memory does not change
        sArray[0] = 3;

        console.log("sArray[0]", sArray[0]); // 3
        console.log("mArray[0]", mArray[0]); // 2
        console.log("sArray[1]", sArray[1]); // 1
        console.log("mArray[1]", mArray[1]); // 1
        console.log("-------------");

        assertNotEq(sArray[0], mArray[0]); // true (3 != 2)
        assertEq(sArray[1], mArray[1]); // true (1 == 1)

        // ----------------------------------------- //
        // ----------------------------------------- //

        // reset the change
        sArray[0] = 0;

        // 2. assign storage to local storage
        // assigns a pointer, data location of `sArray2` is storage
        uint256[2] storage sArray2 = sArray;

        console.log("sArray2[0]", sArray2[0]); // 0
        console.log("sArray2[1]", sArray2[1]); // 1
        console.log("-------------");

        assertEq(sArray[0], sArray2[0]); // true
        assertEq(sArray[1], sArray2[1]); // true

        // change to `sArray2` also changes `sArray`
        sArray2[0] = 2;

        console.log("sArray[0]", sArray[0]); // 2
        console.log("sArray2[0]", sArray2[0]); // 2
        console.log("-------------");

        assertEq(sArray[0], sArray2[0]); // true (2 == 2)
        assertEq(sArray[1], sArray2[1]); // true (0 == 0)

        // if we delete `sArray` it also clears `sArray2`
        delete sArray;
        // delete sArray2; => not valid
        // as assignments to local variables
        // referencing storage objects can only be made from existing storage objects.
        // It would "reset" the pointer, but there is no sensible location it could point to

        console.log("sArray[0]", sArray[0]); // 0
        console.log("sArray2[0]", sArray2[0]); // 0
        console.log("sArray[1]", sArray[1]); // 0
        console.log("sArray2[1]", sArray2[1]); // 0

        assertEq(sArray[0], sArray2[0]); // true (0 == 0)
        assertEq(sArray[1], sArray2[1]); // true (0 == 0)
    }
}
