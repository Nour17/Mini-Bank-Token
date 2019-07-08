pragma solidity >= 0.4.22 < 0.6.0;

import "./TokenCredentials.sol";
import "./ERC20.sol";
import "./ERC223.sol";
import "./ERC223ReceivingContract.sol";
import "./SafeMath.sol";

contract MiniBankToken is TokenCredentials("Mini Bank Token", "MBT", 18, 1000000), ERC20, ERC223 {
    using SafeMath for uint;
     
    modifier acceptableTransfer(uint amount) {
        require(_Balances[msg.sender] >= amount &&
                amount > 0);
        _;
    }
    
    modifier acceptableTransferFrom(address _from, uint amount) {
        require(_Balances[_from] >= amount &&
                _Allowances[_from][msg.sender] >= amount &&
                amount > 0);
        _;
    }
    
    function isContract(address _address) public view returns(bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(_address)
        }
        return codeSize > 0;
    }
    
    function balanceOf(address tokenOwner) public view returns(uint) {
        return _Balances[tokenOwner];
    }
    
    function transfer(address to, uint tokens) public acceptableTransfer(tokens) returns (bool success){
        if(!isContract(to)) {
            _Balances[msg.sender] = _Balances[msg.sender].sub(tokens);
            _Balances[to] = _Balances[to].add(tokens);
            
            emit Transfer(msg.sender, to, tokens);
            return true;
        }
        return false;
    }
    
    function transfer(address to, uint tokens, bytes memory data) public acceptableTransfer(tokens) returns (bool) {
        if(isContract(to)) {
            _Balances[msg.sender] = _Balances[msg.sender].sub(tokens);
            _Balances[to] = _Balances[to].add(tokens);
            ERC223ReceivingContract _contract = ERC223ReceivingContract(to);
            _contract.tokenFallback(msg.sender, tokens, data);
            emit Transfer(msg.sender, to, tokens, data);
            return true;
        }
        return false;
    }
    
    function transferFrom(address _from, address to, uint tokens) public acceptableTransferFrom(_from, tokens) returns (bool success) {
        _Balances[_from] = _Balances[_from].sub(tokens);
        _Allowances[_from][msg.sender] = _Allowances[_from][msg.sender].sub(tokens);
        _Balances[to] = _Balances[to].add(tokens);
        
        emit Transfer(_from, to, tokens);
        return true;
    }
    
    
    function approve(address spender, uint tokens) public acceptableTransfer(tokens) returns (bool success) {
        _Allowances[msg.sender][spender] = _Allowances[msg.sender][spender].add(tokens);
        
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return _Allowances[tokenOwner][spender];
    }
}
