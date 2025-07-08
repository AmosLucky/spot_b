import 'package:spotstock_inventory/data/models/user_details.dart';

class RoleDetector {
  static const String ROLE_HOTEL_ADMIN = 'hotel_admin';
  static const String ROLE_STORE_ADMIN = 'store_admin';
  static const String ROLE_SUPER_ADMIN = 'super_admin';
  static const String ROLE_STORE_STAFF = 'store_staff';

  /// Primary method to determine user role with debug logging
  static String determineUserRole(UserDetails user) {
    print('=== ROLE DETECTION DEBUG ===');
    print('User ID: ${user.id}');
    print('User Email: ${user.email}');
    print('Company Name: ${user.company?.name}');
    print('is_admin: ${user.isAdmin}');
    print('is_super: ${user.isSuper}');
    
    // Check for super admin first (company developers)
    if (_isSuperAdmin(user)) {
      print('Detected as: SUPER_ADMIN');
      return ROLE_SUPER_ADMIN;
    }
    
    // Check if user is admin of their store
    if (_isStoreAdmin(user)) {
      print('Detected as: STORE_ADMIN');
      return ROLE_STORE_ADMIN;  
    }
    
    // Check for hotel permissions
    if (_hasHotelPermissions(user)) {
      print('Detected as: HOTEL_ADMIN');
      return ROLE_HOTEL_ADMIN;
    }
    
    // Default to store staff (employees/attendants)
    print('Detected as: STORE_STAFF');
    return ROLE_STORE_STAFF;
  }

  /// Check if user is super admin (company who developed the software)
  static bool _isSuperAdmin(UserDetails user) {
    // Super admin indicators from API response analysis
    if (user.company?.name != null) {
      final companyName = user.company!.name.toUpperCase();
      if (companyName.contains('SPOT STOCK') || 
          companyName.contains('INVENTORY SOFTWARE') ||
          companyName.contains('SPOT STOCK MANAGER')) {
        return true;
      }
    }
    
    // Check for developer email patterns or specific company IDs
    if (user.email.contains('spotstockinventory.com') || 
        user.email.contains('247okolo@gmail.com')) {
      return true;
    }
    
    return false;
  }

  /// Check if user is store admin (owns/manages the store)
  static bool _isStoreAdmin(UserDetails user) {
    // From API: "is_admin": 1 indicates store admin
    return user.isAdmin == 1;
  }

