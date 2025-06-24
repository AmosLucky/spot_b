import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';

import '../../providers/products_provider.dart';
import 'create_products_screen.dart';
// import 'package:spotstock_inventory/common/provider/products_provider.dart';
// import 'package:spotstock_inventory/screens/desktop/products/create_product_screen.dart';

class ProductsDesktopScreen extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;

  const ProductsDesktopScreen({
    Key? key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  }) : super(key: key);

  @override
  State<ProductsDesktopScreen> createState() => _ProductsDesktopScreenState();
}

class _ProductsDesktopScreenState extends State<ProductsDesktopScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: LayoutBuilder(builder: (context, constraint) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
                maxWidth: widget.mediaQuery.width * 0.98,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: widget.mediaQuery.height * 0.98,
                    ),
                    child: SizedBox(
                      width: 220,
                      child: SideBarPos(
                        vertical: 20,
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                        activeItem: ValueNotifier<String>("Products"),
                        mediaQuery: widget.mediaQuery,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Products',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.black87),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Focus(
                                      onFocusChange: (hasFocus) {
                                        setState(() {
                                          _isSearchFocused = hasFocus;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: _isSearchFocused ? 300 : 200,
                                        child: TextField(
                                          controller: _searchController,
                                          decoration: InputDecoration(
                                            hintText: 'Search product...',
                                            prefixIcon: const Icon(
                                                Icons.search,
                                                size: 20),
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5),
                                            ),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 12),
                                            filled: true,
                                            fillColor: Colors.grey[50],
                                          ),
                                          onChanged: (value) =>
                                              provider.setSearchQuery(value),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          provider.fetchProducts(refresh: true),
                                      icon: const Icon(Icons.refresh, size: 20),
                                      tooltip: 'Refresh Data',
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (provider.isLoading) return;
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => CreateProductScreen(
                                            systemProvider: widget.systemProvider,
                                          ),
                                        ).then((result) {
                                          if (result == true) {
                                            provider.fetchProducts();
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF6B46C1),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text('Create Product',
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (provider.error != null)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                provider.error!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 12),
                                          filled: true,
                                          fillColor: Colors.grey[50],
                                        ),
                                        items: [
                                          'All Products',
                                          'In Stock',
                                          'Out of Stock'
                                        ].map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 12),
                                          filled: true,
                                          fillColor: Colors.grey[50],
                                        ),
                                        items: [
                                          'All Brands',
                                          'NIVEA',
                                          'LATAFA'
                                        ].map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 12),
                                          filled: true,
                                          fillColor: Colors.grey[50],
                                        ),
                                        items: [
                                          'All Warehouses',
                                          'Calabar Branch',
                                          'Warehouse 3'
                                        ].map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    border: Border(
                                      top: BorderSide(color: Colors.grey[200]!),
                                      bottom:
                                          BorderSide(color: Colors.grey[200]!),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      SizedBox(width: 2),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Image',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Code',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Expiry Date',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Brand',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Branch',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Product Unit',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'In Stock',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Created On',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Gap(20),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Actions',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                provider.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : provider.products.isEmpty
                                        ? const Center(
                                            child: Text('No products found'))
                                        : SizedBox(
                                            height: 10 * 70.0,
                                            child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: provider
                                                      .products.length >
                                                  10
                                                  ? 10
                                                  : provider.products.length,
                                              itemBuilder: (context, index) {
                                                final product =
                                                    provider.products[index];
                                                return ListTile(
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Checkbox(
                                                          value: false,
                                                          onChanged: (value) {},
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                  product
                                                                          .imageUrl ??
                                                                      ''),
                                                              fit: BoxFit.cover,
                                                              onError: (exception,
                                                                      stackTrace) =>
                                                                  const Icon(
                                                                      Icons
                                                                          .error),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            product.name ?? ''),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            product.code ?? ''),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            product.expiryDate ??
                                                                'N/A'),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            product.brand ?? ''),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            product.branch ?? ''),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            '${product.price ?? 0} NGN'),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            product.productUnit
                                                                    ?.toString() ??
                                                                ''),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            '${product.inStock ?? 0}'),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            product.createdOn ??
                                                                ''),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons
                                                                      .visibility),
                                                              onPressed: () {},
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.edit),
                                                              onPressed: () {},
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.delete),
                                                              onPressed: () {},
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: provider.currentPage > 1
                                          ? () {
                                              provider.setCurrentPage(
                                                  provider.currentPage - 1);
                                              provider.fetchProducts();
                                            }
                                          : null,
                                      icon: const Icon(Icons.chevron_left),
                                    ),
                                    IconButton(
                                      onPressed: provider.currentPage <
                                              provider.totalPages
                                          ? () {
                                              provider.setCurrentPage(
                                                  provider.currentPage + 1);
                                              provider.fetchProducts();
                                            }
                                          : null,
                                      icon: const Icon(Icons.chevron_right),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/widgets/sidebar_pos.dart';

// import '../../providers/products_provider.dart';
// import 'create_products_screen.dart';
// // import 'package:spotstock_inventory/screens/desktop/products/create_product_screen.dart';
// // import 'package:spotstock_inventory/common/provider/products_provider.dart';

// class ProductsDesktopScreen extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final Size mediaQuery;

//   const ProductsDesktopScreen({
//     Key? key,
//     required this.user,
//     required this.systemProvider,
//     required this.mediaQuery,
//   }) : super(key: key);

//   @override
//   State<ProductsDesktopScreen> createState() => _ProductsDesktopScreenState();
// }

// class _ProductsDesktopScreenState extends State<ProductsDesktopScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _isSearchFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductsProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: Colors.grey[100],
//           body: LayoutBuilder(builder: (context, constraint) {
//             return ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: constraint.maxHeight,
//                 maxWidth: widget.mediaQuery.width * 0.98,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxHeight: widget.mediaQuery.height * 0.98,
//                     ),
//                     child: SizedBox(
//                       width: 220,
//                       child: SideBarPos(
//                         vertical: 20,
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                         activeItem: ValueNotifier<String>("Products"),
//                         mediaQuery: widget.mediaQuery,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Products',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22,
//                                       color: Colors.black87),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16),
//                                     child: Focus(
//                                       onFocusChange: (hasFocus) {
//                                         setState(() {
//                                           _isSearchFocused = hasFocus;
//                                         });
//                                       },
//                                       child: AnimatedContainer(
//                                         duration:
//                                             const Duration(milliseconds: 200),
//                                         width: _isSearchFocused ? 300 : 200,
//                                         child: TextField(
//                                           controller: _searchController,
//                                           decoration: InputDecoration(
//                                             hintText: 'Search product...',
//                                             prefixIcon: const Icon(
//                                                 Icons.search,
//                                                 size: 20),
//                                             border: const UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey,
//                                                   width: 0.5),
//                                             ),
//                                             enabledBorder:
//                                                 const UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey,
//                                                   width: 0.5),
//                                             ),
//                                             focusedBorder:
//                                                 const UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey,
//                                                   width: 0.5),
//                                             ),
//                                             contentPadding:
//                                                 const EdgeInsets.symmetric(
//                                                     vertical: 12,
//                                                     horizontal: 12),
//                                             filled: true,
//                                             fillColor: Colors.grey[50],
//                                           ),
//                                           onChanged: (value) =>
//                                               provider.setSearchQuery(value),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () =>
//                                           provider.fetchProducts(refresh: true),
//                                       icon: const Icon(Icons.refresh, size: 20),
//                                       tooltip: 'Refresh Data',
//                                     ),
//                                     ElevatedButton(
//                                       onPressed: () async {
//                                         if (provider.isLoading) return;
//                                         final result = await Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CreateProductScreen(
//                                               systemProvider:
//                                                   widget.systemProvider,
//                                             ),
//                                           ),
//                                         );
//                                         if (result == true) {
//                                           provider.fetchProducts();
//                                         }
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: const Color(0xFF6B46C1),
//                                         foregroundColor: Colors.white,
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 12),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                       child: const Text('Create Product',
//                                           style: TextStyle(fontSize: 14)),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (provider.error != null)
//                             Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Text(
//                                 provider.error!,
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           Container(
//                             width: double.infinity,
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.15),
//                                   spreadRadius: 2,
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Filters',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Wrap(
//                                   spacing: 12,
//                                   runSpacing: 12,
//                                   children: [
//                                     SizedBox(
//                                       width: 200,
//                                       child: DropdownButtonFormField<String>(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                                   horizontal: 12, vertical: 12),
//                                           filled: true,
//                                           fillColor: Colors.grey[50],
//                                         ),
//                                         items: [
//                                           'All Products',
//                                           'In Stock',
//                                           'Out of Stock'
//                                         ].map((item) {
//                                           return DropdownMenuItem(
//                                             value: item,
//                                             child: Text(item),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {},
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 200,
//                                       child: DropdownButtonFormField<String>(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                                   horizontal: 12, vertical: 12),
//                                           filled: true,
//                                           fillColor: Colors.grey[50],
//                                         ),
//                                         items: [
//                                           'All Brands',
//                                           'NIVEA',
//                                           'LATAFA'
//                                         ].map((item) {
//                                           return DropdownMenuItem(
//                                             value: item,
//                                             child: Text(item),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {},
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 200,
//                                       child: DropdownButtonFormField<String>(
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                                   horizontal: 12, vertical: 12),
//                                           filled: true,
//                                           fillColor: Colors.grey[50],
//                                         ),
//                                         items: [
//                                           'All Warehouses',
//                                           'Calabar Branch',
//                                           'Warehouse 3'
//                                         ].map((item) {
//                                           return DropdownMenuItem(
//                                             value: item,
//                                             child: Text(item),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {},
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.15),
//                                   spreadRadius: 2,
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[50],
//                                     border: Border(
//                                       top: BorderSide(color: Colors.grey[200]!),
//                                       bottom:
//                                           BorderSide(color: Colors.grey[200]!),
//                                     ),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       SizedBox(width: 2),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Image',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Name',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Text(
//                                           'Code',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Text(
//                                           'Expiry Date',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Brand',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Branch',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Price',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Product Unit',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'In Stock',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Created On',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       Gap(20),
//                                       Expanded(
//                                         flex: 2,
//                                         child: Text(
//                                           'Actions',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 provider.isLoading
//                                     ? const Center(
//                                         child: CircularProgressIndicator())
//                                     : provider.products.isEmpty
//                                         ? const Center(
//                                             child: Text('No products found'))
//                                         : SizedBox(
//                                             height: 10 * 70.0,
//                                             child: ListView.builder(
//                                               physics:
//                                                   const NeverScrollableScrollPhysics(),
//                                               itemCount: provider
//                                                       .products.length >
//                                                   10
//                                                   ? 10
//                                                   : provider.products.length,
//                                               itemBuilder: (context, index) {
//                                                 final product =
//                                                     provider.products[index];
//                                                 return ListTile(
//                                                   title: Row(
//                                                     children: [
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Checkbox(
//                                                           value: false,
//                                                           onChanged: (value) {},
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Container(
//                                                           width: 50,
//                                                           height: 50,
//                                                           decoration: BoxDecoration(
//                                                             image: DecorationImage(
//                                                               image: NetworkImage(
//                                                                   product
//                                                                           .imageUrl ??
//                                                                       ''),
//                                                               fit: BoxFit.cover,
//                                                               onError: (exception,
//                                                                       stackTrace) =>
//                                                                   const Icon(
//                                                                       Icons
//                                                                           .error),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             product.name ?? ''),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 1,
//                                                         child: Text(
//                                                             product.code ?? ''),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 1,
//                                                         child: Text(
//                                                             product.expiryDate ??
//                                                                 'N/A'),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             product.brand ?? ''),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             product.branch ?? ''),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             '${product.price ?? 0} NGN'),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             product.productUnit
//                                                                     ?.toString() ??
//                                                                 ''),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             '${product.inStock ?? 0}'),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                             product.createdOn ??
//                                                                 ''),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Row(
//                                                           children: [
//                                                             IconButton(
//                                                               icon: const Icon(
//                                                                   Icons
//                                                                       .visibility),
//                                                               onPressed: () {},
//                                                             ),
//                                                             IconButton(
//                                                               icon: const Icon(
//                                                                   Icons.edit),
//                                                               onPressed: () {},
//                                                             ),
//                                                             IconButton(
//                                                               icon: const Icon(
//                                                                   Icons.delete),
//                                                               onPressed: () {},
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: provider.currentPage > 1
//                                           ? () {
//                                               provider.setCurrentPage(
//                                                   provider.currentPage - 1);
//                                               provider.fetchProducts();
//                                             }
//                                           : null,
//                                       icon: const Icon(Icons.chevron_left),
//                                     ),
//                                     IconButton(
//                                       onPressed: provider.currentPage <
//                                               provider.totalPages
//                                           ? () {
//                                               provider.setCurrentPage(
//                                                   provider.currentPage + 1);
//                                               provider.fetchProducts();
//                                             }
//                                           : null,
//                                       icon: const Icon(Icons.chevron_right),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }