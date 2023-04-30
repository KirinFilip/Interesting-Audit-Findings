# Spearbit Interesting Audit Finding

## `CelerIMFacet` incorrectly sets `RelayerCelerIM` as receiver

- [Link to Finding](https://solodit.xyz/issues/15923)
- [Finding POC](https://github.com/KirinFilip/Interesting-Audit-Findings/blob/main/test/1/FindingPOC.sol)

### Description:

When assigning a bytes memory variable to a new variable, the new variable points to the same
memory location. Changing any one variable updates the other variable.

## Data location and assignment behaviour

- [AssignmentBehavior POC](https://github.com/KirinFilip/Interesting-Audit-Findings/blob/main/test/1/AssignmentBehaviorPOC.sol)

### Description:

From [Solidity Docs:](https://docs.soliditylang.org/en/v0.8.17/types.html#data-location-and-assignment-behaviour)

Data locations are not only relevant for persistency of data, but also for the semantics of assignments:

- Assignments between `storage` and `memory` (or from `calldata`) always create an independent copy.

- Assignments from `memory` to `memory` only create references. This means that changes to one memory variable are also visible in all other memory variables that refer to the same data.

- Assignments from `storage` to a **local** storage variable also only assign a reference.

- All other assignments to `storage` always copy. Examples for this case are assignments to state variables or to members of local variables of storage struct type, even if the local variable itself is just a reference.
