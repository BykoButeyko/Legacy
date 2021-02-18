pragma solidity =0.8.1;

contract Legacy {

    struct Beneficiary {
        uint prize;
        uint expiration;
        bool isRewarded;
    }
    
    mapping(address => Beneficiary) public beneficiaries;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addBeneficiary(address beneficiary, uint expiryDate) external payable {
        require(msg.sender == admin, 'only admin');
        require(beneficiaries[msg.sender].prize == 0, 'beneficiary already added');
        beneficiaries[beneficiary] = Beneficiary(msg.value, block.timestamp + expiryDate, false);
    }
    
    function withdraw() external {
        Beneficiary storage beneficiary = beneficiaries[msg.sender];
        require(beneficiary.expiration <= block.timestamp, 'too early');
        require(beneficiary.prize > 0, 'only beneficiary can withdraw');
        require(beneficiary.isRewarded == false, 'Rewarded already');
        beneficiary.isRewarded = true;
        payable(msg.sender).transfer(beneficiary.prize);
    }
}