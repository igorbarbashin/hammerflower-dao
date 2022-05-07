/**
This contract need to simulate an ERC20 to be used in a DAO
It has to be non-transferable and non-mintable

 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IHammerFlower.sol";

// const uint256 GARDEN_OWNER_TERM = 4672000; // 2 years of ethereum blocks (6400 per day)

contract FlowerPower is ERC20, Ownable {
  IHammerFlower internal _hammerFlowerAddress;
  uint256 internal _gardenOwnerExpiration;

  constructor(address hammerFlowerAddress) ERC20("FlowerPower", "FPOWER") {
    // TODO: Set the garden owner expiration deadline based on the current block timestamp
    _hammerFlowerAddress = IHammerFlower(hammerFlowerAddress);
  }

  function balanceOf(address account) public view override returns (uint256) {
    // TODO: Make this power go away in a term of two years
    if (account == owner()) {
      // uint multiplier = (_gardenOwnerExpiration - now) / GARDEN_OWNER_TERM;
      // return totalSupply() * multiplier;
      return totalSupply() * 1;
    }
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
