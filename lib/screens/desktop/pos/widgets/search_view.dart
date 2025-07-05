import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/style.dart';
import 'package:spotstock_inventory/widgets/custom_widgets.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';

import '../../../../common/provider/cart_provider.dart';

class SearchView extends StatelessWidget {
  final List<dynamic> dataProducts;
  final Future<List<dynamic>> Function() getProducts;
  final TextEditingController barcodeController;
  final Size mediaQuery;
  final VoidCallback tapInvoiceOpen;
  final VoidCallback playSound;

  const SearchView({
    super.key,
    required this.dataProducts,
    required this.getProducts,
    required this.barcodeController,
    required this.mediaQuery,
    required this.tapInvoiceOpen,
    required this.playSound,
  });

  @override
  Widget build(BuildContext context) {
    return dataProducts.isNotEmpty && barcodeController.text.isNotEmpty
        ? searchView(dataProducts)
        : const SizedBox();
  }

  Padding searchView(List<dynamic> products) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: mediaQuery.height - 50,
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Adjust columns based on design
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index]['attributes'];
            return buildProductItem(index, product);
          },
        ),
      ),
    );
  }

  Widget buildProductItem(index, Map<String, dynamic> product) {
    final String imageUrl = getProductImageUrl(product);
    final bool isOutOfStock = product['stock']['quantity'] == 0;
    final String productName = capitalize(product['name']);

    return Consumer<CartProvider>(
        builder: (context, value, child) => InkWell(
              onTap: () {
                print("Selected index === $index");
                print("Product tapped: $product");
                if (isOutOfStock) {
                  Dialogs.alertDialog(context, "Warning",
                      "Product is out of stock!", "cancel", "save", []);
                } else {
                  // tapInvoiceOpen();
                  value.add(product, index, generateRandomString(12),
                      product['product_price'], 1, product['product_code']);
                  playSound();
                }
              },
              child: Tooltip(
                message: productName,
                showDuration: const Duration(seconds: 3),
                waitDuration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isOutOfStock ? 0.4 : 1.0, // Apply faint effect for out of stock
                  child: Stack(
                    children: <Widget>[
                      buildProductImage(imageUrl),
                      buildProductInfoOverlay(product),
                      // Out of Stock Overlay (same as ProductDetails)
                      if (isOutOfStock)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.block,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget buildProductImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200], // Same background color as ProductDetails
        image: DecorationImage(
          fit: BoxFit.cover, // Changed from BoxFit.fill to BoxFit.cover for consistency
          image: CachedNetworkImageProvider(imageUrl),
        ),
      ),
    );
  }

  Widget buildProductInfoOverlay(Map<String, dynamic> product) {
    final price = (product['product_price'] as num?)?.toDouble() ?? 0.0;
    final bool isOutOfStock = product['stock']['quantity'] == 0;
    final String productName = capitalize(product['name']);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.8),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          
          // Stock Status Badge (consistent with ProductDetails)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isOutOfStock 
                    ? Colors.red.withOpacity(0.9)
                    : Colors.green.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                isOutOfStock 
                    ? "Out of Stock"
                    : "Qty: ${product['stock']['quantity']}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          const Spacer(),
          
          // Product Name with better visibility (consistent with ProductDetails)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black.withOpacity(0.6),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Text(
              productName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Price with better visibility (consistent with ProductDetails)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black.withOpacity(0.7),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 0.5,
              ),
            ),
            child: Text(
              "₦${price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String getProductImageUrl(Map<String, dynamic> product) {
    // Use the same placeholder image URL as ProductDetails for consistency
    if (product['images'] is Map &&
        product['images']['imageUrls'] is List &&
        product['images']['imageUrls'].isNotEmpty &&
        product['images']['imageUrls'][0] is String) {
      return product['images']['imageUrls'][0];
    }
    return 'https://static.vecteezy.com/system/resources/previews/006/059/989/non_2x/crossed-camera-icon-avoid-taking-photos-image-is-not-available-illustration-free-vector.jpg';
  }
}






// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/cart_provider.dart';
// import 'package:spotstock_inventory/common/style.dart';
// import 'package:spotstock_inventory/widgets/custom_widgets.dart';
// import 'package:spotstock_inventory/widgets/dialogs.dart';

