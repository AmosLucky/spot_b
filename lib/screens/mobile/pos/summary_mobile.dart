import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'success_mobile.dart';

class SummaryMobile extends StatefulWidget {
  final SystemProvider systemProvider;
  final data;
  final String customer;
  const SummaryMobile(
      {super.key,
      required this.systemProvider,
      required this.data,
      required this.customer});

  @override
  State<SummaryMobile> createState() => _SummaryMobileState();
}

class _SummaryMobileState extends State<SummaryMobile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer<CartProvider>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            title: const Text(
              'Txn Summary',
              style: TextStyle(color: whiteColor),
            ),
            actions: [],
          ),
          body: SizedBox(
            height: screenSize.height,
            width: double.infinity,
            child: value.items.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.items.length,
                    itemBuilder: (context, index) {
                      var product = value.items[index];
                      return ListTile(
                        leading: const Icon(Icons.payment),
                        title: Text(
                          product.product!['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(Money.format(product.totalAmount!)),
                        trailing: Text(
                          "Qty: ${product.quantity.toString()}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      );
                    },
                  ),
          ),
          bottomNavigationBar: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 213, 212, 212), //New
                      blurRadius: 8.0,
                      offset: Offset(0, -6))
                ],
              ),
              // color: ColorsRes.white,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Subtotal:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(Money.format(value.getTotalPrice()))
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonGradWidget(
                            onPress: () async {
                              var response = await value.checkout(context,
                                  value.getTotalPrice(), widget.customer);
                              print("=========== successful ========");
                              print(response);
                              if (response['status'] == true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SuccessMobile(
                                          systemProvider: widget.systemProvider,
                                          data: value,
                                          txnID: response['txnID'],
                                          customer: widget.customer,
                                        )));
                              }
                            },
                            title: 'Proceed',
                            isLoading: false,
                            buttonColor: primaryColor,
                            titleColor: whiteColor,
                            borderColor: primaryColor,
                            paddingHorizontal: 15.0,
                            paddingVertical: 15.0,
                          ),
                        ),
                      ])))),
    );
  }
}
