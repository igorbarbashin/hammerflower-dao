/**
This contract need to simulate an ERC20 to be used in a DAO
It has to be non-transferable and non-mintable

 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "./IHammerFlower.sol";

abstract contract FlowerPower is IERC20, IERC20Metadata {
  IHammerFlower internal _hammerFlowerAddress;

  constructor(address hammerFlowerAddress) {
    _hammerFlowerAddress = IHammerFlower(hammerFlowerAddress);
  }

  function balanceOf(address account) public view override returns (uint256) {
    return _hammerFlowerAddress.powerBalanceOf(account);
  }
}
