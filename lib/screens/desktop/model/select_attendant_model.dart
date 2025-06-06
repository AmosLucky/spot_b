import 'package:flutter/material.dart';

class SelectAttendantModel {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String phone;
  final String department;
  final bool hasPinSet;

  SelectAttendantModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.department,
    required this.hasPinSet,
  }) : fullName = '$firstName $lastName';

  factory SelectAttendantModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final role = attributes['role']?.isNotEmpty == true
        ? attributes['role'][0]['display_name']
        : 'No Department';
    return SelectAttendantModel(
      id: int.parse(json['id'].toString()),
      firstName: attributes['first_name'] ?? '',
      lastName: attributes['last_name'] ?? '',
      email: attributes['email'] ?? '',
      phone: attributes['phone'] ?? '',
      department: role,
      hasPinSet: attributes['set_pin'] ?? false,
    );
  }
}


// import 'package:flutter/material.dart';

// class SelectAttendantModel {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String fullName;
//   final String email;
//   final String phone;
//   final String department;
//   final String pin;
//   final bool hasPinSet;

//   SelectAttendantModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.department,
//     required this.pin,
//     this.hasPinSet = true,
//   }) : fullName = '$firstName $lastName';

//   factory SelectAttendantModel.fromJson(Map<String, dynamic> json) {
//     final attributes = json['attributes'];
//     final role = attributes['role']?.isNotEmpty == true
//         ? attributes['role'][0]['display_name']
//         : 'No Department';
//     return SelectAttendantModel(
//       id: int.parse(json['id'].toString()),
//       firstName: attributes['first_name'] ?? '',
//       lastName: attributes['last_name'] ?? '',
//       email: attributes['email'] ?? '',
//       phone: attributes['phone'] ?? '',
//       department: role,
//       pin: attributes['pin']?.toString() ?? '',
//       hasPinSet: attributes['pin'] != null && attributes['pin'].toString().isNotEmpty,
//     );
//   }
// }