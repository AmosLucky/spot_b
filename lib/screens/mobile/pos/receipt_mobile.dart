import 'dart:convert';
import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/screens/print.dart';
import 'package:spotstock_inventory/widgets/custom_widgets.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../common/provider/user_provider.dart';
import '../../../data/models/user_details.dart';
import '../../desktop/pos/list_printers.dart';

class ReceiptPrint extends StatefulWidget {
  final SystemProvider systemProvider;
  final String txnID;
  const ReceiptPrint(
      {super.key, required this.systemProvider, required this.txnID,});

  @override
  State<ReceiptPrint> createState() => _ReceiptPrintState();
}

class _ReceiptPrintState extends State<ReceiptPrint> {
  Future<Map<String, dynamic>> getReceiptTxn() async {
    return await widget.systemProvider.getReceiptTxn(widget.txnID);
  }

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    UserDetails user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Receipt',
            style: TextStyle(color: whiteColor),
          ),
          actions: [],
        ),
        // bottomNavigationBar: Container(
        //     height: 70,
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(
        //             color: Color.fromARGB(255, 213, 212, 212), //New
        //             blurRadius: 8.0,
        //             offset: Offset(0, -6))
        //       ],
        //     ),
        //     // color: ColorsRes.white,
        //     child: Padding(
        //         padding: const EdgeInsets.all(10),
        //         child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               SizedBox(
        //                 width: double.infinity,
        //                 child: ButtonGradWidget(
        //                   onPress: () async {

        //                   },
        //                   title: 'Print',
        //                   isLoading: false,
        //                   buttonColor: primaryColor,
        //                   titleColor: whiteColor,
        //                   borderColor: primaryColor,
        //                   paddingHorizontal: 15.0,
        //                   paddingVertical: 15.0,
        //                 ),
        //               ),
        //             ]))),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                  future: getReceiptTxn(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      // Future hasn't finished yet, return a placeholder
                      return const Text('Loading');
                    }
                    print("-----------txn receipt------------");
                    log('Loading Complete: ${snapshot.data}');
                    var result = snapshot.data!;
                    var items = jsonDecode(result['items']);
                    var others = jsonDecode(result['others']);
                    List<dynamic> widgets = items
                        .map((item) => listItemContainer(
                            item['product']['name'],
                            "${item['product']['Net_price']} X ${item['quantity']}"))
                        .toList();
                    return Column(
                      children: [
                        listItemContainer(
                            "Customer", "${result['customerName']}"),
                        listItemContainer(
                            "Txn Reference", "${result['trxId']}"),
                        listItemContainer("Txn Date",
                            doDate(DateTime.parse(result['createdAt'].toString() ?? ""))),
                        listItemContainer("Total Items", "${items.length}"),
                        Column(
                          children: items
                              .map<Widget>((item) => listItemContainer(
                                  item['product']['name'],
                                  "${item['product']['product_price']} X ${item['quantity'] ?? ""}"))
                              .toList(),
                        ),
                        listItemContainer(
                            "Total Amount", Money.format(result['amount'] ?? "")),
                        listItemContainer(
                            "Payment Method", "${result['paymentMethod'] ?? ""}"),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ButtonGradWidget(
                                onPress: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PrintReceipt(
                                              data: result, items: items, others: others,)));
                                },
                                title: 'Continue',
                                isLoading: false,
                                buttonColor: primaryColor,
                                titleColor: whiteColor,
                                borderColor: primaryColor,
                                paddingHorizontal: 15.0,
                                paddingVertical: 15.0,
                              ),
                            ))
                      ],
                    );
                  }),
            )));
  }

}

Widget listItemContainer(String title, String value) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: whiteColor,
          border: Border(bottom: BorderSide(width: 1.0, color: whiteColor))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
