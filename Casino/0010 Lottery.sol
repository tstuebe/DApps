// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract lottery {

    // variables
    address public owner;
    address payable[] public entries;
    // struct playerProfile {
    //     address name,
    //     uint numberOfEntries
    // }

    // set owner
    constructor() {
        owner = msg.sender;
    }

    // keep track of player entries
    mapping(address => uint) playerEntriesAmount;

    // restrict function to owner modifier
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // function for players to enter the lottery
    function enter() public payable {
        require(msg.value >= 1 ether, "Each entry costs 1 Ether.");
        entries.push(payable(msg.sender));
        playerEntriesAmount[msg.sender]++;
    }

    // function to create a random number
    function rng() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    // function to select winner
    function selectWinner() public onlyOwner {
        // calls rng to choose index
        uint index = rng() % entries.length;
        // matches index to player and transfers balance to winner
        entries[index].transfer(address(this).balance);
        // resets contract
        entries = new address payable[](0);
    }

    // function to give player their chances of winning
    function playerOdds() public view returns (uint) {
        return uint((100 * playerEntriesAmount[msg.sender]) / entries.length);
    }

    function generalOdds() public view returns (uint) {
        return uint(100 / entries.length);
    }

    // function to get prize size
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // functions to show amount of entries and player list
    function getEntries() public view returns (uint) {
        return entries.length;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return entries;
    }
}
