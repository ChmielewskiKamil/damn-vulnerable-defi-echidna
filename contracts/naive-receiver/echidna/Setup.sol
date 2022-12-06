// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../FlashLoanReceiver.sol";
import "../NaiveReceiverLenderPool.sol";

contract Setup {
    NaiveReceiverLenderPool naiveReceiverLenderPool;
    FlashLoanReceiver flashLoanReceiver;

    constructor() public {
        naiveReceiverLenderPool = new NaiveReceiverLenderPool();
        flashLoanReceiver = new FlashLoanReceiver(
            payable(address(naiveReceiverLenderPool))
        );
    }

    function _between(
        uint256 value,
        uint256 low,
        uint256 high
    ) internal pure returns (uint256) {
        return (low + (value % (high - low + 1)));
    }
}