// class SearchView extends StatelessWidget {
//   final List<dynamic> dataProducts;
//   final Future<List<dynamic>> Function() getProducts;
//   final TextEditingController barcodeController;
//   final Size mediaQuery;
//   final VoidCallback tapInvoiceOpen;
//   final VoidCallback playSound;

//   const SearchView({
//     super.key,
//     required this.dataProducts,
//     required this.getProducts,
//     required this.barcodeController,
//     required this.mediaQuery,
//     required this.tapInvoiceOpen,
//     required this.playSound,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return dataProducts.isNotEmpty && barcodeController.text.isNotEmpty
//         ? searchView(dataProducts)
//         : const SizedBox();
//   }

//   Padding searchView(List<dynamic> products) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SizedBox(
//         height: mediaQuery.height - 50,
//         child: GridView.builder(
//           padding: const EdgeInsets.all(8.0),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4, // Adjust columns based on design
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 1.5,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, index) {
//             final product = products[index]['attributes'];
//             return buildProductItem(index, product);
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildProductItem(index, Map<String, dynamic> product) {
//     final String imageUrl = getProductImageUrl(product);

//     return Consumer<CartProvider>(
//         builder: (context, value, child) => InkWell(
//               onTap: () {
//                 print("Selected index === $index");
//                 print("Product tapped: $product");
//                 if (product['stock']['quantity'] == 0) {
//                   Dialogs.alertDialog(context, "Warning",
//                       "Product is out of stock!", "cancel", "save", []);
//                 } else {
//                   // tapInvoiceOpen();
//                   value.add(product, index, generateRandomString(12),
//                       product['product_price'], 1, product['product_code']);
//                   playSound();
//                 }
//               },
//               child: Stack(
//                 children: <Widget>[
//                   buildProductImage(imageUrl),
//                   buildProductInfoOverlay(product),
//                 ],
//               ),
//             ));
//   }

//   Widget buildProductImage(String imageUrl) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.transparent,
//         image: DecorationImage(
//           fit: BoxFit.fill,
//           image: CachedNetworkImageProvider(imageUrl),
//         ),
//       ),
//     );
//   }
//   Widget buildProductInfoOverlay(Map<String, dynamic> product) {
//     return Container(
//       padding: const EdgeInsets.all(5.0),
//       alignment: Alignment.bottomCenter,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         gradient: LinearGradient(
//           begin: FractionalOffset.topCenter,
//           end: FractionalOffset.bottomCenter,
//           colors: [
//             Colors.grey.withOpacity(0.0),
//             Colors.black54,
//           ],
//           stops: const [0.0, 1.0],
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           buildStockStatus(product),
//           const SizedBox(height: 5),
//           Text(
//             capitalize(product['name']),
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 15.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.yellow,
//             ),
//           ),
//           Text(
//             Money.format(product['product_price']),
//             overflow: TextOverflow.fade,
//             style: const TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildStockStatus(Map<String, dynamic> product) {
//     final String stockQuantity = product['stock']['quantity']?.toString() ?? "0.00";
//     final bool isOutOfStock = stockQuantity == "0" || stockQuantity == "0.00";
//     final stockStatus = isOutOfStock ? "Out of stock" : stockQuantity;

//     return Align(
//       alignment: Alignment.topRight,
//       child: SizedBox(
//         height: 20,
//         width: 90,
//         child: Material(
//           color: isOutOfStock ? primaryColor : Colors.black12,
//           elevation: 13,
//           shadowColor: Colors.black54,
//           borderRadius: BorderRadius.circular(10.0),
//           child: Center(
//             child: Text(
//               'Qty: $stockStatus',
//               overflow: TextOverflow.fade,
//               style: TextStyle(color: whiteColor, fontSize: stockQuantity == "0" || stockQuantity == "0.00" ? 9 : 12),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String getProductImageUrl(Map<String, dynamic> product) {
//     if (product['images'] is Map &&
//         product['images']['imageUrls'] is List &&
//         product['images']['imageUrls'].isNotEmpty &&
//         product['images']['imageUrls'][0] is String) {
//       return product['images']['imageUrls'][0];
//     }
//     return 'https://via.placeholder.com/150';
//   }
// }
