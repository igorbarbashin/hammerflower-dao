// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

contract HammerFlower is ERC721 {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // A struct to store the flower power
  mapping (uint256 => uint256) public powers;
  

  constructor() ERC721("HammerFlower", "FLOWER") {
  }

  function _mint() public payable returns (uint256) {
    _tokenIds.increment();
    uint256 newTokenId = _tokenIds.current();
    powers[newTokenId] = msg.value;
    super._mint(msg.sender, newTokenId);
    console.log("New token ID", newTokenId);

    return newTokenId;
  }
}