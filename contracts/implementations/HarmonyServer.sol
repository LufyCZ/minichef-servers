// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../BaseServer.sol';

interface IHarmonyBridge {
  function lockToken(address ethTokenAddr, uint256 amount, address recipient) external;
}

contract HarmonyServer is BaseServer {
  IHarmonyBridge public constant harmonyBridge = IHarmonyBridge(0x2dCCDB493827E15a5dC8f8b72147E6c4A5620857);
  
  constructor(uint256 _pid, address _dummyToken, address _minichef) BaseServer(_pid, _dummyToken, _minichef) {}

  function bridge() public override {
    uint256 sushiBalance = sushi.balanceOf(address(this));

    sushi.approve(address(harmonyBridge), sushiBalance);
    harmonyBridge.lockToken(address(sushi), sushiBalance, minichef);
  }
}