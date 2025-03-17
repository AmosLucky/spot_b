import 'dart:developer';

import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/body.dart';
import 'package:spotstock_inventory/screens/mobile/pos/receipt_mobile.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/outline_search_bar/outline_search_bar.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../common/primary_text_field.dart';
import '../../../../data/models/schema.dart';

class WaitingMobileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> HomeKey;
  final UserDetails user;
  const WaitingMobileScreen(
      {super.key, required this.HomeKey, required this.user});

  @override
  State<WaitingMobileScreen> createState() => _WaitingMobileScreenState();
}

class _WaitingMobileScreenState extends State<WaitingMobileScreen> {

  List _productSearchResult = [];
  List transactionData = [];
  List _foundProducts = [];
  bool? loading;
  bool _isLoading = false;
  //List? _products;
  Orders? product;
  final searchTextController = TextEditingController();

  Future<List<dynamic>> getUnSyncTransactions(
      SystemProvider systemProvider) async {
    transactionData = await systemProvider.getUnSyncTransactions();
    return await systemProvider.getUnSyncTransactions();
  }

  @override
  void initState() {
    // TODO: implement initState
    updateValue();
    super.initState();
  }

  void updateValue() async {
    await getUnSyncTransactions(systemProvider);
    setState(() {
      _productSearchResult = transactionData!;
      _foundProducts = _productSearchResult;
    });
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
            'Waiting to Sync',
            style: TextStyle(color: whiteColor),
          ),
          actions: [
            IconButton(
                color: whiteColor,
                onPressed: () {},
                icon: Icon(MdiIcons.filter))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: FloatingActionButton.extended(
              backgroundColor: primaryColor,
              onPressed: () async {
                setState(() {
                  _isLoading = !_isLoading;
                });
                UserDetails user =
                    Provider.of<UserProvider>(context, listen: false).user;
                var response = await systemProvider.syncAllTransactions(user);
                log("response value ==>> ${response.toString()}");
                if (response['status'] == true) {
                  setState(() {
                    _isLoading = !_isLoading;
                  });
                  Dialogs.alertDialog(
                      context,
                      "Success",
                      "Transactions have been successfully synced to the cloud.",
                      "cancel",
                      "save", []);
                  return;
                } else {
                  setState(() {
                    _isLoading = !_isLoading;
                  });
                  Dialogs.alertDialog(
                      context,
                      "Error",
                      "Unable to sync transactions to cloud!",
                      "cancel",
                      "save", []);
                  return;
                }
              },
              label: _isLoading == true
                  ? const Text('Syncing...')
                  : const Text('Sync All'),
              icon: const Icon(Icons.sync),
            )),
        // drawer: SideNavigation(),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  PrimaryTextField(
                    controller: searchTextController,
                    hintText: 'Search by transaction ID',
                    title: '',
                    onChanged: (value) {
                      _searchProducts(value);
                    },
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: GestureDetector(onTap: () {
                      searchTextController.clear();
                      setState(() {
                        _productSearchResult = transactionData!;
                        _foundProducts = _productSearchResult;
                      });
                    }, child: Icon(Icons.cancel, color: Colors.deepPurple,),),
                  ),

              // Material(
              //     elevation: 10,
              //     shadowColor: Colors.black38,
              //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     child: OutlineSearchBar(
              //       borderColor: primaryColor,
              //       hintText: "Search by txn ID...",
              //       onSearchButtonPressed: (value) {},
              //       onKeywordChanged: (value) {},
              //       searchButtonIconColor: primaryColor,
              //       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     )),
              const SizedBox(
                height: 10,
              ),
              transactionData.isNotEmpty && _foundProducts.isNotEmpty ? Expanded(
                  child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _foundProducts.isNotEmpty ? _foundProducts.length : 0,
                          itemBuilder: (context, index) {
                            var product = _foundProducts[index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ReceiptPrint(
                                            systemProvider: systemProvider,
                                            txnID: product.trxId,
                                          )));
                                },
                                child: ListTile(
                                  // leading: const Icon(Icons.payment),
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.trxId,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Date: ${doDate(DateTime.parse(product.createdAt.toString()))}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent,
                                              fontSize: 12),
                                        )
                                      ]),
                                  subtitle: Text(
                                      "Customer:  ${product.customerName}"),
                                  trailing: Text(
                                    Money.format(product.amount),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ));

                      })
              ) :  Center(
                child: Center(
                  child: Text("Nothing to sync"),
                ),
              )])));
  }

  void _searchProducts(String? value) {
    print("Onchanged called");
    if(searchTextController.text.isEmpty) {
      // If the search field is empty or only contains white-space
      setState(() {
        _productSearchResult = transactionData!;
        _foundProducts = _productSearchResult;
      });
    } else {
      setState(() {
        _productSearchResult = transactionData!.where((beneficiary) {
          return beneficiary.trxId.toLowerCase().contains(searchTextController.text.toLowerCase());
        }).toList();
        _foundProducts = _productSearchResult;
      });
      //debugPrint(_foundProducts.toString());
    }
    debugPrint("found productssss ==>>> ${_foundProducts.toString()}");
  }
}
