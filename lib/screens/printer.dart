// import 'dart:typed_data';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:flutter/material.dart' hide Image;
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
// import 'dart:io' show Platform;
// import 'package:image/image.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PrintReceipt extends StatefulWidget {
//   final Map<String, dynamic> data;
//   final List items;
//   const PrintReceipt({super.key, required this.data, required this.items});

//   @override
//   State<PrintReceipt> createState() => _PrintReceiptState();
// }

// class _PrintReceiptState extends State<PrintReceipt> {
//   PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//   List<PrinterBluetooth> _devices = [];
//   String? _devicesMsg;
//   BluetoothManager bluetoothManager = BluetoothManager.instance;

//   @override
//   void initState() {
//     if (Platform.isAndroid) {
//       bluetoothManager.state.listen((val) {
//         print('state = $val');
//         if (!mounted) return;
//         if (val == 12) {
//           print('on');
//           initPrinter();
//         } else if (val == 10) {
//           print('off');
//           setState(() => _devicesMsg = 'Bluetooth Disconnected!');
//         }
//       });
//     } else {
//       initPrinter();
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//         title: const Text(
//           'Print',
//           style: TextStyle(color: whiteColor),
//         ),
//         actions: [],
//       ),
//       body: _devices.isEmpty
//           ? Center(child: Text(_devicesMsg ?? ''))
//           : ListView.builder(
//               itemCount: _devices.length,
//               itemBuilder: (c, i) {
//                 return ListTile(
//                   leading: const Icon(Icons.print),
//                   title: Text(_devices[i].name!),
//                   subtitle: Text(_devices[i].address!),
//                   onTap: () {
//                     _startPrint(_devices[i]);
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   void initPrinter() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.location,
//       Permission.bluetoothScan,
//       Permission.bluetoothConnect
//     ].request();
//     for (var status in statuses.entries) {
//       if (status.key == Permission.location) {
//         if (status.value.isGranted) {
//           debugPrint('Location permission granted');
//         } else {
//           debugPrint("Location permission not granted");
//         }
//       } else if (status.key == Permission.bluetoothScan) {
//         if (status.value.isGranted) {
//           debugPrint('Bluetooth scan permission granted');
//         } else {
//           debugPrint('Bluetooth scan permission not granted');
//         }
//       } else if (status.key == Permission.bluetoothConnect) {
//         if (status.value.isGranted) {
//           debugPrint('Bluetooth connect permission granted');
//         } else {
//           debugPrint('Bluetooth connect permission not granted');
//         }
//       }
//     }
//     _printerManager.startScan(const Duration(seconds: 2));
//     _printerManager.scanResults.listen((val) {
//       print("========= bluetooth ========");
//       print(val);
//       if (!mounted) return;
//       setState(() => _devices = val);
//       if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
//     });
//   }

//   Future<void> _startPrint(PrinterBluetooth printer) async {
//     _printerManager.selectPrinter(printer);
//     final result =
//         await _printerManager.printTicket(await _ticket(PaperSize.mm80));
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         content: Text(result.msg),
//       ),
//     );
//   }

//   Future<List<int>> _ticket(PaperSize paper) async {
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);
//     List<int> bytes = [];

//     // Image assets
//     final ByteData data = await rootBundle.load('assets/logo/nl.png');
//     final Uint8List imgBytes = data.buffer.asUint8List();
//     final Image image = decodeImage(imgBytes)!;
//     bytes += generator.image(image);

//     bytes += generator.row([
//       // PosColumn(
//       //   text: 'col3',
//       //   width: 3,
//       //   styles: const PosStyles(align: PosAlign.center, underline: true),
//       // ),
//       PosColumn(
//         text: 'Items',
//         width: 6,
//         styles: const PosStyles(align: PosAlign.center, underline: true),
//       ),
//       PosColumn(
//         text: 'Amount',
//         width: 3,
//         styles: const PosStyles(align: PosAlign.center, underline: true),
//       ),
//     ]);

//     bytes += generator.text(
//       'Ebeano Inventory',
//       styles: const PosStyles(
//           align: PosAlign.center,
//           height: PosTextSize.size2,
//           width: PosTextSize.size2),
//       linesAfter: 1,
//     );

//     var items = widget.items;

//     for (var i = 0; i < items.length; i++) {
//       var item = items[i]['product'];
//       var qtyAmt = item['Net_price'] * items[i]['quantity'];
//       bytes += generator.text(item['name']);
//       bytes += generator.row([
//         PosColumn(text: '${item['Net_price']} x ${items[i]['quantity']}', width: 6),
//         PosColumn(text: 'N$qtyAmt', width: 6),
//       ]);
//     }

