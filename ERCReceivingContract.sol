pragma solidity >= 0.4.22 < 0.6.0;

contract ERC223ReceivingContract {
    function tokenFallback(address _from, uint _tokens, bytes memory _data) public;
}
