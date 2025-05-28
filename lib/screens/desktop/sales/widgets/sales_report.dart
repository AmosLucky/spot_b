// screens/sales_report_screen.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/sales_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/sales_models.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';

class DesktopSalesReportScreen extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  const DesktopSalesReportScreen({
    Key? key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  }) : super(key: key);

  @override
  State<DesktopSalesReportScreen> createState() =>
      _DesktopSalesReportScreenState();
}

class _DesktopSalesReportScreenState extends State<DesktopSalesReportScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SalesProvider>().fetchSales();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   title: const Text('Sales Report'),
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   actions: [],
      // ),
      body: LayoutBuilder(builder: (context, constrint) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constrint.maxHeight,
            maxWidth: MediaQuery.of(context).size.width * 0.98,
          ),
          child: Consumer<SalesProvider>(
            builder: (context, provider, child) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.90,
                      ),
                      child: SizedBox(
                        width: 250,
                        child: SideBarPos(
                          vertical: 20,
                          user: widget.user,
                          systemProvider: widget.systemProvider,
                          mediaQuery: MediaQuery.of(context).size,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sales Report',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Implement Excel export
                                  },
                                  icon: const Icon(Icons.file_download),
                                  label: const Text('Download'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6B46C1),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Filters Section
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDateField(
                                        'Start Date',
                                        _startDateController,
                                        (date) => provider.setStartDate(date),
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: _buildDateField(
                                        'End Date',
                                        _endDateController,
                                        (date) => provider.setEndDate(date),
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: _buildDropdown(
                                        'Type',
                                        provider.selectedType,
                                        ['All Types', 'sales', 'returns'],
                                        (value) => provider.setType(
                                            value == 'All Types'
                                                ? null
                                                : value),
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdown(
                                        'Warehouse',
                                        provider.selectedWarehouse,
                                        [
                                          'All Warehouses',
                                          'Calabar Branch',
                                          'Main Branch'
                                        ],
                                        (value) => provider.setWarehouse(
                                            value == 'All Warehouses'
                                                ? null
                                                : value),
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: _buildDropdown(
                                        'Customer',
                                        provider.selectedCustomer,
                                        [
                                          'All Customers',
                                          'Emmanuel',
                                          'Amaka',
                                          'chinny',
                                          'walk-in-customer'
                                        ],
                                        (value) => provider.setCustomer(
                                            value == 'All Customers'
                                                ? null
                                                : value),
                                      ),
                                    ),
                                    Gap(10),
                                    Expanded(
                                      child: _buildDropdown(
                                        'Attendant',
                                        provider.selectedAttendant,
                                        [
                                          'All Attendants',
                                          'Jennifer',
                                          'Mbachukwu'
                                        ],
                                        (value) => provider.setAttendant(
                                            value == 'All Attendants'
                                                ? null
                                                : value),
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        controller: _searchController,
                                        decoration: const InputDecoration(
                                          labelText: 'Search',
                                          hintText:
                                              'Search by reference code...',
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                        onChanged: (value) =>
                                            provider.setSearchQuery(
                                                value.isEmpty ? null : value),
                                      ),
                                    ),
                                    Gap(10),
                                    ElevatedButton(
                                      onPressed: provider.resetFilters,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                        foregroundColor: Colors.black87,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                      ),
                                      child: const Text('Reset Filters'),
                                    ),
                                    Gap(10),
                                    ElevatedButton(
                                      onPressed: provider.applyFilters,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF6B46C1),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                      ),
                                      child: const Text('Apply Filters'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Sales Table
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sales',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          provider.meta != null
                                              ? 'Showing ${provider.meta!.from} to ${provider.meta!.to} of ${provider.meta!.total} sales'
                                              : 'Loading...',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Table Header
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey[200]!),
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!),
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        SizedBox(
                                            width: 40), // Expand button space
                                        Expanded(
                                            flex: 2,
                                            child: Text('Reference',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Date',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Customer',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Attendant',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Warehouse',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Grand Total',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Paid Amount',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Amount Due',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Payment Status',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 2,
                                            child: Text('Status',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Expanded(
                                            flex: 1,
                                            child: Text('Actions',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ],
                                    ),
                                  ),

                                  // Table Content
                                  Expanded(
                                    child: provider.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : provider.error != null
                                            ? Center(
                                                child: Text(
                                                    'Error: ${provider.error}'))
                                            : ListView.builder(
                                                itemCount:
                                                    provider.sales.length,
                                                itemBuilder: (context, index) {
                                                  final sale =
                                                      provider.sales[index];
                                                  return _buildSaleRow(sale);
                                                },
                                              ),
                                  ),

                                  // Pagination
                                  if (provider.meta != null)
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.grey[200]!),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Page ${provider.meta!.currentPage} of ${provider.meta!.lastPage}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed:
                                                    provider.currentPage > 1
                                                        ? () {
                                                            provider.setCurrentPage(
                                                                provider.currentPage -
                                                                    1);
                                                            provider
                                                                .fetchSales();
                                                          }
                                                        : null,
                                                icon: const Icon(
                                                    Icons.chevron_left),
                                              ),
                                              IconButton(
                                                onPressed: provider
                                                            .currentPage <
                                                        provider.meta!.lastPage
                                                    ? () {
                                                        provider.setCurrentPage(
                                                            provider.currentPage +
                                                                1);
                                                        provider.fetchSales();
                                                      }
                                                    : null,
                                                icon: const Icon(
                                                    Icons.chevron_right),
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
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorsRes.btndarkshadow)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'dd/mm/yyyy',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
                    controller.text = formattedDate;
                    onChanged(DateFormat('yyyy-MM-dd').format(date));
                  }
                },
              ),
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorsRes.btndarkshadow)),
          child: DropdownButtonFormField<String>(
            value: value ?? items.first,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSaleRow(Sale sale) {
    return ExpansionTile(
      leading: const Icon(Icons.expand_more),
      title: Row(
        children: [
          Expanded(flex: 2, child: Text(sale.referenceCode)),
          Expanded(
              flex: 2,
              child: Text(DateFormat('dd MMM yyyy').format(sale.date))),
          Expanded(flex: 2, child: Text(sale.customerName)),
          Expanded(flex: 2, child: Text('Staff')), // Attendant not in data
          Expanded(flex: 2, child: Text(sale.warehouseName)),
          Expanded(
              flex: 2,
              child: Text('₦${NumberFormat('#,##0').format(sale.grandTotal)}')),
          Expanded(
              flex: 2,
              child: Text('₦${NumberFormat('#,##0').format(sale.paidAmount)}')),
          Expanded(
              flex: 2,
              child: Text('₦${NumberFormat('#,##0').format(sale.dueAmount)}')),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: sale.paymentStatus == 1 ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                sale.paymentStatusText,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: sale.status == 1 ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                sale.statusText,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                // Implement view action
              },
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sale Items:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...sale.saleItems.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Product ID: ${item.productId}'),
                        Text('Qty: ${item.quantity}'),
                        Text(
                            'Price: ₦${NumberFormat('#,##0').format(item.productPrice)}'),
                        Text(
                            'Subtotal: ₦${NumberFormat('#,##0').format(item.subTotal)}'),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