//     bytes += generator.feed(1);
//     bytes += generator.row([
//       PosColumn(text: 'Total', width: 6, styles: const PosStyles(bold: true)),
//       PosColumn(
//           text: 'N${widget.data["amount"]}',
//           width: 6,
//           styles: const PosStyles(bold: true)),
//     ]);
//     bytes += generator.row([
//       PosColumn(
//           text: 'Customer Name', width: 6, styles: const PosStyles(bold: true)),
//       PosColumn(
//           text: '${widget.data["customer_name"]}',
//           width: 6,
//           styles: const PosStyles(bold: true)),
//     ]);
//     bytes += generator.row([
//       PosColumn(
//           text: 'Receipt No', width: 6, styles: const PosStyles(bold: true)),
//       PosColumn(
//           text: '${widget.data["trxId"]}',
//           width: 6,
//           styles: const PosStyles(bold: true)),
//     ]);
//     bytes += generator.row([
//       PosColumn(
//           text: 'Date Issued: ', width: 6, styles: const PosStyles(bold: true)),
//       PosColumn(
//           text: '${widget.data["created_at"]}',
//           width: 6,
//           styles: const PosStyles(bold: true)),
//     ]);
//     bytes += generator.feed(2);
//     bytes += generator.text('Thank You',
//         styles: const PosStyles(align: PosAlign.center, bold: true));
//     bytes += generator.cut();
//     return bytes;
//   }

//   @override
//   void dispose() {
//     _printerManager.stopScan();
//     super.dispose();
//   }
// }


// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io' show Platform;
// import 'package:permission_handler/permission_handler.dart';

// class PrintReceipt extends StatefulWidget {
//   final Map<String, dynamic> data;
//   final List items;
//   const PrintReceipt({super.key, required this.data, required this.items});

//   @override
//   State<PrintReceipt> createState() => _PrintReceiptState();
// }

// class _PrintReceiptState extends State<PrintReceipt> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

