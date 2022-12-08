// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ReceiverUnstoppable} from "./ReceiverUnstoppable.sol";
import {IReceiver, UnstoppableLender} from "./UnstoppableLender.sol";
import {DamnValuableToken} from "../DamnValuableToken.sol";

contract EchidnaUnstoppableTest {
    // make sure that everything works before we start messing with the setup
    function testAlwaysPasses() public pure {
        assert(true);
    }

    /**
    Things that will be needed:
    - DamnValuableToken ERC20
    - Lending Pool
    - The receiver
    - (probably) a proxy contract representing the user
    - the attacker contract that will attack
     */
    DamnValuableToken damnValuableToken;
    UnstoppableLender unstoppableLender;
    ReceiverUnstoppable receiverUnstoppable;

    /*//////////////////////////////////////////////////////////////
                            INITIAL STATE SETUP
    //////////////////////////////////////////////////////////////*/
}
