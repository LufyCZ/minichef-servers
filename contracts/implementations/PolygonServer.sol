// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../BaseServer.sol';

interface IPolygonBridge {
  function depositFor(address user, address token, bytes calldata depositData) external;
}

contract PolygonServer is BaseServer {
  IPolygonBridge public constant polygonBridge = IPolygonBridge(0xA0c68C638235ee32657e8f720a23ceC1bFc77C77);
  
  constructor(uint256 _pid, address _dummyToken, address _minichef) BaseServer(_pid, _dummyToken, _minichef) {}

  function bridge() public override {
    uint256 sushiBalance = sushi.balanceOf(address(this));

    sushi.approve(address(polygonBridge), sushiBalance);
    polygonBridge.depositFor(minichef, address(sushi), toBytes(sushiBalance));
  }

  function toBytes(uint256 x) internal pure returns (bytes memory b) {
    b = new bytes(32);
    assembly { mstore(add(b, 32), x) }
}
}