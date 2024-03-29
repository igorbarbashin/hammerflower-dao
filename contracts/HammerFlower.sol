// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "hardhat/console.sol";

contract HammerFlower is ERC721, Ownable {
  using Counters for Counters.Counter;
  using SafeMath for uint256;

  string private _baseURIextended;

  Counters.Counter private _commonCounter;
  Counters.Counter private _rareCounter;
  Counters.Counter private _epicCounter;

  uint256 private _totalPowerSupply;

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
    _totalPowerSupply = _totalPowerSupply.add(power);
    powerBalances[msg.sender] += power;
    super._mint(msg.sender, newTokenId);
    console.log("New token ID", newTokenId);

    return newTokenId;
  }

  // TODO: This method will be called by an ERC20 wrapper called FlowerPower
  function powerBalanceOf(address account) external view returns (uint256) {
    return powerBalances[account];
  }

  function totalPowerSupply() external view returns (uint256) {
    return _totalPowerSupply;
  }

  // TODO: make it override the standard function
  function _transfer(
    address from,
    address to,
    uint256 tokenId
  ) internal virtual override {
    require(msg.sender == from, "Sender is not the owner");
    require(to != address(0), "Missing recipient");

    uint256 power = powers[tokenId];
    powerBalances[from] -= power;
    powerBalances[to] += power;
    super._transfer(from, to, tokenId);
  }

  function setBaseURI(string memory baseURI_) external onlyOwner {
    _baseURIextended = baseURI_;
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return _baseURIextended;
  }
}
