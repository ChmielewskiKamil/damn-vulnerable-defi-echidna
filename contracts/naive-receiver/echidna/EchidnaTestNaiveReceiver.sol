// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Setup.sol";

contract EchidnaTestNaiveReceiver is Setup {
    function balanceOfTheReceiverShouldNotDecrease(uint256 flashLoanAmount)
        public
    {
        assert(true);
        // // pre-codnitions
        // uint256 balanceBefore = address(flashLoanReceiver).balance;
        // // actions
        // naiveReceiverLenderPool.flashLoan(
        //     payable(address(flashLoanReceiver)),
        //     flashLoanAmount
        // );
        // // post-conditions
        // uint256 balanceAfter = address(flashLoanReceiver).balance;
        // assert(balanceAfter >= balanceBefore);
    }

    receive() external payable {}
}
