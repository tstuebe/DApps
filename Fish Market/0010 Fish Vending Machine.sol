// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract FishMachine {
    // variables
    address public owner;
    address payable public supplier;

    // fish types are Ahi, Bream, and Chub
    mapping (address => uint) public balanceAhi;
    mapping (address => uint) public balanceBream;
    mapping (address => uint) public balanceChub;

    // set owner and initial stock in constuctor
    constructor() {
        owner = msg.sender;
        balanceAhi[address(this)] = 5;
        balanceBream[address(this)] = 10;
        balanceChub[address(this)] = 20;
    }
    
    // returns current fish stock
    function getMachineBalance() public view returns (uint, uint, uint) {
        return (balanceAhi[address(this)], 
            balanceBream[address(this)], 
            balanceChub[address(this)]);
    }

    // function assign supplier
    function assignSupplier(address payable newSupplier) public {
        supplier = newSupplier;
    }

    // following three functions restock fish to full capacity
    // only owner can restock and in doing so they send 5 ether to supplier (per fish type)
    function restockAhi() public {
        require(msg.sender == owner, "Only the owner of this fish machine can restock it.");
        supplier.transfer(5 ether);
        balanceAhi[address(this)] = 5;
    }

    function restockBream() public {
        supplier.transfer(5 ether);
        require(msg.sender == owner, "Only the owner of this fish machine can restock it.");
        balanceBream[address(this)] = 10;
    }

    function restockChub() public {
        supplier.transfer(5 ether);
        require(msg.sender == owner, "Only the owner of this fish machine can restock it.");
        balanceChub[address(this)] = 20;
    }

    // purchase fish from machine
    function purchaseAhi(uint amount) public payable {
        require(msg.value >= amount * 3 ether, "Each Ahi costs 3 ether.");
        require(balanceAhi[address(this)] >= amount, "We do not have enough Ahi to fulfill your order.");
        balanceAhi[address(this)] -= amount;
        balanceAhi[msg.sender] += amount;
    }

     function purchaseBream(uint amount) public payable {
        require(msg.value >= amount * 3 ether, "Each Bream costs 2 ether.");
        require(balanceBream[address(this)] >= amount, "We do not have enough Bream to fulfill your order.");
        balanceBream[address(this)] -= amount;
        balanceBream[msg.sender] += amount;
    }

     function purchaseChub(uint amount) public payable {
        require(msg.value >= amount * 3 ether, "Each Chub costs 1 ether.");
        require(balanceChub[address(this)] >= amount, "We do not have enough Chub to fulfill your order.");
        balanceChub[address(this)] -= amount;
        balanceChub[msg.sender] += amount;
    }


}

