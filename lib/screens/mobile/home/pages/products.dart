import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsMobileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> HomeKey;
  final UserDetails user;
  const ProductsMobileScreen(
      {super.key, required this.HomeKey, required this.user});

  @override
  State<ProductsMobileScreen> createState() => _ProductsMobileScreenState();
}

class _ProductsMobileScreenState extends State<ProductsMobileScreen> {
  late String currentMonthName;
  late String lastMonthName;

  @override
  void initState() {
    super.initState();
    // Get the current date and time
    DateTime now = DateTime.now();

    // Define a list of month names
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    // Store the current month name in the variable
    currentMonthName = monthNames[now.month - 1];

    // Calculate the last month's name
    DateTime lastMonth = DateTime(now.year, now.month - 1);
    lastMonthName = monthNames[lastMonth.month - 1];

    // Print the current and last month names
    print('Current Month: $currentMonthName');
    print('Last Month: $lastMonthName');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SystemProvider>(
      create: (context) => SystemProvider(),
      child: Consumer<SystemProvider>(
        builder: (context, systemProvider, _) {
          return RefreshIndicator(
              onRefresh: () => systemProvider.refreshData,
              child: _productsList(context, systemProvider));
        },
      ),
    );
  }

  Widget _productsList(BuildContext context, SystemProvider systemProvider) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Sales Summary',
            style: TextStyle(color: whiteColor),
          ),
          actions: [],
        ),
        // drawer: SideNavigation(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildSummary('Sales Today', systemProvider,
                  amount: 'salesToday',
                  count: 'todayCount',
                  synced: 'todaySync',
                  unsynced: 'todayUnsync'),
              _buildSummary('Sales Yesterday', systemProvider,
                  amount: 'yesterdayAmount',
                  count: 'yesterdayCount',
                  synced: 'yesterdaySync',
                  unsynced: 'yesterdayUnsync'),
              _buildSummary('This Week Sales', systemProvider,
                  amount: 'weeklyAmount',
                  count: 'weeklyCount',
                  synced: 'weeklySync',
                  unsynced: 'weeklyUnsync'),
              _buildSummary('Last Week Sales', systemProvider,
                  amount: 'lastweekAmount',
                  count: 'lastweekCount',
                  synced: 'lastweekSync',
                  unsynced: 'lastweekUnsync'),
              _buildSummary('$currentMonthName Sales', systemProvider,
                  amount: 'monthlyAmount',
                  count: 'monthlyCount',
                  synced: 'monthlySync',
                  unsynced: 'monthlyUnsync'),
              _buildSummary('$lastMonthName Sales', systemProvider,
                  amount: 'lastmonthAmount',
                  count: 'lastmonthCount',
                  synced: 'lastmonthSync',
                  unsynced: 'lastmonthUnsync')
            ],
          ),
        ));
  }

  SizedBox _buildSummary(String title, SystemProvider systemProvider,
      {amount, count, synced, unsynced}) {
    return SizedBox(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        child: Card(
            color: Colors.white,
            elevation: 0.0,
            child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStats(
                              title: Money.format(
                                  systemProvider.dashboardStats[amount] ?? 0),
                              desc: 'Amount'),
                          _buildStats(
                              title:
                                  '${systemProvider.dashboardStats[count] ?? '0'}',
                              desc: 'Total'),
                          _buildStats(
                              title:
                                  '${systemProvider.dashboardStats[synced] ?? '0'}/${systemProvider.dashboardStats[unsynced] ?? '0'}',
                              desc: 'Sync/Unsynced')
                        ],
                      )
                    ]))));
  }

  Widget _buildStats({title, desc}) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(
          "$title",
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "$desc",
          style: TextStyle(
              fontSize: 12, color: grayColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
