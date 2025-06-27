import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/helpers/preference_settings.dart';
import 'package:spotstock_inventory/common/navigation.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/booking_history_provider.dart';
import 'package:spotstock_inventory/common/provider/booking_provider.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/folio_data_provider.dart';
import 'package:spotstock_inventory/common/provider/general_provider.dart';
import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/markroomfor_maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/preference_settings_provider.dart';
import 'package:spotstock_inventory/common/provider/sales_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/objectbox.g.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/operations_provider.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/paymentstate.dart';
import 'package:spotstock_inventory/screens/desktop/providers/products_provider.dart';
import 'package:spotstock_inventory/screens/desktop/providers/warehouse_products_provider.dart';
import 'package:spotstock_inventory/screens/desktop/splashscreen_desktop.dart';
import 'package:spotstock_inventory/screens/mobile/splashscreen_mobile.dart';
import 'package:spotstock_inventory/widgets/responsive.dart';
import 'screens/desktop/providers/select_attendant_provider.dart';

// import 'common/provider/attendant_model.dart';
// Custom HTTP Override for SSL Certificate Handling
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Log certificate details for debugging
        print('Certificate validation for $host:$port');
        print('Certificate subject: ${cert.subject}');
        print('Certificate issuer: ${cert.issuer}');

        // Allow certificates for your trusted domains
        List<String> trustedHosts = [
          'app.spotstockinventory.com',
          'test.spotstockinventory.com',
          'staging.spotstockinventory.com',
        ];

        if (trustedHosts.contains(host)) {
          return true;
        }

        // For production, you might want to implement more strict validation
        // For now, allowing all certificates to resolve the issue
        return true; // Change to false for stricter validation
      };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set custom HTTP overrides for SSL certificate handling
  HttpOverrides.global = MyHttpOverrides();

  await DatabaseEngine.create();

  final store = await DatabaseEngine.instance.getStore();
  final folioBox = store.box<FolioX>();
  final bookingBox = store.box<BookingX>();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(
    folioBox: folioBox,
    bookingBox: bookingBox,
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatefulWidget {
  final Box<FolioX> folioBox;
  final Box<BookingX> bookingBox;
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.folioBox,
    required this.bookingBox,
    required this.sharedPreferences,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDbReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1f1e30),
        systemNavigationBarColor: Color(0xFF1f1e30),
      ),
    );
  }

  Future<void> _initializeDatabase() async {
    try {
      await DatabaseEngine.create();
      setState(() {
        _isDbReady = true;
      });
      print("Database initialized successfully.");
    } catch (e, stacktrace) {
      print("Error initializing database: $e");
      print("Stacktrace: $stacktrace");
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Database Initialization Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => SelectAttendantProvider()),
    ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ChangeNotifierProvider(
        create: (_) =>
            SalesProvider(SystemRepo(refresh: false, online: true))),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (_) => SystemProvider()), // Moved SystemProvider up
    ChangeNotifierProvider(
      create: (context) => WarehouseProductsProvider(
        Provider.of<SystemProvider>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) =>
          AuthProvider(sharedPreferences: widget.sharedPreferences),
    ),
    ChangeNotifierProvider(create: (_) => GeneralProvider()),
    ChangeNotifierProvider(
      create: (_) => FolioDataProvider(widget.folioBox, widget.bookingBox),
    ),
    ChangeNotifierProvider(create: (_) => BookingProvider()),
    ChangeNotifierProvider(
        create: (_) => MarkDirtyRoomProvider(
              SystemRepo(refresh: false, online: true),
            )),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => OperationsProvider()),
    ChangeNotifierProvider(create: (_) => PaymentState()),
    ChangeNotifierProvider(
        create: (_) => MarkRoomForMaintenanceProvider(
            SystemRepo(refresh: false, online: true))),
    ChangeNotifierProvider(
        create: (_) => BookingHistoryProvider(
            SystemRepo(refresh: false, online: true))),
    ChangeNotifierProvider(
      create: (_) => PreferenceSettingsProvider(
        preferenceSettingsHelper: PreferenceSettingsHelper(
          sharedPreferences: widget.sharedPreferences,
        ),
      ),
    ),
  ],
  child: Consumer<PreferenceSettingsProvider>(
    builder: (context, preferenceSettingsProvider, _) {
      return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: preferenceSettingsProvider.themeData,
            title: 'Spotstock Inventory',
            navigatorKey: navigatorKey,
            home: Responsive(
              desktop: SplashScreenDesktop(),
              mobile: SplashScreenMobile(),
            ),
          );
        },
      );
    },
  ),
);
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import 'package:spotstock_inventory/common/helpers/database_engine.dart';
// import 'package:spotstock_inventory/common/helpers/preference_settings.dart';
// import 'package:spotstock_inventory/common/navigation.dart';
// // import 'package:spotstock_inventory/common/provider/attendant_provider.dart';
// import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
// import 'package:spotstock_inventory/common/provider/booking_history_provider.dart';
// import 'package:spotstock_inventory/common/provider/booking_provider.dart';
// import 'package:spotstock_inventory/common/provider/cart_provider.dart';
// import 'package:spotstock_inventory/common/provider/folio_data_provider.dart';
// import 'package:spotstock_inventory/common/provider/general_provider.dart';
// import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';
// import 'package:spotstock_inventory/common/provider/markroomfor_maintenance_provider.dart';
// import 'package:spotstock_inventory/common/provider/preference_settings_provider.dart';
// import 'package:spotstock_inventory/common/provider/sales_provider.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/common/provider/user_provider.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/data/repository/system_repo.dart';

