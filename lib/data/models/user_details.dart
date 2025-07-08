import 'package:spotstock_inventory/common/utils/role_detector.dart';

extension UserDetailsExtension on UserDetails {
  String get userRole => RoleDetector.determineUserRole(this);
  bool get isHotelAdmin => RoleDetector.isHotelAdmin(this);
  bool get isStoreAdmin => RoleDetector.isStoreAdmin(this);
  bool get isSuperAdmin => RoleDetector.isSuperAdmin(this);
  bool get isStoreStaff => RoleDetector.isStoreStaff(this);
}

class UserDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String defaultPassword;
  final String createdAt;
  final String updatedAt;
  final String token;
  final int status;
  final String language;
  final int isAdmin; // Add this field
  final int isSuper; // Add this field
  final Company? company;
  final Role? role;

  UserDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.defaultPassword,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.token,
    required this.language,
    this.isAdmin = 0, // Make optional with default value
    this.isSuper = 0, // Make optional with default value
    required this.company,
    required this.role,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      defaultPassword: json['default_password'] ?? "",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      language: json['language'],
      isAdmin: json['is_admin'] ?? 0, // Add this line
      isSuper: json['is_super'] ?? 0, // Add this line
      company: Company.fromJson(json['company']),
      role: Role.fromJson(json['role']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'default_password': defaultPassword,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
      'language': language,
      'is_admin': isAdmin, // Add this line
      'is_super': isSuper, // Add this line
      'company': company!.toJson(),
      'role': role!.toJson(),
      'token': token
    };
  }
}

// Keep existing Company, Role, and PermissionModel classes unchanged
class Company {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String logo;
  final double? amount;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.logo,
    this.amount,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      logo: json['logo'],
      amount: json['amount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'logo': logo,
      'amount': amount,
    };
  }
}

class Role {
  final int id;
  final String name;
  final String displayName;
  final List<PermissionModel> permissions;

  Role({
    required this.id,
    required this.name,
    required this.displayName,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    var permissionsFromJson = json['permissions'] as List;
    List<PermissionModel> permissionsList =
        permissionsFromJson.map((i) => PermissionModel.fromJson(i)).toList();

    return Role(
      id: json['id'],
      name: json['name'],
      displayName: json['display_name'],
      permissions: permissionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display_name': displayName,
      'permissions': permissions.map((e) => e.toJson()).toList(),
    };
  }
}

class PermissionModel {
  final int id;
  final String name;
  final String displayName;

  PermissionModel({
    required this.id,
    required this.name,
    required this.displayName,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'],
      name: json['name'],
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display_name': displayName,
    };
  }
}






// // Add this extension to your existing UserDetails class
// import 'package:spotstock_inventory/common/utils/role_detector.dart';

// extension UserDetailsExtension on UserDetails {
//   String get userRole => RoleDetector.determineUserRole(this);
//   bool get isHotelAdmin => RoleDetector.isHotelAdmin(this);
//   bool get isStoreAdmin => RoleDetector.isStoreAdmin(this);
//   bool get isSuperAdmin => RoleDetector.isSuperAdmin(this);
// }


// class UserDetails {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//   final String defaultPassword;
//   final String createdAt;
//   final String updatedAt;
//   final String token;
//   final int status;
//   final String language;
//   final Company? company;
//   final Role? role;

//   UserDetails({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.defaultPassword,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.status,
//     required this.token,
//     required this.language,
//     required this.company,
//     required this.role,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//         id: json['id'],
//         firstName: json['first_name'],
//         lastName: json['last_name'],
//         email: json['email'],
//         phone: json['phone'],
//         defaultPassword: json['default_password'] ?? "",
//         createdAt: json['created_at'],
//         updatedAt: json['updated_at'],
//         status: json['status'],
//         language: json['language'],
//         company: Company.fromJson(json['company']),
//         role: Role.fromJson(json['role']),
//         token: json['token']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'first_name': firstName,
//       'last_name': lastName,
//       'email': email,
//       'phone': phone,
//       'default_password': defaultPassword,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'status': status,
//       'language': language,
//       'company': company!.toJson(),
//       'role': role!.toJson(),
//       'token': token
//     };
//   }
// }

// class Company {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String address;
//   final String logo;
//   final double? amount; // Add this field

//   Company({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.logo,
//     this.amount, // Add this parameter
//   });

//   factory Company.fromJson(Map<String, dynamic> json) {
//     return Company(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       phone: json['phone'],
//       address: json['address'],
//       logo: json['logo'],
//       amount: json['amount']?.toDouble(), // Add this line
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'address': address,
//       'logo': logo,
//       'amount': amount, // Add this line
//     };
//   }
// }

// class Role {
//   final int id;
//   final String name;
//   final String displayName;
//   final List<PermissionModel> permissions;

//   Role({
//     required this.id,
//     required this.name,
//     required this.displayName,
//     required this.permissions,
//   });

//   factory Role.fromJson(Map<String, dynamic> json) {
//     var permissionsFromJson = json['permissions'] as List;
//     List<PermissionModel> permissionsList =
//         permissionsFromJson.map((i) => PermissionModel.fromJson(i)).toList();

//     return Role(
//       id: json['id'],
//       name: json['name'],
//       displayName: json['display_name'],
//       permissions: permissionsList,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'display_name': displayName,
//       'permissions': permissions.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// class PermissionModel {
//   final int id;
//   final String name;
//   final String displayName;

//   PermissionModel({
//     required this.id,
//     required this.name,
//     required this.displayName,
//   });

//   factory PermissionModel.fromJson(Map<String, dynamic> json) {
//     return PermissionModel(
//       id: json['id'],
//       name: json['name'],
//       displayName: json['display_name'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'display_name': displayName,
//     };
//   }
// }