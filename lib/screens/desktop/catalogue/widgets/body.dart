import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'card.dart';
import 'header.dart';
import '../../../../widgets/sidebar.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final String app;

  const Body({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.app,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ValueNotifier<String> _activeItem = ValueNotifier<String>("Catalogues");
  Map<String, dynamic>? _productAnalytics;
  bool _isLoadingStats = false;

  @override
  void initState() {
    super.initState();
    _loadProductAnalytics();
  }

  @override
  void dispose() {
    _activeItem.dispose();
    super.dispose();
  }

  // **UPDATED: Load product analytics from API response**
  Future<void> _loadProductAnalytics() async {
    setState(() {
      _isLoadingStats = true;
    });

    try {
      // **FIXED: Use the new method to get analytics from API response**
      final analyticsData = await widget.systemProvider.fetchProductsWithAnalytics();
      
      setState(() {
        _productAnalytics = analyticsData;
        _isLoadingStats = false;
      });

      print('✅ Successfully loaded product analytics');
      print('📊 Analytics data: $_productAnalytics');
    } catch (e) {
      print('❌ Error loading product analytics: $e');
      setState(() {
        _isLoadingStats = false;
        // Set fallback values on error
        _productAnalytics = {
          'meta': {'total': 0},
          'analytics': {
            'in_stock': 0,
            'out_of_stock': 0,
            'total_stock_value': 0.0,
          }
        };
      });
    }
  }

  // **UPDATED: Show out of stock products using API data**
  void _showOutOfStockProducts() async {
    try {
      final outOfStockProducts = await widget.systemProvider.getOutOfStockProducts();
      
      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Out of Stock Products (${outOfStockProducts.length})",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: outOfStockProducts.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "No out-of-stock products found",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16.0),
                        itemCount: outOfStockProducts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        itemBuilder: (context, index) {
                          var product = outOfStockProducts[index]['attributes'];
                          return ProductDetails(product: product);
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading out-of-stock products: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // **UPDATED: Build store cards using API analytics data**
  List<Widget> _buildStoreCards() {
    if (_isLoadingStats || _productAnalytics == null) {
      return [
        const HomeCard(title: "Products", value: "Loading..."),
        const HomeCard(title: "In Stock", value: "Loading..."),
        const HomeCard(title: "Out of stock", value: "Loading..."),
        const HomeCard(title: "Categories", value: "Loading..."),
      ];
    }

    // **FIXED: Extract data from API response analytics**
    final meta = _productAnalytics!['meta'] ?? {};
    final analytics = _productAnalytics!['analytics'] ?? {};
    
    final totalProducts = meta['total']?.toString() ?? '0';
    final inStockCount = analytics['in_stock']?.toString() ?? '0';
    final outOfStockCount = analytics['out_of_stock']?.toString() ?? '0';
    final categoryCount = widget.systemProvider.dashboardStats['categoryCount']?.toString() ?? '0';

    // **NEW: Calculate stock value if available**
    final stockValue = analytics['total_stock_value'] ?? 0.0;
    final formattedStockValue = stockValue > 0 
        ? '₦${stockValue.toStringAsFixed(2)}' 
        : 'N/A';

    return [
      HomeCard(
        title: "Products",
        value: totalProducts,
        subtitle: "Total inventory items",
      ),
      HomeCard(
        title: "In Stock",
        value: inStockCount,
        subtitle: "Available products",
        color: Colors.green,
      ),
      HomeCard(
        title: "Out of stock",
        value: outOfStockCount,
        subtitle: "Needs restocking",
        color: Colors.red,
        onViewPressed: outOfStockCount != '0' ? _showOutOfStockProducts : null,
      ),
      HomeCard(
        title: "Categories",
        value: categoryCount,
        subtitle: "Product categories",
      ),
      if (stockValue > 0)
        HomeCard(
          title: "Stock Value",
          value: formattedStockValue,
          subtitle: "Total inventory value",
          color: Colors.blue,
        ),
    ];
  }

  // **UPDATED: Build hotel cards (unchanged)**
  List<Widget> _buildHotelCards() {
    return [
      HomeCard(
        title: "Customers",
        value: "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}",
      ),
      HomeCard(
        title: "Hotel Categories",
        value: "${widget.systemProvider.dashboardStats['hotelCategoryCount'] ?? '0'}",
      ),
      HomeCard(
        title: "Hotel Amenities",
        value: "${widget.systemProvider.dashboardStats['hotelAmenityCount'] ?? '0'}",
      ),
      HomeCard(
        title: "Hotel Rooms",
        value: "${widget.systemProvider.dashboardStats['hotelRoomCount'] ?? '0'}",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    // Determine which cards to show based on user access permissions
    List<Widget> cardsToShow = [];
    if (widget.user.isSuperAdmin) {
      cardsToShow = [..._buildStoreCards(), ..._buildHotelCards()];
    } else if (widget.user.canAccessHotel && widget.user.canAccessStore) {
      cardsToShow = [..._buildStoreCards(), ..._buildHotelCards()];
    } else if (widget.user.canAccessHotel) {
      cardsToShow = _buildHotelCards();
    } else if (widget.user.canAccessStore) {
      cardsToShow = _buildStoreCards();
    } else {
      cardsToShow = _buildStoreCards();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: SizedBox(
                width: 250,
                child: widget.app == "HOTEL"
                    ? SideBarHotel(
                        vertical: 20,
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                      )
                    : SideBarInventory(
                        vertical: 20,
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                        activeItem: _activeItem,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // **UPDATED: Refresh button with better UX**
                        if (widget.user.canAccessStore)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // **NEW: Show last updated time**
                                if (_productAnalytics != null && _productAnalytics!['last_updated'] != null)
                                  Text(
                                    'Last updated: ${_formatLastUpdated(_productAnalytics!['last_updated'])}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ElevatedButton.icon(
                                  onPressed: _isLoadingStats ? null : _loadProductAnalytics,
                                  icon: _isLoadingStats
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.refresh),
                                  label: Text(_isLoadingStats ? 'Refreshing...' : 'Refresh Stats'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[50],
                                    foregroundColor: Colors.blue[700],
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: screenWidth > 1200 ? 1.5 : 1.3,
                          ),
                          children: cardsToShow,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // **NEW: Format last updated time**
  String _formatLastUpdated(String lastUpdatedStr) {
    try {
      final lastUpdated = DateTime.parse(lastUpdatedStr);
      final now = DateTime.now();
      final difference = now.difference(lastUpdated);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else {
        return '${difference.inDays}d ago';
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}




// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';

// import 'card.dart';
// import 'header.dart';
// import '../../../../widgets/sidebar.dart';

// class Body extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final String app;

//   const Body({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     required this.app,
//   });

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final ValueNotifier<String> _activeItem = ValueNotifier<String>("Catalogues");

//   @override
//   void dispose() {
//     _activeItem.dispose();
//     super.dispose();
//   }

//   void _showOutOfStockProducts() async {
//     final products = await widget.systemProvider.getProducts(0);
//     final outOfStockProducts = products
//         .where((product) => product['attributes']['stock']['quantity'] == 0)
//         .toList();

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.7,
//         minChildSize: 0.4,
//         maxChildSize: 0.9,
//         expand: false,
//         builder: (context, scrollController) => Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Out of Stock Products",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: outOfStockProducts.isEmpty
//                   ? const Center(child: Text("No out-of-stock products found"))
//                   : GridView.builder(
//                       controller: scrollController,
//                       padding: const EdgeInsets.all(16.0),
//                       itemCount: outOfStockProducts.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                         childAspectRatio: 1.5,
//                       ),
//                       itemBuilder: (context, index) {
//                         var product = outOfStockProducts[index]['attributes'];
//                         return ProductDetails(product: product);
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Method to build store-specific cards
//   List<Widget> _buildStoreCards() {
//     return [
//       HomeCard(
//           title: "Products",
//           value: "${widget.systemProvider.dashboardStats['productCount'] ?? '0'}"),
//       HomeCard(
//           title: "In Stock",
//           value: "${widget.systemProvider.dashboardStats['productStockOut'] ?? '0'}"),
//       HomeCard(
//           title: "Out of stock",
//           value: "${widget.systemProvider.dashboardStats['productsOutOfStock'] ?? '0'}",
//           onViewPressed: _showOutOfStockProducts),
//       HomeCard(
//           title: "Categories",
//           value: "${widget.systemProvider.dashboardStats['categoryCount'] ?? '0'}"),
//     ];
//   }

//   // Method to build hotel-specific cards
//   List<Widget> _buildHotelCards() {
//     return [
//       HomeCard(
//           title: "Customers",
//           value: "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}"),
//       HomeCard(
//           title: "Hotel Categories",
//           value: "${widget.systemProvider.dashboardStats['hotelCategoryCount'] ?? '0'}"),
//       HomeCard(
//           title: "Hotel Amenities",
//           value: "${widget.systemProvider.dashboardStats['hotelAmenityCount'] ?? '0'}"),
//       HomeCard(
//           title: "Hotel Rooms",
//           value: "${widget.systemProvider.dashboardStats['hotelRoomCount'] ?? '0'}"),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
    
//     // Determine which cards to show based on user access permissions
//     List<Widget> cardsToShow = [];
    
//     if (widget.user.isSuperAdmin) {
//       // Super admin sees all cards
//       cardsToShow = [..._buildStoreCards(), ..._buildHotelCards()];
//     } else if (widget.user.canAccessHotel && widget.user.canAccessStore) {
//       // User has access to both hotel and store
//       cardsToShow = [..._buildStoreCards(), ..._buildHotelCards()];
//     } else if (widget.user.canAccessHotel) {
//       // Hotel-only access
//       cardsToShow = _buildHotelCards();
//     } else if (widget.user.canAccessStore) {
//       // Store-only access
//       cardsToShow = _buildStoreCards();
//     } else {
//       // Fallback - show store cards for basic users
//       cardsToShow = _buildStoreCards();
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: SingleChildScrollView(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height,
//               ),
//               child: SizedBox(
//                 width: 250,
//                 child: widget.app == "HOTEL"
//                     ? SideBarHotel(
//                         vertical: 20,
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                       )
//                     : SideBarInventory(
//                         vertical: 20,
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                         activeItem: _activeItem,
//                       ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Header(
//                     user: widget.user,
//                     systemProvider: widget.systemProvider,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: GridView(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: 300,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                         childAspectRatio: screenWidth > 1200 ? 1.5 : 1.3,
//                       ),
//                       children: cardsToShow,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }