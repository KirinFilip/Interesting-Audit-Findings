# Interesting-Audit-Findings

- [CelerIMFacet incorrectly sets RelayerCelerIM as receiver](https://github.com/KirinFilip/Interesting-Audit-Findings/tree/main/test/1)

  - Assigning a bytes memory variable to a new variable changes both variables

- [If auction price goes to 0, NFT might become unclaimable / stuck forever](https://github.com/KirinFilip/Interesting-Audit-Findings/tree/main/test/2)
  - Revert on zero transfer tokens can cause NFT to be stuck forever in the contract
