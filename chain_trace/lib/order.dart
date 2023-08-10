class order{
  int id;
  String name;
  int quantity;
  int price;
  String address;
  String description;
  String isAccepted;
  order({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.address,
    required this.description,
    required this.isAccepted
});
}