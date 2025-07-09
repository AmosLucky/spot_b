import 'package:spotstock_inventory/data/models/user_details.dart';

class RoleDetector {
  static const String ROLE_HOTEL_ADMIN = 'hotel_admin';
  static const String ROLE_STORE_ADMIN = 'store_admin';
  static const String ROLE_SUPER_ADMIN = 'super_admin';
  static const String ROLE_HOTEL_STAFF = 'hotel_staff';
  static const String ROLE_STORE_STAFF = 'store_staff';

  /// Primary method to determine user role with improved logic
  static String determineUserRole(UserDetails user) {
    print('=== ROLE DETECTION DEBUG ===');
    print('User ID: ${user.id}');
    print('User Email: ${user.email}');
    print('Company Name: ${user.company?.name}');
    print('Company ID: ${user.company?.id}');
    print('is_admin: ${user.isAdmin}');
    print('is_super: ${user.isSuper}');
    print('Role Name: ${user.role?.name}');
    
    // Check for super admin first - must be BOTH company owner AND admin
    if (_isSuperAdmin(user)) {
      print('Detected as: SUPER_ADMIN');
      return ROLE_SUPER_ADMIN;
    }
    
    // Check if user is admin (is_admin = 1)
    if (user.isAdmin == 1) {
      // Determine if hotel or store admin based on permissions
      if (_hasHotelPermissions(user)) {
        print('Detected as: HOTEL_ADMIN');
        return ROLE_HOTEL_ADMIN;
      } else {
        print('Detected as: STORE_ADMIN');
        return ROLE_STORE_ADMIN;
      }
    }
    
    // For staff members (is_admin = 0), check their permissions
    if (_hasHotelPermissions(user)) {
      print('Detected as: HOTEL_STAFF');
      return ROLE_HOTEL_STAFF;
    } else {
      print('Detected as: STORE_STAFF');
      return ROLE_STORE_STAFF;
    }
  }

  /// Check if user is super admin (company who developed the software)
  /// Must be both from the developer company AND have admin privileges
  static bool _isSuperAdmin(UserDetails user) {
    // Super admin must have admin privileges (is_admin = 1)
    if (user.isAdmin != 1) {
      return false;
    }
    
    // Check for specific super admin email (the actual company owner)
    if (user.email == '247okolo@gmail.com') {
      return true;
    }
    
    // Check company name patterns for super admin company
    if (user.company?.name != null) {
      final companyName = user.company!.name.toUpperCase();
      // Only if user is admin AND from the developer company
      if ((companyName.contains('SPOT STOCK MANAGER') ||
           companyName.contains('INVENTORY SOFTWARE') ||
           companyName.contains('SPOT STOCK')) && user.isAdmin == 1) {
        // Additional check: make sure it's the actual owner, not just an employee
        return user.email == '247okolo@gmail.com' || 
               user.email.contains('spotstockinventory.com');
      }
    }
    
    return false;
  }

  /// Check if user has hotel-specific permissions
  static bool _hasHotelPermissions(UserDetails user) {
    if (user.role?.permissions == null) return false;
    
    final permissionNames = user.role!.permissions.map((p) => p.name).toList();
    
    // Hotel-specific permissions
    return permissionNames.contains('manage_rooms') ||
           permissionNames.contains('manage_facility') ||
           permissionNames.contains('manage_realestate') ||
           permissionNames.contains('manage_tables'); // Tables are often hotel-related
  }

  /// Check if user has POS permissions (for both store staff and admins)
  static bool hasPosPermissions(UserDetails user) {
    if (user.role?.permissions == null) return false;
    
    final permissionNames = user.role!.permissions.map((p) => p.name).toList();
    return permissionNames.contains('manage_pos_screen');
  }

  /// Check if user can access hotel features
  /// Only hotel admins, hotel staff, and super admins can access hotel features
  static bool canAccessHotel(UserDetails user) {
    final role = determineUserRole(user);
    return role == ROLE_SUPER_ADMIN || 
           role == ROLE_HOTEL_ADMIN || 
           role == ROLE_HOTEL_STAFF;
  }

