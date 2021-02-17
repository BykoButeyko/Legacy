pragma solidity =0.8.1;

contract Legacy {
    mapping(address => uint) public checkouts;
    mapping(address => uint) public expiration;

    function addSuccessor(address kid, uint expiryDate) external payable {
        checkouts[successor] = msg.value;
        expiration[successor] = block.timestamp + expiryDate;
    }
    

    function withdraw() external {
        require(expiration[msg.sender] <= block.timestamp, 'too early');
        require(checkouts[msg.sender] > 0, 'only successor can withdraw');
        payable(msg.sender).transfer(checkouts[msg.sender]);
    }
}