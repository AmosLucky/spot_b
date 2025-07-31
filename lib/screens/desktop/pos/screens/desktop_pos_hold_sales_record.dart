import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/model/select_attendant_model.dart';
import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/select_attendantdialog.dart';
import 'package:spotstock_inventory/screens/desktop/pos/dialogs/select_attendant_pin.dart';
import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_provider.dart';
import '../../../../data/models/hold_model.dart';

class DesktopPosHoldSalesRecord extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  final ValueNotifier<String> activeItem;

  const DesktopPosHoldSalesRecord({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
    required this.activeItem,
  });

  @override
  State<DesktopPosHoldSalesRecord> createState() => _DesktopPosHoldSalesRecordState();
}

class _DesktopPosHoldSalesRecordState extends State<DesktopPosHoldSalesRecord> {
  final TextEditingController _searchController = TextEditingController();
  List<HoldRecord> _holdRecords = [];
  List<HoldRecord> _filteredHoldRecords = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  HoldRecord? _selectedHoldForDelete;
  HoldRecord? _selectedHoldForPrint;
  bool _showDeleteDialog = false;
  bool _showPrintDialog = false;

  @override
  void initState() {
    super.initState();
    _loadHoldRecords();
    _searchController.addListener(_filterHoldRecords);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHoldRecords() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final holds = await widget.systemProvider.getHoldRecords();
      setState(() {
        _holdRecords = holds;
        _filteredHoldRecords = holds;
        _isLoading = false;
      });
    } catch (e) {
      log('Error loading hold records: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading hold records: $e')),
      );
    }
  }

  void _filterHoldRecords() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredHoldRecords = _holdRecords;
      } else {
        _filteredHoldRecords = _holdRecords.where((hold) {
          return hold.referenceCode.toLowerCase().contains(query) ||
              hold.customerName.toLowerCase().contains(query) ||
              hold.warehouseName.toLowerCase().contains(query);
        }).toList();
      }
      _currentPage = 1;
    });
  }

  List<HoldRecord> _getPaginatedHolds() {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return _filteredHoldRecords.sublist(
      startIndex,
      endIndex > _filteredHoldRecords.length ? _filteredHoldRecords.length : endIndex,
    );
  }

  int get _totalPages => (_filteredHoldRecords.length / _itemsPerPage).ceil();

  void _retrieveHold(HoldRecord hold) {
    Navigator.pop(context, hold);
  }

  void _showDeleteConfirmation(HoldRecord hold) {
    setState(() {
      _selectedHoldForDelete = hold;
      _showDeleteDialog = true;
    });
  }

  void _showPrintPreview(HoldRecord hold) {
    setState(() {
      _selectedHoldForPrint = hold;
      _showPrintDialog = true;
    });
  }

  Future<void> _deleteHold(HoldRecord hold) async {
    try {
      await widget.systemProvider.deleteHoldRecord(hold.id);
      setState(() {
        _holdRecords.removeWhere((h) => h.id == hold.id);
        _filteredHoldRecords.removeWhere((h) => h.id == hold.id);
        _showDeleteDialog = false;
        _selectedHoldForDelete = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hold record deleted successfully')),
      );
    } catch (e) {
      log('Error deleting hold record: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting hold record: $e')),
      );
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy HH:mm').format(date);
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(symbol: '₦', decimalDigits: 2).format(amount);
  }

  void _selectAttendant(BuildContext context, Function(SelectAttendantModel) onAttendantSelected) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: Provider.of<SelectAttendantProvider>(context, listen: false),
        child: SelectAttendantDialog(
          onAttendantSelected: (attendant) {
            Navigator.of(context).pop();
            _promptForPin(context, attendant, onAttendantSelected);
          },
        ),
      ),
    );
  }

  void _promptForPin(BuildContext context, SelectAttendantModel attendant, Function(SelectAttendantModel) onAttendantSelected) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SelectAttendantPinDialog(
        attendant: attendant,
        onPinVerified: (verified) {
          Navigator.of(context).pop(); // Close PIN dialog
          if (verified) {
            onAttendantSelected(attendant);
          }
        },
      ),
    );
  }

  Future<void> _printHoldReceipt(HoldRecord hold, String attendantName) async {
    try {
      List<Item> items = hold.holdItems.map((item) => Item(
        item.productName,
        item.quantity,
        item.netUnitPrice,
      )).toList();

      await printSampleDocument(
        hold.grandTotal,
        items,
        [],
        '',
        '',
        widget.user.company?.email ?? 'N/A',
        widget.user.company?.phone ?? 'N/A',
        widget.user.firstName ?? 'N/A',
        'N/A', // customerPhoneNumber
        hold.warehouseName,
        'On Hold',
        'N/A', // tableId
        hold.customerName,
        hold.referenceCode,
        hold.grandTotal,
        0.0, // receivedAmount
        0.0, // change
        'N/A', // paymentMethod
        hold.createdAt,
        widget.user.company?.name ?? 'N/A',
        widget.user.company?.address ?? 'N/A',
        attendantName,
      );
      setState(() {
        _showPrintDialog = false; // Close print preview dialog
        _selectedHoldForPrint = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt printed successfully!')),
      );
    } catch (e) {
      log('Error printing hold receipt: $e');
      setState(() {
        _showPrintDialog = false; // Close print preview dialog on error
        _selectedHoldForPrint = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to print receipt: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: widget.mediaQuery.height,
            ),
            child: SideBarPos(
              vertical: 10,
              horizontal: 5,
              user: widget.user,
              mediaQuery: widget.mediaQuery,
              systemProvider: widget.systemProvider,
              activeItem: widget.activeItem,
              openInvoice: () {},
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => widget.activeItem.value = "Dashboard",
                                icon: const Icon(Icons.arrow_back),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey[100],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hold List Records',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo[700],
                                    ),
                                  ),
                                  Text(
                                    'Manage and retrieve your held sales transactions',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.indigo[200]!),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.inventory, size: 16, color: Colors.indigo[700]),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${_filteredHoldRecords.length} Total Holds',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.indigo[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search by reference code, customer name, or warehouse...',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.indigo[400]!),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: _loadHoldRecords,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Refresh'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[100],
                                  foregroundColor: Colors.grey[700],
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _isLoading
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text('Loading hold records...'),
                                ],
                              ),
                            )
                          : _filteredHoldRecords.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.inventory_2_outlined,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No hold records found',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _searchController.text.isEmpty
                                            ? 'Any sales you hold will appear here'
                                            : 'No results matching "${_searchController.text}"',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Reference',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Date & Time',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Customer',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Warehouse',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Center(
                                                      child: Text(
                                                        'Items',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey[700],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Amount',
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Center(
                                                      child: Text(
                                                        'Actions',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey[700],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: _getPaginatedHolds().length,
                                                itemBuilder: (context, index) {
                                                  final hold = _getPaginatedHolds()[index];
                                                  return Container(
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Colors.grey[200]!,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                hold.referenceCode,
                                                                style: TextStyle(
                                                                  fontSize: 12.sp,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Colors.indigo[600],
                                                                ),
                                                              ),
                                                              Text(
                                                                'ID: ${hold.id}',
                                                                style: TextStyle(
                                                                  fontSize: 10.sp,
                                                                  color: Colors.grey[500],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            _formatDate(hold.createdAt),
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors.grey[700],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            hold.customerName,
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.grey[800],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            hold.warehouseName,
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors.grey[600],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                                vertical: 4,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: Colors.indigo[100],
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                              child: Text(
                                                                '${hold.holdItems.length}',
                                                                style: TextStyle(
                                                                  fontSize: 11.sp,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Colors.indigo[800],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            _formatCurrency(hold.grandTotal),
                                                            textAlign: TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.grey[900],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () => _retrieveHold(hold),
                                                                icon: const Icon(Icons.download),
                                                                style: IconButton.styleFrom(
                                                                  backgroundColor: Colors.green[50],
                                                                  foregroundColor: Colors.green[700],
                                                                  minimumSize: const Size(32, 32),
                                                                ),
                                                                tooltip: 'Retrieve',
                                                              ),
                                                              const SizedBox(width: 4),
                                                              IconButton(
                                                                onPressed: () => _showPrintPreview(hold),
                                                                icon: const Icon(Icons.print),
                                                                style: IconButton.styleFrom(
                                                                  backgroundColor: Colors.blue[50],
                                                                  foregroundColor: Colors.blue[700],
                                                                  minimumSize: const Size(32, 32),
                                                                ),
                                                                tooltip: 'Print',
                                                              ),
                                                              const SizedBox(width: 4),
                                                              IconButton(
                                                                onPressed: () => _showDeleteConfirmation(hold),
                                                                icon: const Icon(Icons.delete),
                                                                style: IconButton.styleFrom(
                                                                  backgroundColor: Colors.red[50],
                                                                  foregroundColor: Colors.red[700],
                                                                  minimumSize: const Size(32, 32),
                                                                ),
                                                                tooltip: 'Delete',
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
                                    ),
                                    if (_totalPages > 1)
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Showing ${(_currentPage - 1) * _itemsPerPage + 1} to ${(_currentPage * _itemsPerPage > _filteredHoldRecords.length) ? _filteredHoldRecords.length : _currentPage * _itemsPerPage} of ${_filteredHoldRecords.length} holds',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: _currentPage > 1
                                                      ? () => setState(() => _currentPage--)
                                                      : null,
                                                  icon: const Icon(Icons.chevron_left),
                                                ),
                                                Text(
                                                  'Page $_currentPage of $_totalPages',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: _currentPage < _totalPages
                                                      ? () => setState(() => _currentPage++)
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
                  ],
                ),
                if (_showDeleteDialog && _selectedHoldForDelete != null)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 400,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red[600]),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Confirm Delete',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Are you sure you want to delete this held sale? This action cannot be undone.',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red[200]!),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.warning, color: Colors.red[700], size: 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'All items in this held sale will be permanently removed.',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.red[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showDeleteDialog = false;
                                        _selectedHoldForDelete = null;
                                      });
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () => _deleteHold(_selectedHoldForDelete!),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[600],
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Delete Hold'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_showPrintDialog && _selectedHoldForPrint != null)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 600,
                          height: 700,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.print, color: Colors.blue[600]),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Print Hold Details',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPrintDialog = false;
                                        _selectedHoldForPrint = null;
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: _buildPrintContent(_selectedHoldForPrint!),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPrintDialog = false;
                                        _selectedHoldForPrint = null;
                                      });
                                    },
                                    child: const Text('Close'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _selectAttendant(context, (attendant) {
                                        _printHoldReceipt(_selectedHoldForPrint!, attendant.fullName);
                                      });
                                    },
                                    icon: const Icon(Icons.print),
                                    label: const Text('Print'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[600],
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrintContent(HoldRecord hold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                'Your Store Name',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Held Sale Details',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Reference:', hold.referenceCode),
                  _buildDetailRow('Date:', _formatDate(hold.createdAt)),
                  _buildDetailRow('Customer:', hold.customerName),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Warehouse:', hold.warehouseName),
                  _buildDetailRow('Items Count:', '${hold.holdItems.length}'),
                  _buildDetailRow('Status:', 'On Hold'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
                    Expanded(flex: 1, child: Text('Qty', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
                    Expanded(flex: 2, child: Text('Price', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
                    Expanded(flex: 2, child: Text('Total', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
                  ],
                ),
              ),
              ...hold.holdItems.map((item) => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(item.productName, style: TextStyle(fontSize: 11.sp))),
                    Expanded(flex: 1, child: Text('${item.quantity}', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.sp))),
                    Expanded(flex: 2, child: Text(_formatCurrency(item.netUnitPrice), textAlign: TextAlign.right, style: TextStyle(fontSize: 11.sp))),
                    Expanded(flex: 2, child: Text(_formatCurrency(item.subTotal), textAlign: TextAlign.right, style: TextStyle(fontSize: 11.sp))),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Grand Total: ${_formatCurrency(hold.grandTotal)}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// // import 'package:spotstock_inventory/data/models/hold_models.dart';
// import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
// import 'package:spotstock_inventory/widgets/dialogs.dart';
// import 'package:intl/intl.dart';

// import '../../../../data/models/hold_model.dart';

// class DesktopPosHoldSalesRecord extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final Size mediaQuery;
//   final ValueNotifier<String> activeItem;

//   const DesktopPosHoldSalesRecord({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     required this.mediaQuery,
//     required this.activeItem,
//   });

//   @override
//   State<DesktopPosHoldSalesRecord> createState() => _DesktopPosHoldSalesRecordState();
// }

// class _DesktopPosHoldSalesRecordState extends State<DesktopPosHoldSalesRecord> {
//   final TextEditingController _searchController = TextEditingController();
//   List<HoldRecord> _holdRecords = [];
//   List<HoldRecord> _filteredHoldRecords = [];
//   bool _isLoading = false;
//   int _currentPage = 1;
//   final int _itemsPerPage = 10;
//   HoldRecord? _selectedHoldForDelete;
//   HoldRecord? _selectedHoldForPrint;
//   bool _showDeleteDialog = false;
//   bool _showPrintDialog = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadHoldRecords();
//     _searchController.addListener(_filterHoldRecords);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadHoldRecords() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final holds = await widget.systemProvider.getHoldRecords();
//       setState(() {
//         _holdRecords = holds;
//         _filteredHoldRecords = holds;
//         _isLoading = false;
//       });
//     } catch (e) {
//       log('Error loading hold records: $e');
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading hold records: $e')),
//       );
//     }
//   }

//   void _filterHoldRecords() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       if (query.isEmpty) {
//         _filteredHoldRecords = _holdRecords;
//       } else {
//         _filteredHoldRecords = _holdRecords.where((hold) {
//           return hold.referenceCode.toLowerCase().contains(query) ||
//               hold.customerName.toLowerCase().contains(query) ||
//               hold.warehouseName.toLowerCase().contains(query);
//         }).toList();
//       }
//       _currentPage = 1;
//     });
//   }

//   List<HoldRecord> _getPaginatedHolds() {
//     final startIndex = (_currentPage - 1) * _itemsPerPage;
//     final endIndex = startIndex + _itemsPerPage;
//     return _filteredHoldRecords.sublist(
//       startIndex,
//       endIndex > _filteredHoldRecords.length ? _filteredHoldRecords.length : endIndex,
//     );
//   }

//   int get _totalPages => (_filteredHoldRecords.length / _itemsPerPage).ceil();

//   void _retrieveHold(HoldRecord hold) {
//     // Navigate back to POS with hold data
//     Navigator.pop(context, hold);
//   }

//   void _showDeleteConfirmation(HoldRecord hold) {
//     setState(() {
//       _selectedHoldForDelete = hold;
//       _showDeleteDialog = true;
//     });
//   }

//   void _showPrintPreview(HoldRecord hold) {
//     setState(() {
//       _selectedHoldForPrint = hold;
//       _showPrintDialog = true;
//     });
//   }

//   Future<void> _deleteHold(HoldRecord hold) async {
//     try {
//       await widget.systemProvider.deleteHoldRecord(hold.id);
//       setState(() {
//         _holdRecords.removeWhere((h) => h.id == hold.id);
//         _filteredHoldRecords.removeWhere((h) => h.id == hold.id);
//         _showDeleteDialog = false;
//         _selectedHoldForDelete = null;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Hold record deleted successfully')),
//       );
//     } catch (e) {
//       log('Error deleting hold record: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting hold record: $e')),
//       );
//     }
//   }

//   String _formatDate(DateTime date) {
//     return DateFormat('MMM dd, yyyy HH:mm').format(date);
//   }

//   String _formatCurrency(double amount) {
//     return NumberFormat.currency(symbol: '₦', decimalDigits: 2).format(amount);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Sidebar
//         ConstrainedBox(
//           constraints: BoxConstraints(
//             maxHeight: widget.mediaQuery.height,
//           ),
//           child: SideBarPos(
//             vertical: 10,
//             horizontal: 5,
//             user: widget.user,
//             mediaQuery: widget.mediaQuery,
//             systemProvider: widget.systemProvider,
//             activeItem: widget.activeItem,
//             openInvoice: () {
//               // Handle invoice opening if needed
//             },
//           ),
//         ),
//         // Main Content
//         Expanded(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   // Header
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.1),
//                           spreadRadius: 1,
//                           blurRadius: 3,
//                           offset: const Offset(0, 1),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () => widget.activeItem.value = "Dashboard",
//                               icon: const Icon(Icons.arrow_back),
//                               style: IconButton.styleFrom(
//                                 backgroundColor: Colors.grey[100],
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Hold List Records',
//                                   style: TextStyle(
//                                     fontSize: 24.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.indigo[700],
//                                   ),
//                                 ),
//                                 Text(
//                                   'Manage and retrieve your held sales transactions',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Spacer(),
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: Colors.indigo[50],
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(color: Colors.indigo[200]!),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.inventory, size: 16, color: Colors.indigo[700]),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     '${_filteredHoldRecords.length} Total Holds',
//                                     style: TextStyle(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.indigo[700],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         // Search Bar
//                         Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 controller: _searchController,
//                                 decoration: InputDecoration(
//                                   hintText: 'Search by reference code, customer name, or warehouse...',
//                                   prefixIcon: const Icon(Icons.search),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.grey[300]!),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                     borderSide: BorderSide(color: Colors.indigo[400]!),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             ElevatedButton.icon(
//                               onPressed: _loadHoldRecords,
//                               icon: const Icon(Icons.refresh),
//                               label: const Text('Refresh'),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.grey[100],
//                                 foregroundColor: Colors.grey[700],
//                                 elevation: 0,
//                                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Content
//                   Expanded(
//                     child: _isLoading
//                         ? const Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CircularProgressIndicator(),
//                                 SizedBox(height: 16),
//                                 Text('Loading hold records...'),
//                               ],
//                             ),
//                           )
//                         : _filteredHoldRecords.isEmpty
//                             ? Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.inventory_2_outlined,
//                                       size: 64,
//                                       color: Colors.grey[400],
//                                     ),
//                                     const SizedBox(height: 16),
//                                     Text(
//                                       'No hold records found',
//                                       style: TextStyle(
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       _searchController.text.isEmpty
//                                           ? 'Any sales you hold will appear here'
//                                           : 'No results matching "${_searchController.text}"',
//                                       style: TextStyle(
//                                         fontSize: 14.sp,
//                                         color: Colors.grey[500],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : Column(
//                                 children: [
//                                   // Table
//                                   Expanded(
//                                     child: Container(
//                                       margin: const EdgeInsets.all(20),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(12),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.1),
//                                             spreadRadius: 1,
//                                             blurRadius: 3,
//                                             offset: const Offset(0, 1),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           // Table Header
//                                           Container(
//                                             padding: const EdgeInsets.all(16),
//                                             decoration: BoxDecoration(
//                                               color: Colors.grey[50],
//                                               borderRadius: const BorderRadius.only(
//                                                 topLeft: Radius.circular(12),
//                                                 topRight: Radius.circular(12),
//                                               ),
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: Text(
//                                                     'Reference',
//                                                     style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight: FontWeight.w600,
//                                                       color: Colors.grey[700],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: Text(
//                                                     'Date & Time',
//                                                     style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight: FontWeight.w600,
//                                                       color: Colors.grey[700],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: Text(
//                                                     'Customer',
//                                                     style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight: FontWeight.w600,
//                                                       color: Colors.grey[700],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: Text(
//                                                     'Warehouse',
//                                                     style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight: FontWeight.w600,
//                                                       color: Colors.grey[700],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: Center(
//                                                     child: Text(
//                                                       'Items',
//                                                       style: TextStyle(
//                                                         fontSize: 12.sp,
//                                                         fontWeight: FontWeight.w600,
//                                                         color: Colors.grey[700],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: Text(
//                                                     'Amount',
//                                                     textAlign: TextAlign.right,
//                                                     style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight: FontWeight.w600,
//                                                       color: Colors.grey[700],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   flex: 2,
//                                                   child: Center(
//                                                     child: Text(
//                                                       'Actions',
//                                                       style: TextStyle(
//                                                         fontSize: 12.sp,
//                                                         fontWeight: FontWeight.w600,
//                                                         color: Colors.grey[700],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           // Table Body
//                                           Expanded(
//                                             child: ListView.builder(
//                                               itemCount: _getPaginatedHolds().length,
//                                               itemBuilder: (context, index) {
//                                                 final hold = _getPaginatedHolds()[index];
//                                                 return Container(
//                                                   padding: const EdgeInsets.all(16),
//                                                   decoration: BoxDecoration(
//                                                     border: Border(
//                                                       bottom: BorderSide(
//                                                         color: Colors.grey[200]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Column(
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           children: [
//                                                             Text(
//                                                               hold.referenceCode,
//                                                               style: TextStyle(
//                                                                 fontSize: 12.sp,
//                                                                 fontWeight: FontWeight.w600,
//                                                                 color: Colors.indigo[600],
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                               'ID: ${hold.id}',
//                                                               style: TextStyle(
//                                                                 fontSize: 10.sp,
//                                                                 color: Colors.grey[500],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                           _formatDate(hold.createdAt),
//                                                           style: TextStyle(
//                                                             fontSize: 11.sp,
//                                                             color: Colors.grey[700],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                           hold.customerName,
//                                                           style: TextStyle(
//                                                             fontSize: 11.sp,
//                                                             fontWeight: FontWeight.w500,
//                                                             color: Colors.grey[800],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                           hold.warehouseName,
//                                                           style: TextStyle(
//                                                             fontSize: 11.sp,
//                                                             color: Colors.grey[600],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 1,
//                                                         child: Center(
//                                                           child: Container(
//                                                             padding: const EdgeInsets.symmetric(
//                                                               horizontal: 8,
//                                                               vertical: 4,
//                                                             ),
//                                                             decoration: BoxDecoration(
//                                                               color: Colors.indigo[100],
//                                                               borderRadius: BorderRadius.circular(12),
//                                                             ),
//                                                             child: Text(
//                                                               '${hold.holdItems.length}',
//                                                               style: TextStyle(
//                                                                 fontSize: 11.sp,
//                                                                 fontWeight: FontWeight.w600,
//                                                                 color: Colors.indigo[800],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                           _formatCurrency(hold.grandTotal),
//                                                           textAlign: TextAlign.right,
//                                                           style: TextStyle(
//                                                             fontSize: 12.sp,
//                                                             fontWeight: FontWeight.bold,
//                                                             color: Colors.grey[900],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: [
//                                                             IconButton(
//                                                               onPressed: () => _retrieveHold(hold),
//                                                               icon: const Icon(Icons.download),
//                                                               style: IconButton.styleFrom(
//                                                                 backgroundColor: Colors.green[50],
//                                                                 foregroundColor: Colors.green[700],
//                                                                 minimumSize: const Size(32, 32),
//                                                               ),
//                                                               tooltip: 'Retrieve',
//                                                             ),
//                                                             const SizedBox(width: 4),
//                                                             IconButton(
//                                                               onPressed: () => _showPrintPreview(hold),
//                                                               icon: const Icon(Icons.print),
//                                                               style: IconButton.styleFrom(
//                                                                 backgroundColor: Colors.blue[50],
//                                                                 foregroundColor: Colors.blue[700],
//                                                                 minimumSize: const Size(32, 32),
//                                                               ),
//                                                               tooltip: 'Print',
//                                                             ),
//                                                             const SizedBox(width: 4),
//                                                             IconButton(
//                                                               onPressed: () => _showDeleteConfirmation(hold),
//                                                               icon: const Icon(Icons.delete),
//                                                               style: IconButton.styleFrom(
//                                                                 backgroundColor: Colors.red[50],
//                                                                 foregroundColor: Colors.red[700],
//                                                                 minimumSize: const Size(32, 32),
//                                                               ),
//                                                               tooltip: 'Delete',
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
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   // Pagination
//                                   if (_totalPages > 1)
//                                     Container(
//                                       padding: const EdgeInsets.all(20),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Showing ${(_currentPage - 1) * _itemsPerPage + 1} to ${(_currentPage * _itemsPerPage > _filteredHoldRecords.length) ? _filteredHoldRecords.length : _currentPage * _itemsPerPage} of ${_filteredHoldRecords.length} holds',
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.grey[600],
//                                             ),
//                                           ),
//                                           Row(
//                                             children: [
//                                               IconButton(
//                                                 onPressed: _currentPage > 1
//                                                     ? () => setState(() => _currentPage--)
//                                                     : null,
//                                                 icon: const Icon(Icons.chevron_left),
//                                               ),
//                                               Text(
//                                                 'Page $_currentPage of $_totalPages',
//                                                 style: TextStyle(
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                               IconButton(
//                                                 onPressed: _currentPage < _totalPages
//                                                     ? () => setState(() => _currentPage++)
//                                                     : null,
//                                                 icon: const Icon(Icons.chevron_right),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                   ),
//                 ],
//               ),
//               // Delete Confirmation Dialog
//               if (_showDeleteDialog && _selectedHoldForDelete != null)
//                 Container(
//                   color: Colors.black54,
//                   child: Center(
//                     child: Container(
//                       width: 400,
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.delete, color: Colors.red[600]),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'Confirm Delete',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Are you sure you want to delete this held sale? This action cannot be undone.',
//                             style: TextStyle(fontSize: 14.sp),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.red[50],
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.red[200]!),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.warning, color: Colors.red[700], size: 16),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     'All items in this held sale will be permanently removed.',
//                                     style: TextStyle(
//                                       fontSize: 12.sp,
//                                       color: Colors.red[700],
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _showDeleteDialog = false;
//                                     _selectedHoldForDelete = null;
//                                   });
//                                 },
//                                 child: const Text('Cancel'),
//                               ),
//                               const SizedBox(width: 8),
//                               ElevatedButton(
//                                 onPressed: () => _deleteHold(_selectedHoldForDelete!),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red[600],
//                                   foregroundColor: Colors.white,
//                                 ),
//                                 child: const Text('Delete Hold'),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               // Print Preview Dialog
//               if (_showPrintDialog && _selectedHoldForPrint != null)
//                 Container(
//                   color: Colors.black54,
//                   child: Center(
//                     child: Container(
//                       width: 600,
//                       height: 700,
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(Icons.print, color: Colors.blue[600]),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Print Hold Details',
//                                     style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _showPrintDialog = false;
//                                     _selectedHoldForPrint = null;
//                                   });
//                                 },
//                                 icon: const Icon(Icons.close),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Expanded(
//                             child: SingleChildScrollView(
//                               child: _buildPrintContent(_selectedHoldForPrint!),
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _showPrintDialog = false;
//                                     _selectedHoldForPrint = null;
//                                   });
//                                 },
//                                 child: const Text('Close'),
//                               ),
//                               const SizedBox(width: 8),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   // Implement actual printing logic here
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('Print functionality not implemented yet')),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.print),
//                                 label: const Text('Print'),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue[600],
//                                   foregroundColor: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPrintContent(HoldRecord hold) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header
//         Center(
//           child: Column(
//             children: [
//               Text(
//                 'Your Store Name',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'Held Sale Details',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 24),
//         // Details
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailRow('Reference:', hold.referenceCode),
//                   _buildDetailRow('Date:', _formatDate(hold.createdAt)),
//                   _buildDetailRow('Customer:', hold.customerName),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailRow('Warehouse:', hold.warehouseName),
//                   _buildDetailRow('Items Count:', '${hold.holdItems.length}'),
//                   _buildDetailRow('Status:', 'On Hold'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         // Items Table
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[300]!),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(8),
//                     topRight: Radius.circular(8),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
//                     Expanded(flex: 1, child: Text('Qty', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
//                     Expanded(flex: 2, child: Text('Price', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
//                     Expanded(flex: 2, child: Text('Total', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp))),
//                   ],
//                 ),
//               ),
//               ...hold.holdItems.map((item) => Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border(top: BorderSide(color: Colors.grey[200]!)),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(flex: 3, child: Text(item.productName, style: TextStyle(fontSize: 11.sp))),
//                     Expanded(flex: 1, child: Text('${item.quantity}', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.sp))),
//                     Expanded(flex: 2, child: Text(_formatCurrency(item.netUnitPrice), textAlign: TextAlign.right, style: TextStyle(fontSize: 11.sp))),
//                     Expanded(flex: 2, child: Text(_formatCurrency(item.subTotal), textAlign: TextAlign.right, style: TextStyle(fontSize: 11.sp))),
//                   ],
//                 ),
//               )).toList(),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         // Total
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               'Grand Total: ${_formatCurrency(hold.grandTotal)}',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 80,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 12.sp),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }