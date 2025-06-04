import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/custom_widgets.dart';

class ProductDetails extends StatelessWidget {
  final Map product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final price = (product['product_price'] as num?)?.toDouble() ?? 0.0;
    Money.format(price);
    // Check if the 'images' field exists and is a Map
    // if (product['images'] is Map) {
    //   // Check if the 'imageUrls' field exists and is a List
    //   if (product['images']['imageUrls'] is List) {
    //     final List<dynamic> imageUrls = product['images']['imageUrls'];

    //     // Check if the list is not empty and the first element is a string
    //     if (imageUrls.isNotEmpty && imageUrls[0] is String) {
    //       final String imageUrl = imageUrls[0];
    //       print("Image URL: $imageUrl"); // Debugging: Print the image URL
    //     } else {
    //       print("Error: 'imageUrls' is empty or contains invalid data.");
    //     }
    //   } else {
    //     print("Error: 'imageUrls' is not a list.");
    //   }
    // } else {
    //   print("Error: 'images' is not a map or is missing.");
    // }

    // Use a fallback image URL if no valid image URL is found
    final String imageUrl = (product['images'] is Map &&
            product['images']['imageUrls'] is List &&
            product['images']['imageUrls'].isNotEmpty &&
            product['images']['imageUrls'][0] is String)
        ? product['images']['imageUrls'][0]
        : 'https://via.placeholder.com/150'; // Placeholder image URL

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(imageUrl),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black54,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 0),
              // Check if the product is out of stock
              product['stock']['quantity'] == 0
                  ? Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 20,
                        width: 90,
                        child: Material(
                          color: primaryColor,
                          elevation: 13,
                          shadowColor: Colors.black54,
                          borderRadius: BorderRadius.circular(10.0),
                          child: const Center(
                            child: Text(
                              "Out of stock",
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 20,
                        width: 90,
                        child: Material(
                          color: Colors.black12,
                          elevation: 13,
                          shadowColor: Colors.black54,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Center(
                            child: Text(
                              "Qty: ${product['stock']['quantity']}",
                              overflow: TextOverflow.fade,
                              style: const TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Text(
                capitalize(product['name']),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
              Text(
                "$price",
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
