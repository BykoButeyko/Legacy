pragma solidity =0.8.1;

contract Legacy {
    address public successor;
    uint public expiration;

    constructor(address _successor, uint timeToMaturity) payable {
        maturity = block.timestamp + expiry;
        successor = _successor;
    }

    function withdraw() external {
        require(block.timestamp >= expiration, 'too early');
        require(msg.sender == successor, 'only successor can withdraw');
        payable(msg.sender).transfer(address(this).balance);
    }
}