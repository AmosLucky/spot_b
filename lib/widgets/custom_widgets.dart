import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';
// import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import '../common/common.dart';
import '../common/navigation.dart';
import '../common/provider/user_provider.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({
    super.key,
    this.count,
  });

  final String? count;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(
            child: Text(
          count ?? "0",
          style: const TextStyle(color: Colors.black, fontSize: 7),
        )));
  }
}

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.screenSize,
      required this.cartProvider,
      required this.product,
      required this.trackID,
      required this.quantity,
      required this.amount,
      required this.del});

  final Size screenSize;
  final Map product;
  final String trackID;
  final int quantity, amount;
  final VoidCallback del;
  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: screenSize.height * 0.19,
      width: screenSize.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 3)
          ]),
      child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                height: screenSize.height * 0.13,
                width: screenSize.width * 0.3,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                imageUrl:
                    "https://gagahotels.ebeanomarket.com/public/images/products/${product['image']}",
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    capitalize(product['name']),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(Money.format(product['Net_price']),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    )),
                // // InputQty(
                // //   minVal: 1.0,
                // //   maxVal: double.maxFinite, //max val to go
                // //   initVal: quantity.toDouble(), //min starting val
                //   // initVal: 1,
                //   onQtyChanged: (val) {
                //     //on value changed we may set the value
                //     //setstate could be called
                //     print(trackID);
                //     cartProvider.updateProduct(
                //         product, trackID, amount, val!.truncate());
                //   },
                // ),
              ],
            ),
          ])),
    );
  }
}

// class CartItem2 extends StatelessWidget {
//   const CartItem2(
//       {Key? key,
//       required this.screenSize,
//       required this.cartProvider,
//       required this.product,
//       required this.trackID,
//       required this.quantity,
//       required this.amount,
//       required this.del})
//       : super(key: key);

//   final Size screenSize;
//   final Map product;
//   final String trackID;
//   final int quantity, amount;
//   final VoidCallback del;
//   final CartProvider cartProvider;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         title: Text(
//           capitalize(product['name']),
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(Money.format(product['Net_price'])),
//         trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: () {
//                           cartProvider.decrementQuantity(index);
//                         },
//                       ),
//                       Text(
//                         cart.products[index].quantity.toString(),
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: () {
//                           cartProvider.incrementQuantity(index);
//                         },
//                       ),
//                     ],
//                   ));
//   }
// }

class AppBarButton extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;
  final VoidCallback? onPressed;

  const AppBarButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color(0xff16b5fc),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        color: Color(0xFFffffff),
        onPressed: onPressed,
      ),
    );
  }
}

// ignore: must_be_immutable
class ExpandableText extends StatefulWidget {
  ExpandableText(this.text, {super.key});

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedSize(
          duration: const Duration(milliseconds: 500),
          child: ConstrainedBox(
              constraints: widget.isExpanded
                  ? BoxConstraints()
                  : BoxConstraints(maxHeight: 50.0),
              child: Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      widget.isExpanded
          ? ConstrainedBox(constraints: BoxConstraints())
          : GestureDetector(
              child: const Text(
                'show more...',
                style: TextStyle(color: Color(0xff36abe0)),
              ),
              onTap: () => setState(() => widget.isExpanded = true))
    ]);
  }
}

class CustomTabBar extends StatelessWidget {
  final List icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTabBar({
    super.key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, 15),
        child: TabBar(
          labelPadding: EdgeInsets.only(right: 10.0),
          indicatorPadding: EdgeInsets.zero,
          labelStyle: TextStyle(color: primaryColor, fontSize: 12.0),
          labelColor: primaryColor,
          unselectedLabelColor: grayColor,
          indicator: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: primaryColor,
                width: 3.0,
              ),
            ),
          ),
          tabs: icons
              .asMap()
              .map(
                  //i = index, e = icon
                  (i, e) => MapEntry(
                        i,
                        Tab(
                          text: e.title,
                          iconMargin: EdgeInsets.only(bottom: 0.0),
                          icon: Icon(
                            e.icon,
                            color: i == selectedIndex
                                ? primaryColor
                                : Colors.black45,
                            size: 30.0,
                          ),
                        ),
                      ))
              .values
              .toList(),
          onTap: onTap,
        ));
  }
}

class ProfileAvatar extends StatelessWidget {
  final double? radius;
  final Color? bgcolor;

  const ProfileAvatar(
      {super.key, this.radius = 20.0, this.bgcolor = const Color(0xFF1777F2)});

  @override
  Widget build(BuildContext context) {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgcolor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        backgroundImage: NetworkImage(user.company!.logo),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }
}

Widget showImgSkeleton(BuildContext context,
    {double width = 70.0, double height = 70.0}) {
  return Container(
      child: SkeletonAnimation(
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
    ),
  ));
}

doDate(date) {
  // var now = new DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  String formattedTime = DateFormat('kk:mm:a').format(date);
  String formattedDate = formatter.format(date);
  return "$formattedDate $formattedTime";
}

searchDate(date) {
  // var now = new DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy');
  String formattedDate = formatter.format(date);
  return formattedDate;
}

String generateRandomString(int len) {
  var r = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
