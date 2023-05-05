// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/// This contract is for demonstration purposes only !

interface IERC721 {
    function _safeMint(address to, uint256 tokenId) external;
}

interface IERC20 {
    function transfer(address to, uint256 amount) external;
}

contract DutchAuction {
    IERC721 public immutable nft;
    IERC20 public immutable token;

    uint256 public immutable startingPrice;
    uint256 public immutable startAt;
    uint256 public immutable discountRate;
    uint256 public immutable duration;

    constructor(uint256 _startingPrice, uint256 _discountRate, uint256 _duration, address _nft, address _token) {
        startingPrice = _startingPrice;
        startAt = block.timestamp;
        discountRate = _discountRate;
        duration = _duration;

        // startingPrice must be greater than the discount
        require(_startingPrice >= _discountRate * _duration, "starting price < discount");

        nft = IERC721(_nft);
        token = IERC20(_token);
    }

    function getPrice() public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - startAt;
        uint256 discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external {
        uint256 price = getPrice();
        token.transfer(address(this), price);

        nft._safeMint(msg.sender, 1);
    }
}
