import { MINICHEF_ADDRESS, ChainId } from "@sushiswap/sdk";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const contracts: any = {
  MATIC: {
    pid: undefined,
    contract: "PolygonServer",
  },
  HARMONY: {
    pid: undefined,
    contract: "HarmonyServer",
  },
  XDAI: {
    pid: undefined,
    contract: "xDaiServer",
  },
  CELO: {
    pid: undefined,
    contract: "CeloServer",
  },
  // ARBITRUM: { // not supported yet by anyswap, official arbitrum bridge is too complex
  //   pid: 4,
  //   contract: "AnyswapServer",
  //   chainId: 42161
  // },
  // MOONRIVER: { // Moonriver briding is just simple ERC20 transfers to an EOA...
  //   pid: undefined,
  //   contract: "AnyswapServer",
  //   chainId: 1285,
  // },
};

module.exports = async function main({
  deployments,
  getUnnamedAccounts,
}: HardhatRuntimeEnvironment) {
  const { deploy } = deployments;
  const [deployer] = await getUnnamedAccounts();

  for (const chain of Object.keys(contracts)) {
    if (!contracts[chain as any]?.pid) return;

    const { address } = await deploy(contracts[chain as any].contract, {
      from: deployer,
      args: [
        contracts[chain as any].pid,
        MINICHEF_ADDRESS[ChainId[chain as any] as any],
        contracts[chain as any]?.chainId,
      ].filter((e) => e !== undefined),
    });

    console.log("Server:", chain, "-", address);
  }
};

module.exports.tags = ["Servers"];