//   bool _connected = false;
//   BluetoothDevice? _device;
//   String tips = 'no device connect';

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initBluetooth() async {
//     bluetoothPrint.startScan(timeout: Duration(seconds: 4));

//     bool isConnected = await bluetoothPrint.isConnected ?? false;

//     bluetoothPrint.state.listen((state) {
//       print('******************* cur device status: $state');

//       switch (state) {
//         case BluetoothPrint.CONNECTED:
//           setState(() {
//             _connected = true;
//             tips = 'connect success';
//           });
//           break;
//         case BluetoothPrint.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             tips = 'disconnect success';
//           });
//           break;
//         default:
//           break;
//       }
//     });

//     if (!mounted) return;

//     if (isConnected) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//         title: const Text(
//           'Print',
//           style: TextStyle(color: whiteColor),
//         ),
//         actions: [],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () =>
//             bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     child: Text(tips),
//                   ),
//                 ],
//               ),
//               Divider(),
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: bluetoothPrint.scanResults,
//                 initialData: [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map((d) => ListTile(
//                             title: Text(d.name ?? ''),
//                             subtitle: Text(d.address ?? ''),
//                             onTap: () async {
//                               setState(() {
//                                 _device = d;
//                               });
//                             },
//                             trailing:
//                                 _device != null && _device!.address == d.address
//                                     ? Icon(
//                                         Icons.check,
//                                         color: Colors.green,
//                                       )
//                                     : null,
//                           ))
//                       .toList(),
//                 ),
//               ),
//               Divider(),
//               Container(
//                 padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         OutlinedButton(
//                           child: Text('connect'),
//                           onPressed: _connected
//                               ? null
//                               : () async {
//                                   if (_device != null &&
//                                       _device!.address != null) {
//                                     setState(() {
//                                       tips = 'connecting...';
//                                     });
//                                     await bluetoothPrint.connect(_device!);
//                                   } else {
//                                     setState(() {
//                                       tips = 'please select device';
//                                     });
//                                     print('please select device');
//                                   }
//                                 },
//                         ),
//                         SizedBox(width: 10.0),
//                         OutlinedButton(
//                           child: Text('disconnect'),
//                           onPressed: _connected
//                               ? () async {
//                                   setState(() {
//                                     tips = 'disconnecting...';
//                                   });
//                                   await bluetoothPrint.disconnect();
//                                 }
//                               : null,
//                         ),
//                       ],
//                     ),
//                     Divider(),
//                     OutlinedButton(
//                       child: Text('print receipt(esc)'),
//                       onPressed: _connected
//                           ? () async {
//                               Map<String, dynamic> config = Map();

//                               List<LineText> list = [];

//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content:
//                                       '**********************************************',
//                                   weight: 1,
//                                   align: LineText.ALIGN_CENTER,
//                                   linefeed: 1));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '打印单据头',
//                                   weight: 1,
//                                   align: LineText.ALIGN_CENTER,
//                                   fontZoom: 2,
//                                   linefeed: 1));
//                               list.add(LineText(linefeed: 1));

//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content:
//                                       '----------------------明细---------------------',
//                                   weight: 1,
//                                   align: LineText.ALIGN_CENTER,
//                                   linefeed: 1));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '物资名称规格型号',
//                                   weight: 1,
//                                   align: LineText.ALIGN_LEFT,
//                                   x: 0,
//                                   relativeX: 0,
//                                   linefeed: 0));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '单位',
//                                   weight: 1,
//                                   align: LineText.ALIGN_LEFT,
//                                   x: 350,
//                                   relativeX: 0,
//                                   linefeed: 0));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '数量',
//                                   weight: 1,
//                                   align: LineText.ALIGN_LEFT,
//                                   x: 500,
//                                   relativeX: 0,
//                                   linefeed: 1));

//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '混凝土C30',
//                                   align: LineText.ALIGN_LEFT,
//                                   x: 0,
//                                   relativeX: 0,
//                                   linefeed: 0));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '吨',
//                                   align: LineText.ALIGN_LEFT,
//                                   x: 350,
//                                   relativeX: 0,
//                                   linefeed: 0));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content: '12.0',
//                                   align: LineText.ALIGN_LEFT,
//                                   x: 500,
//                                   relativeX: 0,
//                                   linefeed: 1));

//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   content:
//                                       '**********************************************',
//                                   weight: 1,
//                                   align: LineText.ALIGN_CENTER,
//                                   linefeed: 1));
//                               list.add(LineText(linefeed: 1));

//                               ByteData data = await rootBundle
//                                   .load("assets/images/bluetooth_print.png");
//                               List<int> imageBytes = data.buffer.asUint8List(
//                                   data.offsetInBytes, data.lengthInBytes);
//                               String base64Image = base64Encode(imageBytes);
//                               // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

//                               await bluetoothPrint.printReceipt(config, list);
//                             }
//                           : null,
//                     ),
//                     OutlinedButton(
//                       child: Text('print label(tsc)'),
//                       onPressed: _connected
//                           ? () async {
//                               Map<String, dynamic> config = Map();
//                               config['width'] = 40; // 标签宽度，单位mm
//                               config['height'] = 70; // 标签高度，单位mm
//                               config['gap'] = 2; // 标签间隔，单位mm

//                               // x、y坐标位置，单位dpi，1mm=8dpi
//                               List<LineText> list = [];
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   x: 10,
//                                   y: 10,
//                                   content: 'A Title'));
//                               list.add(LineText(
//                                   type: LineText.TYPE_TEXT,
//                                   x: 10,
//                                   y: 40,
//                                   content: 'this is content'));
//                               list.add(LineText(
//                                   type: LineText.TYPE_QRCODE,
//                                   x: 10,
//                                   y: 70,
//                                   content: 'qrcode i\n'));
//                               list.add(LineText(
//                                   type: LineText.TYPE_BARCODE,
//                                   x: 10,
//                                   y: 190,
//                                   content: 'qrcode i\n'));

//                               List<LineText> list1 = [];
//                               ByteData data = await rootBundle
//                                   .load("assets/images/guide3.png");
//                               List<int> imageBytes = data.buffer.asUint8List(
//                                   data.offsetInBytes, data.lengthInBytes);
//                               String base64Image = base64Encode(imageBytes);
//                               list1.add(LineText(
//                                 type: LineText.TYPE_IMAGE,
//                                 x: 10,
//                                 y: 10,
//                                 content: base64Image,
//                               ));

//                               await bluetoothPrint.printLabel(config, list);
//                               await bluetoothPrint.printLabel(config, list1);
//                             }
//                           : null,
//                     ),
//                     OutlinedButton(
//                       child: Text('print selftest'),
//                       onPressed: _connected
//                           ? () async {
//                               await bluetoothPrint.printTest();
//                             }
//                           : null,
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: bluetoothPrint.isScanning,
//         initialData: false,
//         builder: (c, snapshot) {
//           if (snapshot.data == true) {
//             return FloatingActionButton(
//               child: const Icon(Icons.stop),
//               onPressed: () => bluetoothPrint.stopScan(),
//               backgroundColor: primaryColor,
//             );
//           } else {
//             return FloatingActionButton(
//                 child: Icon(Icons.search),
//                 onPressed: () =>
//                     bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
//           }
//         },
//       ),
//     );
//   }
// }
