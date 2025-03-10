

import 'package:screenshot/screenshot.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'receipt_mobile.dart';

class SuccessMobile extends StatefulWidget {
  final SystemProvider systemProvider;
  //final UserDetails user;
  final data;
  final String customer;
  final String txnID;
  const SuccessMobile(
      {super.key,
      required this.systemProvider,
      required this.data,
        //required this.user,
      required this.txnID,
      required this.customer});

  @override
  State<SuccessMobile> createState() => _SuccessMobileState();
}

int _counter = 0;

//Create an instance of ScreenshotController
ScreenshotController screenshotController = ScreenshotController();

class _SuccessMobileState extends State<SuccessMobile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Screenshot(
          controller: screenshotController,
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
              Center(
                child: Icon(
                  Icons.check_circle_outline,
                  size: 60,
                  color: Colors.greenAccent,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text("Success!",
                      style: TextStyle(
                          color: secondColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w800)),
                ),
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.all(7.0),
                        padding: const EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: SelectableText(
                          "${widget.txnID}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(' Txn Reference '),
                        )),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(85, 20, 85, 20),
                  child: Text(
                      "You have successfully purchased goods worth of ${widget.data.getTotalPrice()} Naira",
                      style: TextStyle(color: Color(0xff063057), fontSize: 14),
                      textAlign: TextAlign.center),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: SizedBox(
                  width: double.infinity,
                  child: ButtonGradWidget(
                    onPress: () {
                      widget.data.removeAll();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ReceiptPrint(
                                systemProvider: widget.systemProvider,
                                txnID: widget.txnID,
                              )));
                    },
                    title: 'Print Receipt',
                    isLoading: false,
                    buttonColor: primaryColor,
                    titleColor: whiteColor,
                    borderColor: primaryColor,
                    paddingHorizontal: 15.0,
                    paddingVertical: 15.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                  child: Center(
                      child: SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreenMobile(),
                                  ));
                            },
                            child: Text(
                              "Go Home",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )))),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: viewMoreButtons("View Transaction Details",
              //         () => {showPowerBottomSheet(context)}),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getReceiptTxn() async {
    return await widget.systemProvider.getReceiptTxn(widget.txnID);
  }

}

MaterialButton viewMoreButtons(String title, VoidCallback fun) {
  return MaterialButton(
    onPressed: fun,
    textColor: Colors.white,
    color: const Color(0xffFFAC38),
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.left,
      ),
    ),
    height: 55,
    minWidth: 700,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  );
}

showPowerBottomSheet(BuildContext context) => showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: 600,
        color: Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
              )),
          child: Column(
            children: <Widget>[
              viewMoreButtons(
                  "Close Transaction", () => {Navigator.pop(context)}),
              SizedBox(height: 10),
              listItemContainer("Date of Transaction", "17th April, 2019"),
              listItemContainer("Transaction References", "KED12435353636"),
              listItemContainer("Token", "1234 5668 4657 3849"),
              listItemContainer("Account Type", "Prepaid"),
            ],
          ),
        ),
      );
    });

Widget listItemContainer(String title, String value) => Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(196, 196, 196, 1)),
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
        ],
      ),
      decoration: BoxDecoration(
          border: new Border(
              bottom: new BorderSide(width: 1.0, color: Color(0xffC4C4C4)))),
    );
