// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../FlashLoanReceiver.sol";
import "../NaiveReceiverLenderPool.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract Setup {
    using Address for address payable;
    NaiveReceiverLenderPool naiveReceiverLenderPool;
    FlashLoanReceiver flashLoanReceiver;

    constructor() payable {
        // 1 - deployment
        naiveReceiverLenderPool = new NaiveReceiverLenderPool();
        flashLoanReceiver = new FlashLoanReceiver(
            payable(address(naiveReceiverLenderPool))
        );
        // 2 - seeding with ether
        payable(address(naiveReceiverLenderPool)).sendValue(1000e18);
        payable(address(flashLoanReceiver)).sendValue(10e18);
    }

    function _between(
        uint256 value,
        uint256 low,
        uint256 high
    ) internal pure returns (uint256) {
        return (low + (value % (high - low + 1)));
    }
}
