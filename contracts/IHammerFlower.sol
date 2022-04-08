// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IHammerFlower {
  function powerBalanceOf(address) external view returns (uint256);

  function totalPowerSupply() external view returns (uint256);
}
