// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface IMasterChefV2 {
    function deposit(uint256 pid, uint256 amount, address to) external;
    function withdraw(uint256 pid, uint256 amount, address to) external;
    function harvest(uint256 pid, address to) external;
}

abstract contract BaseServer is Ownable {
  IMasterChefV2 public constant masterchefv2 = IMasterChefV2(0xEF0881eC094552b2e128Cf945EF17a6752B4Ec5d);
  IERC20 public constant sushi = IERC20(0x6B3595068778DD592e39A122f4f5a5cF09C90fE2);

  IERC20 public immutable dummyToken;
  uint256 public immutable pid;

  address public immutable minichef;

  constructor(uint256 _pid, address _dummyToken, address _minichef) {
    pid = _pid;
    dummyToken = IERC20(_dummyToken);
    minichef = _minichef;
  }

  function harvest() public {
    masterchefv2.harvest(pid, address(this));
    bridge();
  }

  function withdraw() public onlyOwner {
    masterchefv2.withdraw(pid, 1, msg.sender);
  }

  function bridge() public virtual;
}