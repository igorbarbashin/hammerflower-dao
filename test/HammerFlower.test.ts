import { expect } from "chai";
import { ethers } from "hardhat";

describe("HammerFlower", function () {
  it("Should mint a token", async () => {
    const HammerFlower = await ethers.getContractFactory("HammerFlower");
    const hammerFlower = await HammerFlower.deploy();
    await hammerFlower.deployed();

    expect(await hammerFlower.symbol()).to.equal("FLOWER");
  });
});
