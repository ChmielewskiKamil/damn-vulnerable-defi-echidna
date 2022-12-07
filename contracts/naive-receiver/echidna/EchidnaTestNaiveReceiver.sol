// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../FlashLoanReceiver.sol";
import "../NaiveReceiverLenderPool.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract EchidnaTestNaiveReceiver {
    using Address for address payable;
    NaiveReceiverLenderPool naiveReceiverLenderPool;
    FlashLoanReceiver flashLoanReceiver;
    event BorrowerBalance(uint256 balance);

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

    function balanceOfTheReceiverShouldNotDecrease(uint256 flashLoanAmount)
        public
    {
        // pre-codnitions
        uint256 balanceBefore = address(flashLoanReceiver).balance;
        emit BorrowerBalance(balanceBefore);
        // actions
        naiveReceiverLenderPool.flashLoan(
            payable(address(flashLoanReceiver)),
            flashLoanAmount
        );
        // post-conditions
        uint256 balanceAfter = address(flashLoanReceiver).balance;
        emit BorrowerBalance(balanceAfter);
        assert(balanceAfter >= balanceBefore);
    }
}
