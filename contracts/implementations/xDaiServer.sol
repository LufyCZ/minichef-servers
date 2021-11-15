// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../BaseServer.sol';

interface IxDaiBridge {
  function relayTokens(address token, address _receiver, uint256 _value) external;
}

contract xDaiServer is BaseServer {
  IxDaiBridge public constant xDaiBridge = IxDaiBridge(0x88ad09518695c6c3712AC10a214bE5109a655671);
  
  constructor(uint256 _pid, address _dummyToken, address _minichef) BaseServer(_pid, _dummyToken, _minichef) {}

  function bridge() public override {
    uint256 sushiBalance = sushi.balanceOf(address(this));

    sushi.approve(address(xDaiBridge), sushiBalance);
    xDaiBridge.relayTokens(address(sushi), minichef, sushiBalance);
  }
}