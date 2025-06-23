class CartModel {
  CartModel(
      {this.product,
      this.trackID,
      this.id,
      this.totalAmount,
      required this.quantity});
  Map? product;
  String? trackID;
  int? id;
  String? tableID;
  int? totalAmount;
  late int quantity;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    trackID = json['trackID'];
    tableID = json['tableID'];
    totalAmount = json['totalAmount'];
    quantity = json['quantity'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    data['trackID'] = trackID;
    data['totalAmount'] = totalAmount;
    data['quantity'] = quantity;
    return data;
  }
}