class BookingModel {
  BookingModel(
      {this.room,
        this.trackID,
        this.id,
        this.totalAmount,
        required this.quantity});
  Map? room;
  String? trackID;
  int? id;
  String? tableID;
  int? totalAmount;
  late int quantity;

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    room = json['room'];
    trackID = json['trackID'];
    tableID = json['tableID'];
    totalAmount = json['totalAmount'];
    quantity = json['quantity'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = room;
    data['trackID'] = trackID;
    data['totalAmount'] = totalAmount;
    data['quantity'] = quantity;
    return data;
  }
}
