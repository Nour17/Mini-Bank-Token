pragma solidity >= 0.4.22 < 0.6.0;

contract TokenCredentials {
    string internal _name;
    string internal _symbol;
    uint internal _decimals;
    uint internal _totalSupply;
    
    mapping (address => uint) _Balances;
    mapping (address => mapping (address => uint)) _Allowances;
    
    constructor (string memory name, string memory symbol, uint decimals, uint totalSupply) public{
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _totalSupply = totalSupply;
        _Balances[msg.sender] = _totalSupply;
    }
    
    function getName() internal view returns(string memory) {
        return _name;
    }
    
    function getSymbol() internal view returns(string memory) {
        return _symbol;
    }
    
    function getDecimals() internal view returns(uint) {
        return _decimals;
    }
    
    function totalSupply() internal view returns(uint) {
        return _totalSupply;
    }
    
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function transfer(address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
}