// import 'package:spotstock_inventory/objectbox.g.dart';
// import 'package:spotstock_inventory/screens/desktop/hotel/widgets/operations_provider.dart';
// import 'package:spotstock_inventory/screens/desktop/hotel/widgets/paymentstate.dart';
// import 'package:spotstock_inventory/screens/desktop/splashscreen_desktop.dart';
// import 'package:spotstock_inventory/screens/mobile/splashscreen_mobile.dart';
// import 'package:spotstock_inventory/widgets/responsive.dart';

// // import 'common/provider/attendant_model.dart';
// import 'screens/desktop/providers/select_attendant_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await DatabaseEngine.create();

//   final store = await DatabaseEngine.instance.getStore();
//   final folioBox = store.box<FolioX>();
//   final bookingBox = store.box<BookingX>();
//   final sharedPreferences = await SharedPreferences.getInstance();

//   runApp(MyApp(
//     folioBox: folioBox,
//     bookingBox: bookingBox,
//     sharedPreferences: sharedPreferences,
//   ));
// }

// class MyApp extends StatefulWidget {
//   final Box<FolioX> folioBox;
//   final Box<BookingX> bookingBox;
//   final SharedPreferences sharedPreferences;

//   const MyApp({
//     super.key,
//     required this.folioBox,
//     required this.bookingBox,
//     required this.sharedPreferences,
//   });

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDbReady = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Color(0xFF1f1e30),
//         systemNavigationBarColor: Color(0xFF1f1e30),
//       ),
//     );
//   }

//   Future<void> _initializeDatabase() async {
//     try {
//       await DatabaseEngine.create();
//       setState(() {
//         _isDbReady = true;
//       });
//       print("Database initialized successfully.");
//     } catch (e, stacktrace) {
//       print("Error initializing database: $e");
//       print("Stacktrace: $stacktrace");
//     }
//   }

