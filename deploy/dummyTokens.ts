import { MINICHEF_ADDRESS, ChainId } from "@sushiswap/sdk";
import { HardhatRuntimeEnvironment } from "hardhat/types";

module.exports = async function main({
  deployments,
  getUnnamedAccounts,
}: HardhatRuntimeEnvironment) {
  const { deploy } = deployments;
  const [deployer] = await getUnnamedAccounts();

  for (const chain of Object.keys(MINICHEF_ADDRESS)) {
    const { address } = await deploy("DummyToken", {
      from: deployer,
      args: [
        `${ChainId[chain as any]}-CHEF`,
        `${ChainId[chain as any].substring(0, 1)}-CHEF`,
      ],
    });
    console.log("Dummy", ChainId[chain as any], "-", address);
  }
};

module.exports.tags = ["DummyTokens"];
