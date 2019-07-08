pragma solidity >= 0.4.22 < 0.6.0;

interface ERC223 {
    function transfer(address to, uint value, bytes calldata data) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value, bytes data);
}       
