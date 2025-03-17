import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/navigation.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
import 'package:spotstock_inventory/screens/mobile/home/pages/transactions.dart';
import 'package:spotstock_inventory/screens/mobile/logoutconfirm.dart';
import 'package:spotstock_inventory/screens/mobile/choose_service.dart';
// import 'package:spotstock_inventory/screens/mobile/pos/pos_mobile.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/widgets/dashboard_card.dart';
import 'package:spotstock_inventory/widgets/transaction_card.dart';

import '../../../../common/helpers/user_preferences.dart';

class DashboardMobileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> HomeKey;
  final UserDetails user;
  final bool? isMobile;
  const DashboardMobileScreen(
      {super.key,
      required this.HomeKey,
      required this.user,
      this.isMobile = true});

  @override
  State<DashboardMobileScreen> createState() => _DashboardMobileScreenState();
}

class _DashboardMobileScreenState extends State<DashboardMobileScreen> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  bool isConnected = false;
  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen(connectionChanged);
    _checkInitialConnection();
    // Initialize connectivity state
    Connectivity().checkConnectivity().then((result) {
      setState(() {
        _source = {result: true};
      });
    });
    //getTables();
  }

  //SystemProvider systemProvider = SystemProvider();
  // Future<List<dynamic>> getTables() async {
  //   return await systemProvider.getTables();
  // }

  void connectionChanged(dynamic result) {
    setState(() {
      _source = {
        result: true
      }; // Updates `_source` with current connectivity state
    });
  }

  Future<void> _checkInitialConnection() async {
    bool initialConnection = await InternetUtils.isConnected();
    setState(() {
      isConnected = initialConnection;
    });
  }

  Future<bool> _isOpenRegister(String text) async {
    var response =
        await SystemRepo(refresh: false, online: false).isRegisterOpen(text);
    print("----------register open ------------");
    print(response);
    return response['total'] != 0; // Return true if register is open
  }

  void _showPOSDialog(BuildContext context, SystemProvider systemProvider) {
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("POS Register"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Set column height based on content
              children: [
                const Text("Open register to start your daily sales!"),
                const SizedBox(height: 16), // Add spacing
                // TextField for cash at hand with validation
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cash at Hand",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the cash amount at hand';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) > 0) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Validate the form before proceeding
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(); // Close the dialog
                  // Open register with the entered cash amount
                  var response = await SystemRepo(refresh: false, online: false)
                      .openRegister(
                          module: 'INVENTORY', amount: amountController.text);

                  if (response['status'] == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChooseServiceScreen(
                        systemProvider: systemProvider,
                        isMobile: widget.isMobile ?? true,
                      );
                    }));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Failed to open register. Please try again.'),
                      ),
                    );
                  }
                }
              },
              child: const Text("Open"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Register closed!')),
                );
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print("------------- connect -------------");
    print("Connection result: $ConnectivityResult");

    String onlineStatus;
    isConnected ? onlineStatus = 'online' : onlineStatus = 'offline';
    // switch (_source.keys.toList()[0]) {
    //   case ConnectivityResult.mobile:
    //   case ConnectivityResult.wifi:
    //     onlineStatus = 'online';
    //     break;
    //   case ConnectivityResult.none:
    //   default:
    //     onlineStatus = 'offline';
    // }

    return ChangeNotifierProvider<SystemProvider>(
      create: (context) => SystemProvider(),
      child: Consumer<SystemProvider>(
        builder: (context, systemProvider, _) {
          return RefreshIndicator(
              onRefresh: () => systemProvider.refreshData,
              child: _dashboardScreen(context, onlineStatus, systemProvider));
        },
      ),
    );
  }

  Widget _dashboardScreen(
      BuildContext context, onlineStatus, SystemProvider systemProvider) {
    //bool connectionState = onlineStatus == 'online' ? true : false;

    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: systemProvider.state == ResponseState.loading
                ? FloatingActionButton.extended(
                    backgroundColor: primaryColor,
                    onPressed: () {},
                    label: const CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  )
                : FloatingActionButton.extended(
                    backgroundColor: primaryColor,
                    onPressed: () async {
                      // Check if the register is open before navigating
                      bool isOpen = await _isOpenRegister("INVENTORY");

                      if (isOpen) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChooseServiceScreen(
                            systemProvider: systemProvider,
                            isMobile: widget.isMobile ?? true,
                          );
                        }));
                      } else {
                        // Show POS dialog if register is not open
                        _showPOSDialog(context, systemProvider);
                      }
                    },
                    label: const Text('POS'),
                    icon: const Icon(Icons.shopping_bag),
                  )),
        // drawer: SideNavigation(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: primaryColor,
                height: MediaQuery.of(context).size.height * .45,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Hello, ${widget.user.firstName}!",
                                style: TextStyle(
                                    fontSize:
                                        widget.isMobile == false ? 25 : 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 250, 180, 208)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  color:
                                      const Color.fromARGB(255, 250, 180, 208),
                                  icon: Icon(
                                    Icons.logout,
                                    size: widget.isMobile == false ? 45 : 30.0,
                                  ),
                                  onPressed: () => _logoutAction())
                            ],
                          )
                        ]),
                    SizedBox(
                      height: widget.isMobile == false ? 50 : 30.0,
                    ),
                    Text(
                      "Sales",
                      style: TextStyle(
                          fontSize: widget.isMobile == false ? 45 : 19,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Money.format(
                          systemProvider.dashboardStats['salesToday'] ?? 0),
                      style: TextStyle(
                          fontSize: widget.isMobile == false ? 55 : 38,
                          color: whiteColor,
                          fontFamily: sofia,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "TOTAL TODAY",
                      style: TextStyle(
                          fontSize: widget.isMobile == false ? 25 : 17,
                          color: orangeColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // two cards
              Container(
                alignment: Alignment.topCenter,
                padding: widget.isMobile == false
                    ? EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .36,
                        horizontal: 20)
                    : EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .33,
                        right: 19.0,
                        left: 20.0,
                      ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardCard(
                      cardWidth: 0.45,
                      title: "Products",
                      value:
                          "${systemProvider.dashboardStats['productCount'] ?? '0'}",
                      subtitle: "Available",
                      outOfStock:
                          "${systemProvider.dashboardStats['productStockOut'] ?? '0'} In Stock",
                      iconColor: const Color.fromARGB(255, 195, 220, 30),
                      icon: MdiIcons.chartBar,
                    ),
                    DashboardCard(
                      cardWidth: 0.45,
                      title: "Unsynced",
                      value:
                          "${systemProvider.dashboardStats['overallUnsync'] ?? '0'}",
                      subtitle: "Waiting to sync",
                      outOfStock:
                          "${systemProvider.dashboardStats['overallSync'] ?? '0'} Synced",
                      iconColor: Colors.orange,
                      icon: MdiIcons.syncCircle,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: widget.isMobile == false
                    ? EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .55,
                        horizontal: 20.0)
                    : EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .61,
                        right: 10.0,
                        left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Statistics",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        //  onlineStatus == 'online'
                        isConnected
                            ? Row(mainAxisSize: MainAxisSize.min, children: [
                                GestureDetector(
                                    onTap: () {
                                      Provider.of<SystemProvider>(context,
                                              listen: false)
                                          .forcefulRefresh(isConnected);
                                      //Provider.of<SystemProvider>(context, listen: false).fetchTables(true,isConnected);
                                    },
                                    child: const Text("Refresh")),
                                IconButton(
                                    color:
                                        const Color.fromARGB(255, 62, 61, 61),
                                    onPressed: () {
                                      Provider.of<SystemProvider>(context,
                                              listen: false)
                                          .forcefulRefresh(isConnected);
                                    },
                                    icon: const Icon(Icons.network_cell))
                              ])
                            : InkWell(
                                onTap: () {
                                  Provider.of<SystemProvider>(context,
                                          listen: false)
                                      .forcefulRefresh(true);
                                },
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("No internet"),
                                      IconButton(
                                          color: const Color.fromARGB(
                                              255, 62, 61, 61),
                                          onPressed: () {},
                                          icon: const Icon(Icons
                                              .signal_wifi_connected_no_internet_4))
                                    ])),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    TransactionCard(
                      title: "Today's Transactions",
                      titleColor: primaryColor,
                      stats: {
                        'salesToday': Money.format(
                            systemProvider.dashboardStats['salesToday'] ?? 0),
                        'todayCount':
                            systemProvider.dashboardStats['todayCount'] ?? '0',
                        'todaySync':
                            systemProvider.dashboardStats['todaySync'] ?? '0',
                        'todayUnsync':
                            systemProvider.dashboardStats['todayUnsync'] ?? '0',
                      },
                      isMobile: widget.isMobile ?? true,
                    ),
                    TransactionCard(
                      title: "Yesterday\'s Transactions",
                      titleColor: primaryColor,
                      stats: {
                        'sales': Money.format(
                            systemProvider.dashboardStats['yesterdayAmount'] ??
                                0),
                        'count':
                            systemProvider.dashboardStats['yesterdayCount'] ??
                                '0',
                        'sync':
                            systemProvider.dashboardStats['yesterdaySync'] ??
                                '0',
                        'unsync':
                            systemProvider.dashboardStats['yesterdayUnsync'] ??
                                '0',
                      },
                      isMobile: widget.isMobile ?? true,
                    ),
                    TransactionCard(
                      title: "This Week",
                      titleColor: primaryColor,
                      stats: {
                        'sales': Money.format(
                            systemProvider.dashboardStats['weeklyAmount'] ?? 0),
                        'count':
                            systemProvider.dashboardStats['weeklyCount'] ?? '0',
                        'sync':
                            systemProvider.dashboardStats['weeklySync'] ?? '0',
                        'unsync':
                            systemProvider.dashboardStats['weeklyUnsync'] ??
                                '0',
                      },
                      isMobile: widget.isMobile ?? true,
                    ),
                    TransactionCard(
                      title: "Last Week",
                      titleColor: primaryColor,
                      stats: {
                        'sales': Money.format(
                            systemProvider.dashboardStats['lastweekAmount'] ??
                                0),
                        'count':
                            systemProvider.dashboardStats['lastweekCount'] ??
                                '0',
                        'sync': systemProvider.dashboardStats['lastweekSync'] ??
                            '0',
                        'unsync':
                            systemProvider.dashboardStats['lastweekUnsync'] ??
                                '0',
                      },
                      isMobile: widget.isMobile ?? true,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _logoutAction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LogoutConfirmationScreen();
    }));
  }
}
