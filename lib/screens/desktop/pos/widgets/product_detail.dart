import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/custom_widgets.dart';

class ProductDetails extends StatefulWidget {
  final Map product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final price = (widget.product['product_price'] as num?)?.toDouble() ?? 0.0;
    Money.format(price);
    
    final bool isOutOfStock = widget.product['stock']['quantity'] == 0;
    final String productName = capitalize(widget.product['name']);

    // Use a fallback image URL if no valid image URL is found
    final String imageUrl = (widget.product['images'] is Map &&
            widget.product['images']['imageUrls'] is List &&
            widget.product['images']['imageUrls'].isNotEmpty &&
            widget.product['images']['imageUrls'][0] is String)
        ? widget.product['images']['imageUrls'][0]
        : 'https://static.vecteezy.com/system/resources/previews/006/059/989/non_2x/crossed-camera-icon-avoid-taking-photos-image-is-not-available-illustration-free-vector.jpg';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: productName,
        showDuration: const Duration(seconds: 3),
        waitDuration: const Duration(milliseconds: 500),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isOutOfStock ? 0.4 : 1.0,
          child: Stack(
            children: <Widget>[
              // Background Image Container
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(imageUrl),
                  ),
                ),
              ),
              
              // Gradient Overlay for better text visibility
              Container(
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
                    
                    // Stock Status Badge
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
                              : "Qty: ${widget.product['stock']['quantity']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Product Name with better visibility
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
                    
                    // Price with better visibility
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
              ),
              
              // Out of Stock Overlay
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
              
              // Hover Effect for Full Name Display
              if (_isHovered && productName.length > 20)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      productName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:flutter/material.dart';
// import '../../../../widgets/custom_widgets.dart';

// class ProductDetails extends StatelessWidget {
//   final Map product;
//   const ProductDetails({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final price = (product['product_price'] as num?)?.toDouble() ?? 0.0;
//     Money.format(price);

//     // Use a fallback image URL if no valid image URL is found
//     final String imageUrl = (product['images'] is Map &&
//             product['images']['imageUrls'] is List &&
//             product['images']['imageUrls'].isNotEmpty &&
//             product['images']['imageUrls'][0] is String)
//         ? product['images']['imageUrls'][0]
//         : 'https://static.vecteezy.com/system/resources/previews/006/059/989/non_2x/crossed-camera-icon-avoid-taking-photos-image-is-not-available-illustration-free-vector.jpg'; // Placeholder image URL

//     return Stack(
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: Colors.transparent,
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: CachedNetworkImageProvider(imageUrl),
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(0.0),
//           alignment: Alignment.bottomCenter,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             gradient: LinearGradient(
//               begin: FractionalOffset.topCenter,
//               end: FractionalOffset.bottomCenter,
//               colors: [
//                 Colors.grey.withOpacity(0.0),
//                 Colors.black54,
//               ],
//               stops: const [0.0, 1.0],
//             ),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 0),
//               // Check if the product is out of stock
//               product['stock']['quantity'] == 0
//                   ? Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         height: 20,
//                         width: 90,
//                         child: Material(
//                           color: primaryColor,
//                           elevation: 13,
//                           shadowColor: Colors.black54,
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: const Center(
//                             child: Text(
//                               "Out of stock",
//                               style: TextStyle(color: whiteColor),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         height: 20,
//                         width: 90,
//                         child: Material(
//                           color: Colors.black12,
//                           elevation: 13,
//                           shadowColor: Colors.black54,
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Center(
//                             child: Text(
//                               "Qty: ${product['stock']['quantity']}",
//                               overflow: TextOverflow.fade,
//                               style: const TextStyle(color: whiteColor),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//               const SizedBox(height: 10),
//               Text(
//                 capitalize(product['name']),
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.yellow,
//                 ),
//               ),
//               Text(
//                 "$price",
//                 overflow: TextOverflow.fade,
//                 style: const TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }