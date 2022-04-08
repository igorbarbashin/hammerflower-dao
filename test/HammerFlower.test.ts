import { expect } from "chai";
import { ethers } from "hardhat";

describe("HammerFlower", function () {
  it("Should work", async () => {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const HammerFlower = await ethers.getContractFactory("HammerFlower");
    const hammerFlower = await HammerFlower.deploy();
    await hammerFlower.deployed();

    console.log(hammerFlower.address);

    const FlowerPower = await ethers.getContractFactory("FlowerPower");
    const flowerPower = await FlowerPower.deploy(hammerFlower.address);

    expect(await hammerFlower.symbol()).to.equal("FLOWER");
    // expect().to.be.revertedWith("Not enough value");
    await hammerFlower.mint({
      value: ethers.utils.parseEther("0.5"),
    });

    expect(await hammerFlower.balanceOf(owner.address)).to.equal(1);

    expect(await hammerFlower.powerBalanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("5")
    );

    expect(await flowerPower.balanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("5")
    );

    expect(await flowerPower.totalSupply()).to.equal(
      ethers.utils.parseEther("5")
    );

    await hammerFlower.transferFrom(owner.address, addr1.address, 1000001);

    expect(await hammerFlower.powerBalanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("0")
    );

    expect(await hammerFlower.powerBalanceOf(addr1.address)).to.equal(
      ethers.utils.parseEther("5")
    );

    await hammerFlower.mint({
      value: ethers.utils.parseEther("0.1"),
    });

    await hammerFlower.mint({
      value: ethers.utils.parseEther("0.2"),
    });

    expect(await hammerFlower.powerBalanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("3")
    );

    await hammerFlower.mint({
      value: ethers.utils.parseEther("5"),
    });

    expect(await hammerFlower.powerBalanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("53")
    );

    await hammerFlower.mint({
      value: ethers.utils.parseEther("15"),
    });

    expect(await hammerFlower.powerBalanceOf(owner.address)).to.equal(
      ethers.utils.parseEther("203")
    );

    // Should mint with a payable mint function
    // Need to be able to check the sum power
    // Transfer token reduces power
  });
});
