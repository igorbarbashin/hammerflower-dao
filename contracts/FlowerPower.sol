/**
This contract need to simulate an ERC20 to be used in a DAO
It has to be non-transferable and non-mintable

 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IHammerFlower.sol";

contract FlowerPower is ERC20 {
  IHammerFlower internal _hammerFlowerAddress;

  constructor(address hammerFlowerAddress) ERC20("FlowerPower", "FPOWER") {
    _hammerFlowerAddress = IHammerFlower(hammerFlowerAddress);
  }

  function balanceOf(address account) public view override returns (uint256) {
    return _hammerFlowerAddress.powerBalanceOf(account);
  }

  // We can get the total supply
  /**
   * @dev See {IERC20-totalSupply}.
   */
  function totalSupply() public view virtual override returns (uint256) {
    return _hammerFlowerAddress.totalPowerSupply();
  }

  /**
   * @dev Mock {IERC20-transfer}
   */
  function transfer(address recipient, uint256 amount)
    public
    virtual
    override
    returns (bool)
  {
    revert("not possible to transfer this token");
  }

  /**
   * @dev Mock {IERC20-allowance}.
   */
  function allowance(address owner, address spender)
    public
    view
    virtual
    override
    returns (uint256)
  {
    revert("not possible to transfer this token");
  }

  /**
   * @dev Mock {IERC20-approve}.
   */
  function approve(address spender, uint256 amount)
    public
    virtual
    override
    returns (bool)
  {
    revert("not possible to transfer voting token");
  }

  /**
   * @dev Mock {IERC20-transferFrom}.
   */
  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) public virtual override returns (bool) {
    revert("not possible to transfer vested token");
  }
}
