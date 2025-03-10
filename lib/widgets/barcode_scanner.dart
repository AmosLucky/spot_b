// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_zxing/flutter_zxing.dart';

// class BarcodeScanner extends StatefulWidget {
//   final Function(Code?) onScanSuccess;
//   final Function(String error)? onScanFailure;
//   final bool isMultiScan;

//   const BarcodeScanner({
//     Key? key,
//     required this.onScanSuccess,
//     this.onScanFailure,
//     this.isMultiScan = false,
//   }) : super(key: key);

//   @override
//   State<BarcodeScanner> createState() => _BarcodeScannerState();
// }

// class _BarcodeScannerState extends State<BarcodeScanner> {
//   Code? result;
//   Codes? multiResult;

//   int successScans = 0;
//   int failedScans = 0;

//   @override
//   Widget build(BuildContext context) {
//     final isCameraSupported = defaultTargetPlatform == TargetPlatform.iOS ||
//         defaultTargetPlatform == TargetPlatform.android ||
//         defaultTargetPlatform == TargetPlatform.linux ||
//         defaultTargetPlatform == TargetPlatform.macOS ||
//         defaultTargetPlatform == TargetPlatform.windows;

//     return !isCameraSupported
//         ? const Center(
//             child: Text('Camera not supported on this platform'),
//           )
//         : Stack(
//             children: [
//               ReaderWidget(
//                 onScan: _onScanSuccess,
//                 onScanFailure: _onScanFailure,
//                 onMultiScan: _onMultiScanSuccess,
//                 onMultiScanFailure: _onMultiScanFailure,
//                 onMultiScanModeChanged: _onMultiScanModeChanged,
//                 onControllerCreated: _onControllerCreated,
//                 isMultiScan: widget.isMultiScan,
//                 scanDelay:
//                     Duration(milliseconds: widget.isMultiScan ? 50 : 500),
//                 resolution: ResolutionPreset.high,
//                 lensDirection: CameraLensDirection.back,
//                 flashOnIcon: const Icon(Icons.flash_on),
//                 flashOffIcon: const Icon(Icons.flash_off),
//                 flashAlwaysIcon: const Icon(Icons.flash_on),
//                 flashAutoIcon: const Icon(Icons.flash_auto),
//                 galleryIcon: const Icon(Icons.photo_library),
//                 toggleCameraIcon: const Icon(Icons.switch_camera),
//                 actionButtonsBackgroundBorderRadius: BorderRadius.circular(10),
//                 actionButtonsBackgroundColor: Colors.black.withOpacity(0.5),
//               ),
//             ],
//           );
//   }

//   void _onControllerCreated(_, Exception? error) {
//     if (error != null) {
//       widget.onScanFailure?.call('Error: $error');
//     }
//   }

//   void _onScanSuccess(Code? code) {
//     setState(() {
//       successScans++;
//       result = code;
//     });
//     widget.onScanSuccess(code);
//   }

//   void _onScanFailure(Code? code) {
//     setState(() {
//       failedScans++;
//       result = code;
//     });
//     if (code?.error?.isNotEmpty == true) {
//       widget.onScanFailure?.call(code?.error ?? "Scan failed");
//     }
//   }

//   void _onMultiScanSuccess(Codes codes) {
//     setState(() {
//       successScans++;
//       multiResult = codes;
//     });
//   }

//   void _onMultiScanFailure(Codes codes) {
//     setState(() {
//       failedScans++;
//       multiResult = codes;
//     });
//     if (codes.codes.isNotEmpty == true) {
//       widget.onScanFailure
//           ?.call(codes.codes.first.error ?? "Multi-scan failed");
//     }
//   }

//   void _onMultiScanModeChanged(bool isMultiScan) {
//     setState(() {
//       // Update multi-scan mode
//     });
//   }
// }
