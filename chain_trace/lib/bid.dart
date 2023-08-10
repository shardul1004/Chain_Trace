// struct Bid{
// uint256 orderId;
// uint256 quantity;
// uint256 price;
// address bidder;
// bool isaccepted;
// }
class bid{
  int orderId;
  int quantity;
  int price;
  String address;
  String isaccepted;
  bid({
    required this.address,
    required this.price,
    required this.quantity,
    required this.isaccepted,
    required this.orderId
});
}