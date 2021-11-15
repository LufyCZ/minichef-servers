import { MINICHEF_ADDRESS, ChainId } from "@sushiswap/sdk";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const contracts: any = {
  MATIC: {
    pid: 0,
    contract: "PolygonServer",
  },
};

module.exports = async function main({
  deployments,
  getUnnamedAccounts,
}: HardhatRuntimeEnvironment) {
  const { deploy } = deployments;
  const [deployer] = await getUnnamedAccounts();

  for (const chain of Object.keys(contracts)) {
    // Get address of already deployed dummy
    const { address: dummyAddress } = await deploy("DummyToken", {
      from: deployer,
      args: [`${chain as any}-CHEF`, `${chain.substring(0, 1)}-CHEF`],
    });

    const { address } = await deploy(contracts[chain as any].contract, {
      from: deployer,
      args: [
        contracts[chain as any].pid,
        dummyAddress,
        MINICHEF_ADDRESS[ChainId[chain as any] as any],
      ],
    });

    console.log("Server:", chain, "-", address);
  }
};

module.exports.tags = ["Servers"];
