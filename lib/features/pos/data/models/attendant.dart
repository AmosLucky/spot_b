import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendant.freezed.dart';

@freezed
class Attendant with _$Attendant {
  const factory Attendant({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? image,
    DateTime? createdAt,
    int? isAdmin,
    int? isSuper,
    int? isAttendant,
    bool? setPin,
    String? link,
  }) = _Attendant;

  factory Attendant.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final links = json['links'];

    return Attendant(
      id: int.tryParse(json['id'].toString()),
      firstName: attributes['first_name'],
      lastName: attributes['last_name'],
      email: attributes['email'],
      phone: attributes['phone'],
      image: attributes['image'],
      createdAt:
          attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
      isAdmin: attributes['is_admin'],
      isSuper: attributes['is_super'],
      isAttendant: attributes['is_attendant'],
      setPin: attributes['set_pin'],
      link: links['self'],
    );
  }
}
