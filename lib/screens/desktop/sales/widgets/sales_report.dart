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
      context.read<SalesProvider>().fetchSales(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: LayoutBuilder(builder: (context, constraint) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraint.maxHeight,
            maxWidth: MediaQuery.of(context).size.width * 0.98,
          ),
          child: Consumer<SalesProvider>(
            builder: (context, provider, child) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.98,
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sales Report',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final localCount =
                                          await provider.getLocalSalesCount();
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Local sales count: $localCount'),
                                            action: SnackBarAction(
                                              label: 'Clear',
                                              onPressed: () async {
                                                await provider.clearLocalData();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Local data cleared')),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.storage),
                                    tooltip: 'Local Storage Info',
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      provider.fetchSales(refresh: true);
                                    },
                                    icon: const Icon(Icons.refresh),
                                    tooltip: 'Refresh Data',
                                  ),
                                  ElevatedButton.icon(
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
                                ],
                              ),
                            ],
                          ),

                          // Filters Section
                          Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Filters',
                                  style: TextStyle(
                                    fontSize: 15,
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
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: _buildDateField(
                                        'End Date',
                                        _endDateController,
                                        (date) => provider.setEndDate(date),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
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
                                const SizedBox(height: 10),
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
                                    const SizedBox(width: 10),
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
                                    const SizedBox(width: 10),
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
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 500,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                    const Spacer(),
                                    const SizedBox(width: 10),
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
                                    const SizedBox(width: 10),
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
                              margin: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 2),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Reference',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Gap(10),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Date',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Gap(10),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Customer',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Attendant',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Warehouse',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Grand Total',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Paid Amount',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Amount Due',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Payment Status',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Gap(15),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Status',
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
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
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
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
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
    // Check if payment status allows payment (unpaid or partially paid)
    bool canMakePayment = sale.paymentStatusText.toLowerCase() == 'unpaid' ||
        sale.paymentStatusText.toLowerCase() == 'partially paid';

    return ExpansionTile(
      childrenPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              sale.referenceCode,
              style: TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                DateFormat('dd MMM yyyy').format(sale.date),
                style: TextStyle(fontSize: 10),
              )),
          Expanded(
              flex: 2,
              child: Text(
                sale.customerName,
                style: TextStyle(fontSize: 10),
              )),
          Expanded(
              flex: 2,
              child: Text(
                'Staff', // You might want to add attendant data to Sale model
                style: TextStyle(fontSize: 10),
              )),
          Expanded(
              flex: 2,
              child: Text(
                sale.warehouseName,
                style: TextStyle(fontSize: 10),
              )),
          Expanded(
            flex: 2,
            child: Text(
              '₦${NumberFormat('#,##0').format(sale.grandTotal)}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                '₦${NumberFormat('#,##0').format(sale.paidAmount)}',
                style: TextStyle(fontSize: 10),
              )),
          Expanded(
              flex: 2,
              child: Text(
                '₦${NumberFormat('#,##0').format(sale.dueAmount)}',
                style: TextStyle(fontSize: 10),
              )),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              decoration: BoxDecoration(
                color: sale.paymentStatusColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                sale.paymentStatusText,
                style: const TextStyle(color: Colors.white, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Gap(10),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              decoration: BoxDecoration(
                color: sale.status == 1 ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                sale.statusText,
                style: const TextStyle(color: Colors.white, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Gap(10),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 15),
                  onPressed: () => _showSalesReceiptDialog(sale),
                  tooltip: 'View Receipt',
                ),
                if (canMakePayment)
                  // TextButton.icon(
                  //   onPressed: () => _showReconcilePaymentDialog(sale),
                  //   icon: const Icon(Icons.payment, size: 13),
                  //   label: const Text('Pay', style: TextStyle(fontSize: 10)),
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: const Color(0xFF6B46C1),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 0, vertical: 4),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () => _showReconcilePaymentDialog(sale),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: ColorsRes.cardbggrey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Icon(Icons.payment, size: 13),
                          Text('Pay', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  )
              ],
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

  void _showSalesReceiptDialog(Sale sale) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 600,
            height: 700,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B46C1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.receipt, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Sales Receipt',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            sale.referenceCode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Date:',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            DateFormat('dd MMMM yyyy').format(sale.date),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Status badges
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // if (sale.paymentStatusText.toLowerCase() == 'paid')
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: sale.paymentStatusColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        sale.paymentStatusText,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        sale.statusText,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Customer and Attendant Info
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Customer Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 15),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sale.customerName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Customer ID: ${sale.customerId ?? "N/A"}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Sold from: ${sale.warehouseName}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Attendant Information',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 15),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Staff', // You can replace with actual attendant name
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              'Attendant ID: N/A',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Sale Items
                const Text(
                  'Sale Items',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),

                // Items table header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text('PRODUCT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10))),
                      Expanded(
                          flex: 2,
                          child: Text('QUANTITY',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10))),
                      Expanded(
                          flex: 2,
                          child: Text('UNIT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10))),
                      Expanded(
                          flex: 2,
                          child: Text('UNIT PRICE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10))),
                      Expanded(
                          flex: 2,
                          child: Text('SUBTOTAL',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10))),
                    ],
                  ),
                ),

                // Items list
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: sale.saleItems.length,
                    itemBuilder: (context, index) {
                      final item = sale.saleItems[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]!)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Product ${item.productId}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                  Text('${item.productId}',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Expanded(flex: 2, child: Text('${item.quantity}')),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'btl',
                                  style: TextStyle(fontSize: 12),
                                )), // You can get unit from item if available
                            Expanded(
                                flex: 2,
                                child: Text(
                                  '₦${NumberFormat('#,##0').format(item.productPrice)}',
                                  style: TextStyle(fontSize: 12),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  '₦${NumberFormat('#,##0').format(item.subTotal)}',
                                  style: TextStyle(fontSize: 12),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Grand Total
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Grand Total:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '₦${NumberFormat('#,##0').format(sale.grandTotal)}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Payment Summary
                const Text(
                  'Payment Summary',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text('Grand Total',
                                style: TextStyle(color: Colors.grey)),
                            Text(
                              '₦${NumberFormat('#,##0').format(sale.grandTotal)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text('Paid Amount',
                                style: TextStyle(color: Colors.grey)),
                            Text(
                              '₦${NumberFormat('#,##0').format(sale.paidAmount)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text('Balance Due',
                                style: TextStyle(color: Colors.grey)),
                            Text(
                              '₦${NumberFormat('#,##0').format(sale.dueAmount)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Footer
                Center(
                  child: Row(
                    children: [
                      Text(
                        'Thank you for your business! For any questions, please contact our support team.',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Gap(10),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Exit',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReconcilePaymentDialog(Sale sale) {
    final TextEditingController paymentAmountController =
        TextEditingController();
    String selectedPaymentType = 'Cash';
    bool isProcessing = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reconcile Payment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Sale Details
                    _buildInfoRow('Reference:', sale.referenceCode),
                    _buildInfoRow('Total Amount:',
                        '₦${NumberFormat('#,##0').format(sale.grandTotal)}'),
                    _buildInfoRow('Paid So Far:',
                        '₦${NumberFormat('#,##0').format(sale.paidAmount)}'),
                    _buildInfoRow('Balance:',
                        '₦${NumberFormat('#,##0').format(sale.dueAmount)}'),

                    // Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Status:',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: sale.paymentStatusColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            sale.paymentStatusText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Payment Amount Input
                    const Text(
                      'Payment Amount',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorsRes.btndarkshadow,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: paymentAmountController,
                        decoration: const InputDecoration(
                          hintText: 'Enter amount',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Payment Type
                    const Text(
                      'Payment Type',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorsRes.btndarkshadow,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedPaymentType,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'Cash',
                          'Cheque',
                          'Bank Transfer',
                          'POS',
                          'Other'
                        ].map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentType = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: isProcessing
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: isProcessing
                              ? null
                              : () => _submitPayment(
                                    sale.id.toString(),
                                    paymentAmountController.text,
                                    selectedPaymentType,
                                    setState,
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6B46C1),
                            foregroundColor: Colors.white,
                          ),
                          child: isProcessing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text('Submit Payment'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _submitPayment(String salesId, String amount, String paymentType,
      StateSetter setState) async {
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter payment amount')),
      );
      return;
    }

    double? paymentAmount = double.tryParse(amount);
    if (paymentAmount == null || paymentAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    setState(() {
      // Set processing state for the dialog
    });

    try {
      // Call your API here - replace with your actual API service
      final response =
          await _reconcilePayment(salesId, paymentAmount, paymentType);

      if (response['success'] == true) {
        Navigator.of(context).pop(); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment recorded successfully')),
        );

        // Refresh the sales data
        context.read<SalesProvider>().fetchSales(refresh: true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Error: ${response['message'] ?? 'Unknown error'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        // Reset processing state
      });
    }
  }

  // Mock API call - replace with your actual API service
  Future<Map<String, dynamic>> _reconcilePayment(
      String salesId, double amount, String paymentType) async {
    // Example API call
    // final response = await http.post(
    //   Uri.parse('${baseUrl}/sales/$salesId/reconcile-payment'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: json.encode({
    //     'amount': amount,
    //     'payment_type': paymentType,
    //   }),
    // );
    // return json.decode(response.body);

    // Mock response
    await Future.delayed(const Duration(seconds: 1));
    return {'success': true, 'message': 'Payment recorded successfully'};
  }
}
