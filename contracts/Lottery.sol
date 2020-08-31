pragma solidity  >=0.4.22 <0.7.0;
contract Lottery {
    address public manager;
    address[] public players;
    
    constructor() public {
        manager = msg.sender;
    }
    
    function enter() public payable{
        require(msg.value > 0.1 ether);
        players.push(msg.sender);
    }
    
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
    
    function pickWinner() public payable {
        uint index = randomGenerator() % players.length;
        players[index].transfer(this.balance);
       
      delete players;
    }
    
    function randomGenerator() private returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }
} 