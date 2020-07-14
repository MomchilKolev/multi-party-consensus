pragma experimental ABIEncoderV2;

contract Users {

  bool operational = true;
  address owner;

  enum Role { Member, Admin }
  uint public count = 0;

  struct User {
    uint id;
    Role role;
  }
  
  mapping(address => User) public users;

  constructor() public {
    owner = msg.sender;
  }

  modifier checkOwner() {
    require(msg.sender == owner, "Only owner can change contract operational status");
    _;
  }

  modifier isOperational() {
    require(operational == true, "Contract is not operational");
    _;
  }

  function setOperational(bool value) checkOwner public {
    operational = value;
  }

  function register(uint role) isOperational public {
    require(users[msg.sender].id >= 0, "User already registered");
    Role role = role == 1 ? Role.Admin : Role.Member;
    users[msg.sender] = User(count, role);
    count++;
  }
}