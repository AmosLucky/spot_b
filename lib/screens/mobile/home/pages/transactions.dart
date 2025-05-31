import 'dart:convert';
import 'dart:developer';

import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/mobile/pos/receipt_mobile.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../common/primary_text_field.dart';
import '../../../../data/models/schema.dart';

class TransactionsMobileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> HomeKey;
  final UserDetails user;
  const TransactionsMobileScreen(
      {super.key, required this.HomeKey, required this.user});

  @override
  State<TransactionsMobileScreen> createState() =>
      _TransactionsMobileScreenState();
}

final systemProvider = SystemProvider();

class _TransactionsMobileScreenState extends State<TransactionsMobileScreen> {

  List? data;
  List? transactionData;
  String? id;
  String? time;
  List _productSearchResult = [];
  List? _foundProducts;
  bool? loading;
  //List? _products;
  Orders? product;
  final searchTextController = TextEditingController();
  //String? id;

  void getTransactions() async {
    setState(() {
      loading = true;
    });
    transactionData = await systemProvider.getTransactions();
    data = jsonDecode(transactionData![0].items);
    log("Transaction Data ==>>> $data");
    id = transactionData![1].trxId;
     time = transactionData![1].createdAt.toString();
setState(() {
  _productSearchResult = transactionData!;
  _foundProducts = _productSearchResult;
});
    log("Found product ==>> $data");
    log("Transaction Data ==>>> $id");
    log("Transaction Data ==>>> $time");
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print('start');
    getTransactions();
    print('end');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SystemProvider>(
      create: (context) => SystemProvider(),
      child: Consumer<SystemProvider>(
        builder: (context, systemProvider, _) {
          return RefreshIndicator(
              onRefresh: () => systemProvider.refreshData,
              child: _transactionsList(context, systemProvider));
        },
      ),
    );
  }

  Widget _transactionsList(
      BuildContext context, SystemProvider systemProvider) {
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
            'Transaction History',
            style: TextStyle(color: whiteColor),
          ),
          actions: [
            IconButton(
                color: whiteColor,
                onPressed: () {},
                icon: Icon(MdiIcons.filter))
          ],
        ),
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
              !loading! ? Expanded(
                  child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _foundProducts!.isNotEmpty ? _foundProducts!.length : 0,
                          itemBuilder: (context, index) {
                            //log('Trx Loading Complete: ${snapshot.data.toString()}');
                            var product = data![0];
                           // print("Product info ===> $product");
                            var productDetail = _foundProducts?[index];
                            //print("Productssss ===>>>> $_products");
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ReceiptPrint(
                                            systemProvider: systemProvider,
                                            txnID: productDetail.trxId,
                                          )));
                                },
                                child: ListTile(
                                  // leading: const Icon(Icons.payment),
                                  title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productDetail.trxId,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Date: ${doDate(DateTime.parse(productDetail.createdAt.toString()))}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent,
                                              fontSize: 12),
                                        )
                                      ]),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Customer:  ${productDetail.customerName}"),
                                      Text(productDetail.paymentMethod, style: TextStyle(color: Colors.redAccent),),
                                    ],
                                  ),
                                  trailing: Text(
                                    Money.format(productDetail.amount),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ));
                          },
                        )
                      ) : SizedBox()
            ])));
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
    debugPrint(_foundProducts.toString());
  }
}
