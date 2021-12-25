pragma solidity >=0.4.22 <0.9.0;

contract Bank {

    mapping (address => uint256) balances;
    bool private _paused;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    //Allow to execute when contract is NOT paused
    modifier whenNotPaused() {
        require(_paused == false);
        _;
    }

    //Allow to execute when contract IS paused
    modifier whenPaused() {
        require(_paused == true);
        _;
    }

    constructor ()  {
        _paused = false;
    }

    function pause() public onlyOwner whenNotPaused {
        _paused = true;
    }

    function unpause() public onlyOwner whenPaused {
        _paused = false;
    }

    function withdrawAll() public payable whenNotPaused {
        require(balances[msg.sender] > 0);
        uint amountToWithdraw = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amountToWithdraw);
    }

    
}