import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/common/provider/products_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../providers/products_provider.dart';

class CreateProductScreen extends StatefulWidget {
  final SystemProvider systemProvider;

  const CreateProductScreen({Key? key, required this.systemProvider})
      : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _notesController = TextEditingController();
  final _orderTaxController = TextEditingController();
  final _variationControllers = <Map<String, TextEditingController>>[];
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  int _type = 2;
  int _productCategoryId = 22;
  int _brandId = 6;
  int _barcodeSymbol = 1;
  int _productUnit = 26;
  int _saleUnit = 18;
  int _purchaseUnit = 18;
  int _productType = 2;
  int _quantityLimit = 100;
  int _purchaseSupplierId = 1;
  int _purchaseWarehouseId = 37;
  DateTime _purchaseDate = DateTime(2025, 6, 13);
  int _purchaseStatus = 1;
  int _taxType = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addVariation();
  }

  void _addVariation() {
    _variationControllers.add({
      'variation_type': TextEditingController(),
      'product_cost': TextEditingController(),
      'product_price': TextEditingController(),
      'stock_alert': TextEditingController(),
      'order_tax': TextEditingController(),
      'tax_type': TextEditingController(),
      'add_stock': TextEditingController(),
      'code': TextEditingController(),
      'barcode_symbol': TextEditingController(),
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final provider = Provider.of<ProductsProvider>(context, listen: false);
      final variationData = _variationControllers.map((controller) => {
        'variation_type': controller['variation_type']!.text,
        'product_cost': controller['product_cost']!.text,
        'product_price': controller['product_price']!.text,
        'stock_alert': controller['stock_alert']!.text,
        'order_tax': controller['order_tax']!.text,
        'tax_type': controller['tax_type']!.text,
        'add_stock': controller['add_stock']!.text,
        'code': controller['code']!.text,
        'barcode_symbol': controller['barcode_symbol']!.text,
      }).toList();

      final payload = {
        'name': _nameController.text,
        'product_code': _productCodeController.text,
        'type': _type,
        'product_category_id': _productCategoryId,
        'brand_id': _brandId,
        'code': _productCodeController.text,
        'barcode_symbol': _barcodeSymbol,
        'product_unit': _productUnit,
        'sale_unit': _saleUnit,
        'purchase_unit': _purchaseUnit,
        'product_type': _productType,
        'quantity_limit': _quantityLimit,
        'notes': _notesController.text,
        'purchase_supplier_id': _purchaseSupplierId,
        'purchase_warehouse_id': _purchaseWarehouseId,
        'purchase_date': _purchaseDate.toIso8601String().split('T')[0],
        'purchase_status': _purchaseStatus,
        'variation_data': variationData,
        'order_tax': int.tryParse(_orderTaxController.text) ?? 0,
        'tax_type': _taxType,
      };

      try {
        await provider.createProduct(payload, context);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.drag_handle,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Create New Product',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      controller: _nameController,
                      label: 'Product Name',
                      validator: (value) =>
                          value!.isEmpty ? 'Name is required' : null,
                    ),
                    _buildInputField(
                      controller: _productCodeController,
                      label: 'Product Code',
                      validator: (value) =>
                          value!.isEmpty ? 'Product Code is required' : null,
                    ),
                    _buildInputField(
                      controller: _orderTaxController,
                      label: 'Order Tax (%)',
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Order Tax is required' : null,
                    ),
                    _buildInputField(
                      controller: _notesController,
                      label: 'Notes',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Variations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _variationControllers.length,
                      itemBuilder: (context, index) {
                        final controller = _variationControllers[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInputField(
                                  controller: controller['variation_type']!,
                                  label: 'Variation Type',
                                  validator: (value) =>
                                      value!.isEmpty ? 'Required' : null,
                                ),
                                _buildInputField(
                                  controller: controller['product_cost']!,
                                  label: 'Product Cost',
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      value!.isEmpty ? 'Required' : null,
                                ),
                                _buildInputField(
                                  controller: controller['product_price']!,
                                  label: 'Product Price',
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      value!.isEmpty ? 'Required' : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: _addVariation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B46C1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Add Variation'),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _imageFile == null
                            ? const Center(child: Icon(Icons.add_a_photo))
                            : Image.file(File(_imageFile!.path), fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B46C1),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Create Product',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _productCodeController.dispose();
    _notesController.dispose();
    _orderTaxController.dispose();
    for (var controller in _variationControllers) {
      controller.values.forEach((c) => c.dispose());
    }
    super.dispose();
  }
}




// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';

// import '../../providers/products_provider.dart';
// // import 'package:spotstock_inventory/common/provider/products_provider.dart';
// // import 'package:image_picker/image_picker.dart';

// class CreateProductScreen extends StatefulWidget {
//   final SystemProvider systemProvider;

//   const CreateProductScreen({Key? key, required this.systemProvider})
//       : super(key: key);

//   @override
//   _CreateProductScreenState createState() => _CreateProductScreenState();
// }

// class _CreateProductScreenState extends State<CreateProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _productCodeController = TextEditingController();
//   final _notesController = TextEditingController();
//   final _variationControllers = <Map<String, TextEditingController>>[];
//   XFile? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   int _type = 2;
//   int _productCategoryId = 22;
//   int _brandId = 6;
//   int _barcodeSymbol = 1;
//   int _productUnit = 1;
//   int _saleUnit = 1;
//   int _purchaseUnit = 1;
//   int _productType = 2;
//   int _quantityLimit = 100;
//   int _purchaseSupplierId = 1;
//   int _purchaseWarehouseId = 37;
//   DateTime _purchaseDate = DateTime(2025, 5, 14);
//   int _purchaseStatus = 1;
//   int _orderTax = 100;
//   int _taxType = 1;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _addVariation();
//   }

//   void _addVariation() {
//     _variationControllers.add({
//       'variation_type': TextEditingController(),
//       'product_cost': TextEditingController(),
//       'product_price': TextEditingController(),
//       'stock_alert': TextEditingController(),
//       'order_tax': TextEditingController(),
//       'tax_type': TextEditingController(),
//       'add_stock': TextEditingController(),
//       'code': TextEditingController(),
//       'barcode_symbol': TextEditingController(),
//     });
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       final provider = Provider.of<ProductsProvider>(context, listen: false);
//       final variationData = _variationControllers.map((controller) => {
//         'variation_type': controller['variation_type']!.text,
//         'product_cost': controller['product_cost']!.text,
//         'product_price': controller['product_price']!.text,
//         'stock_alert': controller['stock_alert']!.text,
//         'order_tax': controller['order_tax']!.text,
//         'tax_type': controller['tax_type']!.text,
//         'add_stock': controller['add_stock']!.text,
//         'code': controller['code']!.text,
//         'barcode_symbol': controller['barcode_symbol']!.text,
//       }).toList();

//       final payload = {
//         'name': _nameController.text,
//         'product_code': _productCodeController.text,
//         'type': _type,
//         'product_category_id': _productCategoryId,
//         'brand_id': _brandId,
//         'code': _productCodeController.text,
//         'barcode_symbol': _barcodeSymbol,
//         'product_unit': _productUnit,
//         'sale_unit': _saleUnit,
//         'purchase_unit': _purchaseUnit,
//         'product_type': _productType,
//         'quantity_limit': _quantityLimit,
//         'notes': _notesController.text,
//         'purchase_supplier_id': _purchaseSupplierId,
//         'purchase_warehouse_id': _purchaseWarehouseId,
//         'purchase_date': _purchaseDate.toIso8601String().split('T')[0],
//         'purchase_status': _purchaseStatus,
//         'variation_data': variationData,
//         'order_tax': _orderTax,
//         'tax_type': _taxType,
//       };

//       try {
//         await provider.createProduct(payload, context);
//         Navigator.pop(context, true);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       } finally {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create Product')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         height: 100,
//                         width: 100,
//                         color: Colors.grey[300],
//                         child: _imageFile == null
//                             ? const Icon(Icons.add_a_photo)
//                             : Image.file(File(_imageFile!.path)),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Name is required' : null,
//                     ),
//                     TextFormField(
//                       controller: _productCodeController,
//                       decoration: const InputDecoration(labelText: 'Product Code'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Product Code is required' : null,
//                     ),
//                     TextFormField(
//                       controller: _notesController,
//                       decoration: const InputDecoration(labelText: 'Notes'),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text('Variations',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: _variationControllers.length,
//                       itemBuilder: (context, index) {
//                         final controller = _variationControllers[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: Column(
//                               children: [
//                                 TextFormField(
//                                   controller: controller['variation_type'],
//                                   decoration:
//                                       const InputDecoration(labelText: 'Variation Type'),
//                                   validator: (value) =>
//                                       value!.isEmpty ? 'Required' : null,
//                                 ),
//                                 TextFormField(
//                                   controller: controller['product_cost'],
//                                   decoration:
//                                       const InputDecoration(labelText: 'Product Cost'),
//                                   keyboardType: TextInputType.number,
//                                   validator: (value) =>
//                                       value!.isEmpty ? 'Required' : null,
//                                 ),
//                                 TextFormField(
//                                   controller: controller['product_price'],
//                                   decoration:
//                                       const InputDecoration(labelText: 'Product Price'),
//                                   keyboardType: TextInputType.number,
//                                   validator: (value) =>
//                                       value!.isEmpty ? 'Required' : null,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     ElevatedButton(
//                       onPressed: _addVariation,
//                       child: const Text('Add Variation'),
//                     ),
//                     const SizedBox(height: 16),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF6B46C1),
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         ),
//                         child: const Text('Submit'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _productCodeController.dispose();
//     _notesController.dispose();
//     for (var controller in _variationControllers) {
//       controller.values.forEach((c) => c.dispose());
//     }
//     super.dispose();
//   }
// }