  /// Check if user has hotel-specific permissions
  static bool _hasHotelPermissions(UserDetails user) {
    if (user.role?.permissions == null) return false;
    
    final permissionNames = user.role!.permissions.map((p) => p.name).toList();
    
    // Hotel-specific permissions
    return permissionNames.contains('manage_rooms') ||
           permissionNames.contains('manage_facility') ||
           permissionNames.contains('manage_realestate');
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
}




// import 'package:spotstock_inventory/data/models/user_details.dart';

// class RoleDetector {
//   static const String ROLE_HOTEL_ADMIN = 'hotel_admin';
//   static const String ROLE_STORE_ADMIN = 'store_admin';
//   static const String ROLE_SUPER_ADMIN = 'super_admin';

//   /// Primary method to determine user role with debug logging
//   static String determineUserRole(UserDetails user) {
//     print('=== ROLE DETECTION DEBUG ===');
//     print('User ID: ${user.id}');
//     print('User Email: ${user.email}');
//     print('Company Name: ${user.company?.name}');
//     print('Company ID: ${user.company?.id}');
//     print('Company Amount: ${user.company?.amount}');
    
//     // Print permissions for debugging
//     if (user.role?.permissions != null) {
//       final permissionNames = user.role!.permissions.map((p) => p.name).toList();
//       print('User Permissions: $permissionNames');
//     }

//     // Method 1: Check for super admin first
//     if (_isSuperAdmin(user)) {
//       print('Detected as: SUPER_ADMIN');
//       return ROLE_SUPER_ADMIN;
//     }

//     // Method 2: Check permissions (most reliable)
//     if (_hasHotelPermissions(user)) {
//       print('Detected as: HOTEL_ADMIN (by permissions)');
//       return ROLE_HOTEL_ADMIN;
//     }

//     // Method 3: Check company name patterns
//     if (_isHotelByCompanyName(user)) {
//       print('Detected as: HOTEL_ADMIN (by company name)');
//       return ROLE_HOTEL_ADMIN;
//     }

//     // Method 4: Check subscription amount patterns
//     if (_isHotelByAmount(user)) {
//       print('Detected as: HOTEL_ADMIN (by amount)');
//       return ROLE_HOTEL_ADMIN;
//     }

//     // Default to store admin
//     print('Detected as: STORE_ADMIN (default)');
//     return ROLE_STORE_ADMIN;
//   }

//   /// Check if user is super admin
//   static bool _isSuperAdmin(UserDetails user) {
//     print('Checking super admin...');
    
//     // Check company name
//     if (user.company?.name != null) {
//       final companyName = user.company!.name.toUpperCase();
//       if (companyName.contains('SPOT STOCK MANAGER')) {
//         print('Super admin detected by company name');
//         return true;
//       }
//     }

//     // Check specific email domains or IDs
//     if (user.email.contains('247okolo@gmail.com') || 
//         user.company?.id == 20) {
//       print('Super admin detected by email/company ID');
//       return true;
//     }

//     // Check low amount (developer account pattern)
//     if (user.company?.amount != null && user.company!.amount! < 1000) {
//       print('Super admin detected by low amount: ${user.company!.amount}');
//       return true;
//     }

//     return false;
//   }

//   /// Check if user has hotel-specific permissions
//   static bool _hasHotelPermissions(UserDetails user) {
//     print('Checking hotel permissions...');
    
//     if (user.role?.permissions == null) {
//       print('No permissions found');
//       return false;
//     }

//     final permissionNames = user.role!.permissions.map((p) => p.name).toList();
//     print('Available permissions: $permissionNames');
    
//     // Hotel-specific permissions
//     final hasHotelPerms = permissionNames.contains('manage_rooms') || 
//            permissionNames.contains('manage_facility') ||
//            permissionNames.contains('manage_tables');
    
//     print('Has hotel permissions: $hasHotelPerms');
//     return hasHotelPerms;
//   }

//   /// Check if company name indicates hotel business
//   static bool _isHotelByCompanyName(UserDetails user) {
//     print('Checking company name for hotel keywords...');
    
//     if (user.company?.name == null) {
//       print('No company name found');
//       return false;
//     }

//     final companyName = user.company!.name.toUpperCase();
//     print('Company name (uppercase): $companyName');
    
//     final hotelKeywords = [
//       'HOTEL', 'SUITES', 'RESORT', 'LODGE', 'INN', 
//       'HOSPITALITY', 'ACCOMMODATION', 'GUEST HOUSE'
//     ];

//     final isHotel = hotelKeywords.any((keyword) => companyName.contains(keyword));
//     print('Is hotel by company name: $isHotel');
//     return isHotel;
//   }

//   /// Check subscription amount patterns
//   static bool _isHotelByAmount(UserDetails user) {
//     print('Checking amount for hotel pattern...');
    
//     if (user.company?.amount == null) {
//       print('No amount found');
//       return false;
//     }
    
//     print('Company amount: ${user.company!.amount}');
//     // Hotels typically have higher subscription amounts
//     final isHotel = user.company!.amount! >= 10000;
//     print('Is hotel by amount: $isHotel');
//     return isHotel;
//   }

//   /// Convenience methods for UI components
//   static bool isHotelAdmin(UserDetails user) {
//     return determineUserRole(user) == ROLE_HOTEL_ADMIN;
//   }

//   static bool isStoreAdmin(UserDetails user) {
//     return determineUserRole(user) == ROLE_STORE_ADMIN;
//   }

//   static bool isSuperAdmin(UserDetails user) {
//     return determineUserRole(user) == ROLE_SUPER_ADMIN;
//   }
// }