import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
import '../../model/warehouse_product_model.dart';
import '../../providers/warehouse_products_provider.dart';
import '../widgets/analytics_card.dart';
import '../widgets/inventory_card.dart';
// import '../providers/warehouse_products_provider.dart';
// import '../widgets/inventory_chart.dart';
// import '../models/product.dart';

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
  State<ProductsDesktopScreen> createState() => _ProductsDesktopScreenRefactoredState();
}

class _ProductsDesktopScreenRefactoredState extends State<ProductsDesktopScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WarehouseProductsProvider>(context, listen: false)
          .fetchProducts(warehouseId: widget.systemProvider.warehouseIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WarehouseProductsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: LayoutBuilder(
            builder: (context, constraint) {
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
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(provider),
                            const SizedBox(height: 24),
                            if (provider.analytics != null) ...[
                              _buildAnalyticsSection(provider.analytics!),
                              const SizedBox(height: 24),
                            ],
                            _buildChartsSection(provider),
                            const SizedBox(height: 24),
                            _buildFiltersSection(provider),
                            const SizedBox(height: 24),
                            _buildProductsTable(provider),
                            const SizedBox(height: 24),
                            _buildPagination(provider),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHeader(WarehouseProductsProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products Dashboard',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage and monitor your warehouse inventory',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildSearchField(provider),
            const SizedBox(width: 16),
            _buildRefreshButton(provider),
            const SizedBox(width: 16),
            _buildCreateButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField(WarehouseProductsProvider provider) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isSearchFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _isSearchFocused ? 350 : 250,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products, codes, brands...',
            prefixIcon: const Icon(Icons.search, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6B46C1), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (value) => provider.setSearchQuery(value),
        ),
      ),
    );
  }

  Widget _buildRefreshButton(WarehouseProductsProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: IconButton(
        onPressed: () => provider.fetchProducts(
          warehouseId: widget.systemProvider.warehouseIds,
          refresh: true,
        ),
        icon: provider.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.refresh, size: 20),
        tooltip: 'Refresh Data',
      ),
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigate to create product screen
      },
      icon: const Icon(Icons.add, size: 20),
      label: const Text('Add Product'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6B46C1),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildAnalyticsSection(ProductAnalytics analytics) {
    return Row(
      children: [
        Expanded(
          child: AnalyticsCard(
            title: 'Total Products',
            value: '${analytics.inStock + analytics.outOfStock}',
            subtitle: 'Active inventory items',
            icon: Icons.inventory_2,
            color: const Color(0xFF6B46C1),
            backgroundColor: const Color(0xFF6B46C1).withOpacity(0.1),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AnalyticsCard(
            title: 'In Stock',
            value: '${analytics.inStock}',
            subtitle: 'Available products',
            icon: Icons.check_circle,
            color: Colors.green,
            backgroundColor: Colors.green.withOpacity(0.1),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AnalyticsCard(
            title: 'Out of Stock',
            value: '${analytics.outOfStock}',
            subtitle: 'Need restocking',
            icon: Icons.warning,
            color: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.1),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AnalyticsCard(
            title: 'Total Value',
            value: '₦${NumberFormat('#,##0.00').format(analytics.totalStockValue)}',
            subtitle: 'Inventory worth',
            icon: Icons.attach_money,
            color: Colors.blue,
            backgroundColor: Colors.blue.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildChartsSection(WarehouseProductsProvider provider) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InventoryChart(products: provider.products),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTopBrandsCard(provider),
        ),
      ],
    );
  }

  Widget _buildTopBrandsCard(WarehouseProductsProvider provider) {
    final brandCounts = <String, int>{};
    for (final product in provider.products) {
      brandCounts[product.brandName] = (brandCounts[product.brandName] ?? 0) + 1;
    }
    
    final sortedBrands = brandCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Brands',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ...sortedBrands.take(5).map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B46C1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${entry.value}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B46C1),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(WarehouseProductsProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildFilterDropdown(
                'Stock Status',
                provider.stockFilter,
                ['All Products', 'In Stock', 'Out of Stock'],
                provider.setStockFilter,
              ),
              _buildFilterDropdown(
                'Warehouse',
                provider.selectedWarehouse,
                provider.warehouses,
                provider.setWarehouseFilter,
              ),
              _buildFilterDropdown(
                'Category',
                provider.selectedCategory,
                provider.categories,
                provider.setCategoryFilter,
              ),
              _buildFilterDropdown(
                'Brand',
                provider.selectedBrand,
                provider.brands,
                provider.setBrandFilter,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (newValue) => onChanged(newValue!),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTable(WarehouseProductsProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${provider.products.length} products found',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          _buildTableHeader(),
          if (provider.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            )
          else if (provider.error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  provider.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            )
          else if (provider.products.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Text('No products found'),
              ),
            )
          else
            ...provider.paginatedProducts.map((product) => _buildProductRow(product)),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: const Row(
        children: [
          Expanded(flex: 3, child: Text('Product', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Code', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Brand', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Category', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Price', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Stock', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Warehouse', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 2, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildProductRow(WarehouseProductModel product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: product.barcodeUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.barcodeUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.inventory_2, size: 20),
                          ),
                        )
                      : const Icon(Icons.inventory_2, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.productUnitName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              product.code,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              product.brandName,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              product.productCategoryName,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '₦${NumberFormat('#,##0.00').format(product.productPrice)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: product.inStock > 0
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${product.inStock}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: product.inStock > 0 ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              product.warehouses.isNotEmpty ? product.warehouses.first.name : 'N/A',
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  onPressed: () {
                    // View product details
                  },
                  tooltip: 'View Details',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () {
                    // Edit product
                  },
                  tooltip: 'Edit Product',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                  onPressed: () {
                    // Delete product
                  },
                  tooltip: 'Delete Product',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(WarehouseProductsProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing ${((provider.currentPage - 1) * 10) + 1} to ${provider.currentPage * 10 > provider.products.length ? provider.products.length : provider.currentPage * 10} of ${provider.products.length} products',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: provider.currentPage > 1
                  ? () => provider.setCurrentPage(provider.currentPage - 1)
                  : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF6B46C1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${provider.currentPage}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: provider.currentPage < provider.totalPages
                  ? () => provider.setCurrentPage(provider.currentPage + 1)
                  : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/widgets/sidebar_pos.dart';

// import '../../providers/products_provider.dart';
// import 'create_products_screen.dart';


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
//                                         showModalBottomSheet(
//                                           context: context,
//                                           isScrollControlled: true,
//                                           backgroundColor: Colors.transparent,
//                                           builder: (context) => CreateProductScreen(
//                                             systemProvider: widget.systemProvider,
//                                           ),
//                                         ).then((result) {
//                                           if (result == true) {
//                                             provider.fetchProducts();
//                                           }
//                                         });
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