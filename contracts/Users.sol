pragma experimental ABIEncoderV2;

contract Users {

  enum Role { Member, Admin }
  uint public count = 0;

  struct User {
    uint id;
    Role role;
  }
  
  mapping(address => User) public users;

  function register(uint role) public {
    require(users[msg.sender].id >= 0, "User already registered");
    Role role = role == 1 ? Role.Admin : Role.Member;
    users[msg.sender] = User(count, role);
    count++;
  }
}