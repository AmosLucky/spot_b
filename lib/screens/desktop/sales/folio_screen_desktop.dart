import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/provider/folio_data_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/sidebar.dart';
import 'widgets/header_folio.dart';

class FolioScreenDesktop extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;

  const FolioScreenDesktop({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  });

  @override
  State<FolioScreenDesktop> createState() => _FolioScreenDesktopState();
}

class _FolioScreenDesktopState extends State<FolioScreenDesktop> {
  final _searchController = TextEditingController();
  FolioDataProvider? folioProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    final store = await DatabaseEngine.instance.getStore();
    final folioBox = store.box<FolioX>();
    final bookingBox = store.box<BookingX>();

    setState(() {
      folioProvider = FolioDataProvider(folioBox, bookingBox);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: folioProvider,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height,
                          ),
                          child: SizedBox(
                            width: 200,
                            child: SideBarHotel(
                              vertical: 20,
                              user: widget.user,
                              systemProvider: widget.systemProvider,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Consumer<FolioDataProvider>(
                            builder: (context, folioProvider, _) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderFolio(
                                  title: "Folio",
                                  user: widget.user,
                                  systemProvider: widget.systemProvider,
                                  searchController: _searchController,
                                  onChanged: (value) {
                                    folioProvider.searchData(value!);
                                  },
                                  onTap: () {
                                    _searchController.clear();
                                    folioProvider.fetchData();
                                  },
                                  onDateRangeSelected: (range) {
                                    folioProvider.filterByDateRange(
                                        range.start, range.end);
                                  },
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.95,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: PaginatedDataTable(
                                    columns: const [
                                      DataColumn(label: Text("ID")),
                                      DataColumn(label: Text("CUSTOMER")),
                                      DataColumn(label: Text("BOOKING ID")),
                                      DataColumn(label: Text("ROOM NO")),
                                      DataColumn(label: Text("CR")),
                                      DataColumn(label: Text("DR")),
                                      DataColumn(label: Text("BALANCE")),
                                      DataColumn(label: Text("DATE")),
                                    ],
                                    source: folioProvider.getDataSource(),
                                    columnSpacing: 20,
                                    horizontalMargin: 20,
                                    showFirstLastButtons: true,
                                    rowsPerPage: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
