pragma solidity =0.8.1;

contract Legacy {
    mapping(address => uint) public checkout;
    mapping(address => uint) public expiration;
    mapping(address => bool) public rewarded;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addSuccessor(address successor, uint expiryDate) external payable {
        require(msg.sender == admin, 'only admin');
        require(checkout[msg.sender] == 0, 'successor already added');
        checkout[successor] = msg.value;
        expiration[successor] = block.timestamp + expiryDate;
    }
    

    function withdraw() external {
        require(expiration[msg.sender] <= block.timestamp, 'too early');
        require(checkout[msg.sender] > 0, 'only successor can withdraw');
        require(rewarded[msg.sender] == false, 'rewarded already');
        rewarded[msg.sender] = true;
        payable(msg.sender).transfer(checkout[msg.sender]);
    }
}