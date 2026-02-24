import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    int? id,
    String? name,
    int? companyId,
    String? email,
    String? phone,
    String? country,
    String? city,
    String? address,
    DateTime? createdAt,
    String? link,
    bool? isSynced,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final links = json['links'];

    return Customer(
      id: int.tryParse(json['id'].toString()),
      name: attributes['name'],
      companyId: attributes['company_id'],
      email: attributes['email'],
      phone: attributes['phone'],
      country: attributes['country'],
      city: attributes['city'],
      address: attributes['address'],
      createdAt: attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
      link: links['self'],
    );
  }
}
