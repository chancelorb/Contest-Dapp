pragma solidity ^0.5.0;

contract Generator {
    address public owner;
    struct User {
        uint        index;
        string      name;
        address[]   contests;
    }
    address[] public deployedContests;
    address[] public userIndex;
    mapping (address => User) public users;

    constructor() public payable {
        owner = msg.sender;
    }

    function createUser(string memory _name) public returns(bool) {
        users[msg.sender].index = userIndex.push(msg.sender) - 1;
        users[msg.sender].name = _name;
        return true;
    }
    
    function userExists(address _addressUser) public view returns(bool) {
        if (userIndex.length == 0) return false;
        return (userIndex[users[_addressUser].index] == _addressUser);
    }
    
    function createContest(string memory _title, uint[] memory _prizeAmounts) public {
        require(msg.sender == owner);
        deployedContests.push(new Contest(msg.sender, _title, _prizeAmounts));
    }
}

contract Contest {
    string public title;
    address public owner;
    uint[] public prizes;
    mapping (address => bool) public checkIfJudge;
    
    constructor(address _owner, string memory _title, uint[] memory _prizeAmount) public {
        owner = _owner;
        title = _title;
        for (uint i = 0; i < _prizeAmount.length; i++) {
            prizes.push(_prizeAmount[i]);
        }
    }
    
    function addJudge(address _judge) public returns(bool) {
        require(msg.sender == owner);
        checkIfJudge[_judge] = true; 
    }
}
