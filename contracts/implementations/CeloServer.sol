// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../BaseServer.sol';

interface ICeloBridge {
  function send(address _token, uint256 _amount, uint32 _destination, bytes32 _recipient) external;
}

contract CeloServer is BaseServer {
  ICeloBridge public constant celoBridge = ICeloBridge(0x6a39909e805A3eaDd2b61fFf61147796ca6aBB47);
  
  constructor(uint256 _pid, address _dummyToken, address _minichef) BaseServer(_pid, _dummyToken, _minichef) {}

  function bridge() public override {
    uint256 sushiBalance = sushi.balanceOf(address(this));

    sushi.approve(address(celoBridge), sushiBalance);
    celoBridge.send(address(sushi), sushiBalance, 1667591279, bytes32(uint256(uint160(minichef))));
  }
}