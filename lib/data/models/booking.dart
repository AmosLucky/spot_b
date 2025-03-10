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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product'] = room;
    _data['trackID'] = trackID;
    _data['totalAmount'] = totalAmount;
    _data['quantity'] = quantity;
    return _data;
  }
}