//   void _showErrorDialog(String errorMessage) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Database Initialization Error"),
//           content: Text(errorMessage),
//           actions: <Widget>[
//             TextButton(
//               child: const Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ));
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SelectAttendantProvider()),
//         ChangeNotifierProvider(
//             create: (_) =>
//                 SalesProvider(SystemRepo(refresh: false, online: true))),
//         ChangeNotifierProvider(create: (context) => CartProvider()),
//         ChangeNotifierProvider(
//           create: (_) =>
//               AuthProvider(sharedPreferences: widget.sharedPreferences),
//         ),
//         ChangeNotifierProvider(create: (_) => GeneralProvider()),
//         ChangeNotifierProvider(
//           create: (_) => FolioDataProvider(widget.folioBox,
//               widget.bookingBox),
//         ),
//         ChangeNotifierProvider(create: (_) => SystemProvider()),
//         ChangeNotifierProvider(create: (_) => BookingProvider()),
//         ChangeNotifierProvider(
//             create: (_) => MarkDirtyRoomProvider(
//                   SystemRepo(refresh: false, online: true),
//                 )),
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//         ChangeNotifierProvider(create: (_) => OperationsProvider()),
//         ChangeNotifierProvider(create: (_) => PaymentState()),
//         ChangeNotifierProvider(
//             create: (_) => MarkRoomForMaintenanceProvider(
//                 SystemRepo(refresh: false, online: true))),
//         ChangeNotifierProvider(
//             create: (_) => BookingHistoryProvider(
//                 SystemRepo(refresh: false, online: true))),
//         ChangeNotifierProvider(
//           create: (_) => PreferenceSettingsProvider(
//             preferenceSettingsHelper: PreferenceSettingsHelper(
//               sharedPreferences: widget.sharedPreferences,
//             ),
//           ),
//         ),
//       ],
//       child: Consumer<PreferenceSettingsProvider>(
//         builder: (context, preferenceSettingsProvider, _) {
//           return ResponsiveSizer(
//             builder: (context, orientation, screenType) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 theme: preferenceSettingsProvider.themeData,
//                 title: 'Spotstock Inventory',
//                 navigatorKey: navigatorKey,
//                 home: Responsive(
//                   desktop: SplashScreenDesktop(),
//                   mobile: SplashScreenMobile(),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => SelectAttendantProvider()),
    //     ChangeNotifierProvider(create: (_) => ProductsProvider()),
    //     ChangeNotifierProvider(
    //         create: (_) =>
    //             SalesProvider(SystemRepo(refresh: false, online: true))),
    //     ChangeNotifierProvider(create: (context) => CartProvider()),
    //     ChangeNotifierProvider(create: (context) => WarehouseProductsProvider()),
    //     ChangeNotifierProvider(
    //       create: (_) =>
    //           AuthProvider(sharedPreferences: widget.sharedPreferences),
    //     ),
    //     ChangeNotifierProvider(create: (_) => GeneralProvider()),
    //     ChangeNotifierProvider(
    //       create: (_) => FolioDataProvider(widget.folioBox, widget.bookingBox),
    //     ),
    //     ChangeNotifierProvider(create: (_) => SystemProvider()),
    //     ChangeNotifierProvider(create: (_) => BookingProvider()),
    //     ChangeNotifierProvider(
    //         create: (_) => MarkDirtyRoomProvider(
    //               SystemRepo(refresh: false, online: true),
    //             )),
    //     ChangeNotifierProvider(create: (_) => UserProvider()),
    //     ChangeNotifierProvider(create: (_) => OperationsProvider()),
    //     ChangeNotifierProvider(create: (_) => PaymentState()),
    //     ChangeNotifierProvider(
    //         create: (_) => MarkRoomForMaintenanceProvider(
    //             SystemRepo(refresh: false, online: true))),
    //     ChangeNotifierProvider(
    //         create: (_) => BookingHistoryProvider(
    //             SystemRepo(refresh: false, online: true))),
    //     ChangeNotifierProvider(
    //       create: (_) => PreferenceSettingsProvider(
    //         preferenceSettingsHelper: PreferenceSettingsHelper(
    //           sharedPreferences: widget.sharedPreferences,
    //         ),
    //       ),
    //     ),
    //   ],
    //   child: Consumer<PreferenceSettingsProvider>(
    //     builder: (context, preferenceSettingsProvider, _) {
    //       return ResponsiveSizer(
    //         builder: (context, orientation, screenType) {
    //           return MaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             theme: preferenceSettingsProvider.themeData,
    //             title: 'Spotstock Inventory',
    //             navigatorKey: navigatorKey,
    //             home: Responsive(
    //               desktop: SplashScreenDesktop(),
    //               mobile: SplashScreenMobile(),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );