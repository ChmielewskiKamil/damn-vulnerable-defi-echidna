// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ReceiverUnstoppable, IERC20} from "./ReceiverUnstoppable.sol";
import {IReceiver, UnstoppableLender} from "./UnstoppableLender.sol";
import {DamnValuableToken} from "../DamnValuableToken.sol";

contract EchidnaUnstoppableTest {
    // make sure that everything works before we start messing with the setup
    // function testAlwaysPasses() public pure {
    //     assert(true);
    // }

    /**
    Things that will be needed:
    - DamnValuableToken ERC20
    - Lending Pool
    - The receiver
    - (probably) a proxy contract representing the user
    - the attacker contract that will attack

    UPDATE: it turns out that it is possible to change the deployer / sender
    so we can use the EchidnaTest contract as an attacker
     */
    DamnValuableToken damnValuableToken;
    UnstoppableLender unstoppableLender;
    ReceiverUnstoppable receiverUnstoppable;

    /*//////////////////////////////////////////////////////////////
                                DEBUG EVENTS    
    //////////////////////////////////////////////////////////////*/

    event TokenBalance(address balanceOwner, uint256 tokenAmount);
    event WhoIsCalling(address caller);

    /*//////////////////////////////////////////////////////////////
                            INITIAL STATE SETUP
    //////////////////////////////////////////////////////////////*/

    constructor() {
        // the address that deploys the DamnValuableToken
        // gets uint256.max tokens -> it will be the test contract
        damnValuableToken = new DamnValuableToken();
        emit TokenBalance(
            address(this),
            damnValuableToken.balanceOf(address(this))
        );

        unstoppableLender = new UnstoppableLender(address(damnValuableToken));

        // this might be actually messed up because the owner of the receiver
        // is the msg.sender -> the test contract
        // UPDATE it is possible to set sender and deployer
        receiverUnstoppable = new ReceiverUnstoppable(
            address(unstoppableLender)
        );

        // Sending tokens to the pool
        damnValuableToken.approve(address(unstoppableLender), 1000000e18);
        unstoppableLender.depositTokens(1000000e18);
        // sending tokens to the attacker
        damnValuableToken.transfer(msg.sender, 100e18);
    }

    // Pool will call this function during the flash loan
    function receiveTokens(address tokenAddress, uint256 amount) external {
        require(
            msg.sender == address(unstoppableLender),
            "Sender must be pool"
        );
        // Return all tokens to the pool
        require(
            IERC20(tokenAddress).transfer(msg.sender, amount),
            "Transfer of tokens failed"
        );
    }

    function echidna_flashLoanAlwaysAvailable() public returns (bool) {
        emit WhoIsCalling(msg.sender);
        unstoppableLender.flashLoan(10);
        return true;
    }
}
