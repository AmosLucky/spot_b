import 'package:spotstock_inventory/common/utils/role_detector.dart';

extension UserDetailsExtension on UserDetails {
  String get userRole => RoleDetector.determineUserRole(this);
  bool get isHotelAdmin => RoleDetector.isHotelAdmin(this);
  bool get isStoreAdmin => RoleDetector.isStoreAdmin(this);
  bool get isSuperAdmin => RoleDetector.isSuperAdmin(this);
  bool get isStoreStaff => RoleDetector.isStoreStaff(this);
  bool get isHotelStaff => RoleDetector.isHotelStaff(this);
  bool get isAnyAdmin => RoleDetector.isAnyAdmin(this);
  bool get isAnyStaff => RoleDetector.isAnyStaff(this);
  bool get canAccessHotel => RoleDetector.canAccessHotel(this);
  bool get canAccessStore => RoleDetector.canAccessStore(this);
  bool get hasPosPermissions => RoleDetector.hasPosPermissions(this);
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
  final int isAdmin;
  final int isSuper;
  final String? warehouseId;
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
    this.isAdmin = 0,
    this.isSuper = 0,
    this.warehouseId,
    required this.company,
    required this.role,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    // Add null safety checks and provide default values
    return UserDetails(
      id: json['id'] ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      defaultPassword: json['default_password']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      status: json['status'] ?? 0,
      language: json['language']?.toString() ?? 'en',
      isAdmin: json['is_admin'] ?? 0,
      isSuper: json['is_super'] ?? 0,
      warehouseId: json['warehouse_id']?.toString(),
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      token: json['token']?.toString() ?? '',
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
      'is_admin': isAdmin,
      'is_super': isSuper,
      'warehouse_id': warehouseId,
      'company': company?.toJson(),
      'role': role?.toJson(),
      'token': token
    };
  }

  List<int> get warehouseIds {
    if (warehouseId == null || warehouseId!.isEmpty) return [];
        
    try {
      String cleanString = warehouseId!.replaceAll('[', '').replaceAll(']', '');
      if (cleanString.isEmpty) return [];
            
      return cleanString
          .split(',')
          .map((id) => int.tryParse(id.trim()) ?? 0)
          .where((id) => id > 0)
          .toList();
    } catch (e) {
      print("Error parsing warehouse IDs: $e");
      return [];
    }
  }
}

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
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
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
    var permissionsFromJson = json['permissions'] as List? ?? [];
    List<PermissionModel> permissionsList =
        permissionsFromJson.map((i) => PermissionModel.fromJson(i)).toList();

    return Role(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? '',
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
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? '',
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






// import 'package:spotstock_inventory/common/utils/role_detector.dart';

// extension UserDetailsExtension on UserDetails {
//   String get userRole => RoleDetector.determineUserRole(this);
//   bool get isHotelAdmin => RoleDetector.isHotelAdmin(this);
//   bool get isStoreAdmin => RoleDetector.isStoreAdmin(this);
//   bool get isSuperAdmin => RoleDetector.isSuperAdmin(this);
//   bool get isStoreStaff => RoleDetector.isStoreStaff(this);
//   bool get isHotelStaff => RoleDetector.isHotelStaff(this);
//   bool get isAnyAdmin => RoleDetector.isAnyAdmin(this);
//   bool get isAnyStaff => RoleDetector.isAnyStaff(this);
//   bool get canAccessHotel => RoleDetector.canAccessHotel(this);
//   bool get canAccessStore => RoleDetector.canAccessStore(this);
//   bool get hasPosPermissions => RoleDetector.hasPosPermissions(this);
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
//   final int isAdmin;
//   final int isSuper;
//   final String? warehouseId; // Added: Store warehouse_id from login response
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
//     this.isAdmin = 0,
//     this.isSuper = 0,
//     this.warehouseId, // Added: warehouse_id field
//     required this.company,
//     required this.role,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       id: json['id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       email: json['email'],
//       phone: json['phone'],
//       defaultPassword: json['default_password'] ?? "",
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       status: json['status'],
//       language: json['language'],
//       isAdmin: json['is_admin'] ?? 0,
//       isSuper: json['is_super'] ?? 0,
//       warehouseId: json['warehouse_id']?.toString(), // Added: Parse warehouse_id
//       company: json['company'] != null ? Company.fromJson(json['company']) : null,
//       role: json['role'] != null ? Role.fromJson(json['role']) : null,
//       token: json['token'],
//     );
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
//       'is_admin': isAdmin,
//       'is_super': isSuper,
//       'warehouse_id': warehouseId, // Added: Include warehouse_id in JSON
//       'company': company?.toJson(),
//       'role': role?.toJson(),
//       'token': token
//     };
//   }

//   // Helper method to get warehouse IDs as a list
//   List<int> get warehouseIds {
//     if (warehouseId == null || warehouseId!.isEmpty) return [];
    
//     try {
//       // Remove brackets and parse the comma-separated values
//       String cleanString = warehouseId!.replaceAll('[', '').replaceAll(']', '');
//       if (cleanString.isEmpty) return [];
      
//       return cleanString
//           .split(',')
//           .map((id) => int.tryParse(id.trim()) ?? 0)
//           .where((id) => id > 0)
//           .toList();
//     } catch (e) {
//       print("Error parsing warehouse IDs: $e");
//       return [];
//     }
//   }
// }

// class Company {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String address;
//   final String logo;
//   final double? amount;

//   Company({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.logo,
//     this.amount,
//   });

//   factory Company.fromJson(Map<String, dynamic> json) {
//     return Company(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       phone: json['phone'],
//       address: json['address'],
//       logo: json['logo'],
//       amount: json['amount']?.toDouble(),
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
//       'amount': amount,
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