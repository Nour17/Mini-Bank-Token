pragma solidity >= 0.4.22 < 0.6.0;

interface ERC20 {
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
