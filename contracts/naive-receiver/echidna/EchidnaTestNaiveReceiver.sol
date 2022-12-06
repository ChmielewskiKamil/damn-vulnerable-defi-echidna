// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Setup.sol";

contract EchidnaTestNaiveReceiver is Setup {
    function testAlwaysFail() public pure {
        assert(false);
    }
}
