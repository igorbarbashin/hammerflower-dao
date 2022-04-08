// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "hardhat/console.sol";

contract HammerFlower is ERC721 {
  using Counters for Counters.Counter;
  using SafeMath for uint256;

  Counters.Counter private _commonCounter;
  Counters.Counter private _rareCounter;
  Counters.Counter private _epicCounter;

  // TODO: Can be optimized if encode the powers and tier in the same uint256
  mapping(uint256 => uint256) public powers;
  mapping(address => uint256) public powerBalances;

  constructor() ERC721("HammerFlower", "FLOWER") {}

  function mint() public payable returns (uint256) {
    require(msg.value >= 0.1 ether, "Not enough value");

    uint256 newTokenId;

    if (msg.value >= 0.1 ether && msg.value < 1 ether) {
      _commonCounter.increment();
      newTokenId = _commonCounter.current().add(1000000);
    } else if (msg.value >= 1 ether && msg.value < 10 ether) {
      _rareCounter.increment();
      newTokenId = _rareCounter.current().add(2000000);
    } else if (msg.value >= 10 ether) {
      _epicCounter.increment();
      newTokenId = _epicCounter.current().add(3000000);
    }
    powers[newTokenId] = msg.value;
    uint256 power = msg.value.mul(10);
    powers[newTokenId] = power;
    powerBalances[msg.sender] += power;
    super._mint(msg.sender, newTokenId);
    console.log("New token ID", newTokenId);

    return newTokenId;
  }

  // TODO: This method will be called by an ERC20 wrapper called FlowerPower
  function powerBalanceOf(address account) external view returns (uint256) {
    return powerBalances[account];
  }

  // TODO: make it override the standard function
  function myTransferFrom(
    address from,
    address to,
    uint256 tokenId
  ) external {
    require(msg.sender == from, "Sender is not the owner");
    require(to != address(0), "Missing recipient");

    uint256 power = powers[tokenId];
    powerBalances[from] -= power;
    powerBalances[to] += power;
    super.safeTransferFrom(from, to, tokenId);
  }
}
