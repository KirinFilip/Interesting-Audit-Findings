# If auction price goes to 0, NFT might become unclaimable / stuck forever

- From: [Sherlock](https://app.sherlock.xyz/audits/contests)
- [Link to Finding](https://solodit.xyz/issues/12282)
- [Finding POC](https://github.com/KirinFilip/Interesting-Audit-Findings/blob/main/test/2/RevertOnZeroPOC.sol)

To run the [Finding POC](https://github.com/KirinFilip/Interesting-Audit-Findings/blob/main/test/2/RevertOnZeroPOC.sol) use `forge test --match-contract RevertOnZeroTest -vv`

### Description:

From the [Code Snippet](https://github.com/sherlock-audit/2023-02-kairos/blob/main/kairos-contracts/src/AuctionFacet.sol#L43-L54) we see on L43 that `decreasingFactor` can become [`ZERO`](https://github.com/sherlock-audit/2023-02-kairos/blob/main/kairos-contracts/src/DataStructure/Global.sol#L17) after `loan.auction.duration` passes. On L54 we `return` the price by multiplying `estimatedValue` with `decreasingFactor`, meaning the price can be 0. There are certain ERC20 tokens which revert on zero value transfers (e.g. LEND). Thus if that kind of ERC20 token is used in an auction to sell an NFT the NFT can be stuck forever in the contract.

### Recommendation:

Address ERC20 tokens which revert on 0 value transfers. Auctions which are run with such tokens should have a minimal price of 1 wei instead of 0

## Revert On Zero Value Transfer Tokens

Since there are a lot of ERC20 tokens that do not follow the [ERC20 standard](https://eips.ethereum.org/EIPS/eip-20) exactly we need to be careful when a protocol is interacting with different ERC20 tokens.
There are certain ERC20 tokens that do not allow zero value transfers and revert. One such token is [LEND](https://etherscan.io/token/0x80fB784B7eD66730e8b1DBd9820aFD29931aab03). Looking at its code we can see that on L74 `transfer` and on L86 `transferFrom` has a `require(balances[_to] + _value > balances[_to]);` statement that reverts if we try to transfer zero `_value` of tokens

![LEND code](https://github.com/KirinFilip/Interesting-Audit-Findings/blob/main/test/2/LEND.png)
