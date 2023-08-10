// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract purchaseOrderContract{

    struct Order {
        uint256 id;
        string name;
        uint256 quantity;
        uint256 price; 
        address payable owner;
        string description;
        bool isAccepted;
    }

struct Bid{
    uint256 orderId;
    uint256 quantity;
    uint256 price;
    address bidder;
}

uint public orderCount;
mapping(uint256 => Order) public orders;
mapping(address => uint256) public supplierRating;
mapping(uint256 => Bid[]) public orderBids;

event OrderCreated(uint id, string name, uint quantity, uint price, address user);
event BidPlaced(uint orderId, uint bidId, uint price, uint rating, address supplier);
event BidAccepted(uint orderId, uint bidId, uint price, uint rating, address support);

function createOrder(string memory _name, uint256 _quantity, uint256 _price, string memory _description) public {
    orderCount++;
    orders[orderCount] = Order(orderCount, _name, _quantity, _price, payable(msg.sender), _description, false);
}

function placeBid(uint _orderId, uint256 _quantity, uint256 _price) public {
    require(_orderId > 0 && _orderId <= orderCount, "Invalid order ID");
    require(_quantity > 0, "Quantity must be greater than 0");
    require(_price > 0, "Price must be greater than 0");

    Bid memory newBid = Bid(_orderId, _quantity, _price, msg.sender);
    orderBids[_orderId].push(newBid);
}

function getOrder(uint256 _orderId) public view returns (Order memory){
     require(_orderId > 0 && _orderId <= orderCount, "Invalid orderID");
    return orders[_orderId];
     
}
function getBids(uint256 _orderId, uint256 _bidId) public view returns (Bid memory) {
    require(_orderId >= 0 && _orderId <= orderCount, "Invalid order ID");
    require(_bidId >= 0 && _bidId <= orderBids[_orderId].length, "Invalid bid ID");

    return orderBids[_orderId][_bidId];
}

function getOrderCount() public view returns(uint256){
    return orderCount;
}

function totalbidCount(uint _orderId) public view returns(uint256){
    
    return orderBids[_orderId].length;
    
    }

}