import { expect } from "chai";
import { ethers } from "hardhat";

describe("HammerFlower", function () {
  it("Should work", async () => {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const HammerFlower = await ethers.getContractFactory("HammerFlower");
    const hammerFlower = await HammerFlower.deploy();
    await hammerFlower.deployed();

    expect(await hammerFlower.symbol()).to.equal("FLOWER");
    // expect().to.be.revertedWith("Not enough value");
    await hammerFlower._mint({
      value: ethers.utils.parseEther("0.5"),
    });

    expect(await hammerFlower.balanceOf(owner.address)).to.equal(1);

    expect(await hammerFlower.powerBalanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("5")
    );

    // Should mint with a payable mint function
    // Need to be able to check the sum power
    // Transfer token reduces power
  });
});
