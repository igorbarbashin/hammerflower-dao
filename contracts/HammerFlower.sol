// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

contract HammerFlower is ERC721 {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // TODO: Can be optimized if using part of ID for the power
  mapping (uint256 => uint256) public powers;
  mapping (address => uint256) public powerBalances;
  

  constructor() ERC721("HammerFlower", "FLOWER") {
  }

  function mint() public payable returns (uint256) {
    // require(msg.value >= 0.1 ether, "Not enough value");
    _tokenIds.increment();
    uint256 newTokenId = _tokenIds.current();
    powers[newTokenId] = msg.value;
    uint256 power = msg.value * 10;
    powers[newTokenId] = power;
    powerBalances[msg.sender] += power;
    super._mint(msg.sender, newTokenId);
    console.log("New token ID", newTokenId);

    return newTokenId;
  }

  function powerBalanceOf(address account) external view returns (uint256) {
    return powerBalances[account];
  }

  function myTransferFrom(address from, address to, uint256 tokenId) external {
    require(msg.sender == from, "Sender is not the owner");
    require(to != address(0), "Missing recipient");

    uint256 power = powers[tokenId];
    powerBalances[from] -= power;
    powerBalances[to] += power;
    super.safeTransferFrom(from, to, tokenId);

  }
}