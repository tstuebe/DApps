// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/*  This contract contains a function for each odds bracket of roulette bets.
    This results in the bets of similar odds to call the same function, meaning
    that the front end will need to create an illusion of choice for each bet
    while in reality, they will just be choosing an odds bracket. Although the
    game will be mathematically equivalent to a game with true choice, players
    may feel misled unless provided a proficient disclaimer on the games interface.
*/

contract Roulette {

    address payable public owner;
    address payable public player;

    // constructor to set owner
    constructor() {
        owner = payable(msg.sender);
    }

    // modifier to restrict to owner
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // modifier setBet() {
    //     uint bet = msg.value;
    //     _;
    // }

    // pseudorandom number generator (will use chainlink when deployed to testnet)
    function getRandomNumber() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(address(this).balance, block.timestamp, block.difficulty)));
    }

    /*  odds functions:
        Note that actual roulette odds do not match up with
        the payouts due to the possibility of rolling 0 or 00.
        (Zero is neither odd nor even in roulette)
    */

    function A_oneToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 18) {
            payable(msg.sender).transfer(bet * 2 ether);
        }
        else {}
    }

    function B_twoToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 12) {
            payable(msg.sender).transfer(bet * 3 ether);
        }
        else {}
    }

    function C_fiveToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 6) {
            payable(msg.sender).transfer(bet * 6 ether);
        }
        else {}
    }

    function D_eightToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 4) {
            payable(msg.sender).transfer(bet * 9 ether);
        }
        else {}
    }

    function E_elevenToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 3) {
            payable(msg.sender).transfer(bet * 12 ether);
        }
        else {}
    }

    function F_seventeenToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 2) {
            payable(msg.sender).transfer(bet * 18 ether);
        }
        else {}
    }

    function G_thirtyfiveToOne(uint bet) payable public {
        require(msg.value == bet * 1 ether);
        uint determinant = getRandomNumber() % 38;
        if (determinant < 1) {
            payable(msg.sender).transfer(bet * 36 ether);
        }
        else {}
    }

    // owner deposit and withdraw functions
    function H_deposit() payable public onlyOwner() {}

    function I_withdraw(uint amount) public onlyOwner() {
        owner.transfer(amount * 1 ether);
    }

    // get balance function (restricted to owner)
    function J_getBalance() public view onlyOwner() returns (uint) {
        return address(this).balance;
    }
    
}