  /// Check if user can access store/inventory features
  /// Store admins, store staff with POS permissions, and super admins can access store features
  static bool canAccessStore(UserDetails user) {
    final role = determineUserRole(user);
    
    // Super admin can access everything
    if (role == ROLE_SUPER_ADMIN) {
      return true;
    }
    
    // Store admin can access store features
    if (role == ROLE_STORE_ADMIN) {
      return true;
    }
    
    // Store staff can access if they have POS permissions
    if (role == ROLE_STORE_STAFF) {
      return hasPosPermissions(user);
    }
    
    return false;
  }

  /// Convenience methods
  static bool isHotelAdmin(UserDetails user) {
    return determineUserRole(user) == ROLE_HOTEL_ADMIN;
  }

  static bool isStoreAdmin(UserDetails user) {
    return determineUserRole(user) == ROLE_STORE_ADMIN;
  }

  static bool isSuperAdmin(UserDetails user) {
    return determineUserRole(user) == ROLE_SUPER_ADMIN;
  }
  
  static bool isStoreStaff(UserDetails user) {
    return determineUserRole(user) == ROLE_STORE_STAFF;
  }

  static bool isHotelStaff(UserDetails user) {
    return determineUserRole(user) == ROLE_HOTEL_STAFF;
  }

  /// Check if user is any type of admin
  static bool isAnyAdmin(UserDetails user) {
    final role = determineUserRole(user);
    return role == ROLE_SUPER_ADMIN || 
           role == ROLE_HOTEL_ADMIN || 
           role == ROLE_STORE_ADMIN;
  }

  /// Check if user is any type of staff
  static bool isAnyStaff(UserDetails user) {
    final role = determineUserRole(user);
    return role == ROLE_HOTEL_STAFF || role == ROLE_STORE_STAFF;
  }

  /// Debug method to print all user details
  static void debugUserDetails(UserDetails user) {
    print('=== COMPLETE USER DEBUG ===');
    print('User ID: ${user.id}');
    print('Email: ${user.email}');
    print('First Name: ${user.firstName}');
    print('Last Name: ${user.lastName}');
    print('is_admin: ${user.isAdmin}');
    print('is_super: ${user.isSuper}');
    print('Company ID: ${user.company?.id}');
    print('Company Name: ${user.company?.name}');
    print('Role ID: ${user.role?.id}');
    print('Role Name: ${user.role?.name}');
    print('Role Display Name: ${user.role?.displayName}');
    
    if (user.role?.permissions != null) {
      print('Permissions:');
      for (var permission in user.role!.permissions) {
        print('  - ${permission.name} (${permission.displayName})');
      }
    }
    
    print('Determined Role: ${determineUserRole(user)}');
    print('Can Access Hotel: ${canAccessHotel(user)}');
    print('Can Access Store: ${canAccessStore(user)}');
    print('Has POS Permissions: ${hasPosPermissions(user)}');
    print('========================');
  }
}





// import 'package:spotstock_inventory/data/models/user_details.dart';

// class RoleDetector {
//   static const String ROLE_HOTEL_ADMIN = 'hotel_admin';
//   static const String ROLE_STORE_ADMIN = 'store_admin';
//   static const String ROLE_SUPER_ADMIN = 'super_admin';
//   static const String ROLE_HOTEL_STAFF = 'hotel_staff';
//   static const String ROLE_STORE_STAFF = 'store_staff';

//   /// Primary method to determine user role with improved logic
//   static String determineUserRole(UserDetails user) {
//     print('=== ROLE DETECTION DEBUG ===');
//     print('User ID: ${user.id}');
//     print('User Email: ${user.email}');
//     print('Company Name: ${user.company?.name}');
//     print('is_admin: ${user.isAdmin}');
//     print('is_super: ${user.isSuper}');
//     print('Role Name: ${user.role?.name}');
    
//     // Check for super admin first (company developers)
//     if (_isSuperAdmin(user)) {
//       print('Detected as: SUPER_ADMIN');
//       return ROLE_SUPER_ADMIN;
//     }
    
