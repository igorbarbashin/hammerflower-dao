import { expect } from "chai";
import { ethers } from "hardhat";

describe("HammerFlower", function () {
  it("Should work", async () => {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const HammerFlower = await ethers.getContractFactory("HammerFlower");
    const hammerFlower = await HammerFlower.deploy();
    await hammerFlower.deployed();

    expect(await hammerFlower.symbol()).to.equal("FLOWER");
    await hammerFlower._mint();

    expect(await hammerFlower.balanceOf(owner.address)).to.equal(1);
    // Should mint with a payable mint function
    // Need to be able to check the sum power
    // Transfer token reduces power
  });
});
