import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';

import 'header.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;

  const Body(
      {super.key,
      required this.user,
      required this.systemProvider,
      required this.mediaQuery});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? _selectedDateFromHeader;

  void _handleDateSelection(DateTime selectedDate) {
    setState(() {
      _selectedDateFromHeader = selectedDate;
    });
  }

  Future<List<Orders>> _fetchTransactions() async {
    return widget.systemProvider.getTransactionsByDate(_selectedDateFromHeader);
  }

  Future<List<Orders>> _fetchWaitingToSync() {
    return widget.systemProvider.getWaitingSyncDate(_selectedDateFromHeader);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: SingleChildScrollView(
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
                    child: SideBarInventory(
                      vertical: 20,
                      user: widget.user,
                      systemProvider: widget.systemProvider,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                        onDateSelected: _handleDateSelection,
                      ),
                      const SizedBox(height: 10),

                      // Row for displaying both History and Waiting to Sync sections side by side
                      Row(
                        children: [
                          // History Section
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<List<Orders>>(
                              future: _fetchTransactions(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child:
                                          Text('Error fetching transactions'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No transactions found'));
                                }

                                final transactions = snapshot.data!;
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'History',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: transactions.length,
                                        itemBuilder: (context, index) {
                                          final transaction =
                                              transactions[index];
                                          return TransactionTile(
                                            transactionId: transaction.trxId,
                                            amount: transaction.amount,
                                            createdAt: transaction.createdAt,
                                            isSynced: transaction.sync == 1,
                                            paymentMethod:
                                                transaction.paymentMethod,
                                            onPrint: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PrintScreenDialog(
                                                            user: widget.user,
                                                            transactionData:
                                                                transaction
                                                                    .toMap(),
                                                          )));
                                            },
                                            onSync: () {},
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(
                              width:
                                  20), // Add some space between the two sections

                          // Waiting to Sync Section
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<List<Orders>>(
                              future: _fetchWaitingToSync(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text(
                                          'Error fetching waiting to sync transactions'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'No transactions waiting to sync'));
                                }

                                final waitingToSync = snapshot.data!;
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Waiting to Sync',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Add sync functionality here
                                            },
                                            child: const Text(
                                              'Sync All',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: waitingToSync.length,
                                        itemBuilder: (context, index) {
                                          final syncItem = waitingToSync[index];
                                          return TransactionTile(
                                            transactionId: syncItem.trxId,
                                            amount: syncItem.amount,
                                            createdAt: syncItem.createdAt,
                                            isSynced: syncItem.sync == 1,
                                            paymentMethod:
                                                syncItem.paymentMethod,
                                            onPrint: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PrintScreenDialog(
                                                            user: widget.user,
                                                            transactionData:
                                                                syncItem
                                                                    .toMap(),
                                                          )));
                                            },
                                            onSync: () {

                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