//     // Check if user is admin (is_admin = 1)
//     if (user.isAdmin == 1) {
//       // Determine if hotel or store admin based on permissions
//       if (_hasHotelPermissions(user)) {
//         print('Detected as: HOTEL_ADMIN');
//         return ROLE_HOTEL_ADMIN;
//       } else {
//         print('Detected as: STORE_ADMIN');
//         return ROLE_STORE_ADMIN;
//       }
//     }
    
//     // For staff members (is_admin = 0), check their permissions
//     if (_hasHotelPermissions(user)) {
//       print('Detected as: HOTEL_STAFF');
//       return ROLE_HOTEL_STAFF;
//     } else {
//       print('Detected as: STORE_STAFF');
//       return ROLE_STORE_STAFF;
//     }
//   }

//   /// Check if user is super admin (company who developed the software)
//   static bool _isSuperAdmin(UserDetails user) {
//     // Check company name patterns for super admin
//     if (user.company?.name != null) {
//       final companyName = user.company!.name.toUpperCase();
//       if (companyName.contains('SPOT STOCK MANAGER') ||
//           companyName.contains('INVENTORY SOFTWARE') ||
//           companyName.contains('SPOT STOCK')) {
//         return true;
//       }
//     }
    
//     // Check for developer email patterns
//     if (user.email.contains('247okolo@gmail.com') ||
//         user.email.contains('spotstockinventory.com')) {
//       return true;
//     }
    
//     return false;
//   }

//   /// Check if user has hotel-specific permissions
//   static bool _hasHotelPermissions(UserDetails user) {
//     if (user.role?.permissions == null) return false;
    
//     final permissionNames = user.role!.permissions.map((p) => p.name).toList();
    
//     // Hotel-specific permissions
//     return permissionNames.contains('manage_rooms') ||
//            permissionNames.contains('manage_facility') ||
//            permissionNames.contains('manage_realestate') ||
//            permissionNames.contains('manage_tables'); // Tables are often hotel-related
//   }

//   /// Check if user has POS permissions (for both store staff and admins)
//   static bool hasPosPermissions(UserDetails user) {
//     if (user.role?.permissions == null) return false;
    
//     final permissionNames = user.role!.permissions.map((p) => p.name).toList();
//     return permissionNames.contains('manage_pos_screen');
//   }

//   /// Check if user can access hotel features
//   static bool canAccessHotel(UserDetails user) {
//     final role = determineUserRole(user);
//     return role == ROLE_SUPER_ADMIN || 
//            role == ROLE_HOTEL_ADMIN || 
//            role == ROLE_HOTEL_STAFF ||
//            _hasHotelPermissions(user);
//   }

//   /// Check if user can access store/inventory features
//   static bool canAccessStore(UserDetails user) {
//     final role = determineUserRole(user);
//     return role == ROLE_SUPER_ADMIN || 
//            role == ROLE_STORE_ADMIN || 
//            role == ROLE_STORE_STAFF ||
//            hasPosPermissions(user);
//   }

//   /// Convenience methods
//   static bool isHotelAdmin(UserDetails user) {
//     return determineUserRole(user) == ROLE_HOTEL_ADMIN;
//   }

//   static bool isStoreAdmin(UserDetails user) {
//     return determineUserRole(user) == ROLE_STORE_ADMIN;
//   }

//   static bool isSuperAdmin(UserDetails user) {
//     return determineUserRole(user) == ROLE_SUPER_ADMIN;
//   }
  
//   static bool isStoreStaff(UserDetails user) {
//     return determineUserRole(user) == ROLE_STORE_STAFF;
//   }

//   static bool isHotelStaff(UserDetails user) {
//     return determineUserRole(user) == ROLE_HOTEL_STAFF;
//   }

//   /// Check if user is any type of admin
//   static bool isAnyAdmin(UserDetails user) {
//     final role = determineUserRole(user);
//     return role == ROLE_SUPER_ADMIN || 
//            role == ROLE_HOTEL_ADMIN || 
//            role == ROLE_STORE_ADMIN;
//   }

//   /// Check if user is any type of staff
//   static bool isAnyStaff(UserDetails user) {
//     final role = determineUserRole(user);
//     return role == ROLE_HOTEL_STAFF || role == ROLE_STORE_STAFF;
//   }
// }