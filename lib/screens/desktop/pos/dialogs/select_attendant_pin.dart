import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
import '../../model/select_attendant_model.dart';
import '../../providers/select_attendant_provider.dart';
// import '../../providers/enhanced_select_attendant_provider.dart';

class SelectAttendantPinDialog extends StatefulWidget {
  final SelectAttendantModel attendant;
  final Function(bool) onPinVerified;

  const SelectAttendantPinDialog({
    super.key,
    required this.attendant,
    required this.onPinVerified,
  });

  @override
  State<SelectAttendantPinDialog> createState() => _SelectAttendantPinDialogState();
}

class _SelectAttendantPinDialogState extends State<SelectAttendantPinDialog> {
  final TextEditingController _pinController = TextEditingController();
  bool _isVerifying = false;
  String? _errorMessage;
  bool _isOnline = false;
  String _connectionStatus = 'Checking connection...';

  @override
  void initState() {
    super.initState();
    _checkConnectionStatus();
  }

  Future<void> _checkConnectionStatus() async {
    final isConnected = await InternetUtils.isConnected();
    final provider = context.read<SelectAttendantProvider>();
    final hasOfflinePin = await provider.hasOfflinePin(widget.attendant.apiId);
    
    setState(() {
      _isOnline = isConnected;
      if (isConnected && hasOfflinePin) {
        _connectionStatus = 'Online - PIN can be verified offline or online';
      } else if (isConnected) {
        _connectionStatus = 'Online - PIN will be verified online';
      } else if (hasOfflinePin) {
        _connectionStatus = 'Offline - PIN will be verified offline';
      } else {
        _connectionStatus = 'Offline - No offline PIN available';
      }
    });
  }

  void _verifyPin() async {
    if (_pinController.text.trim().length != 6) {
      setState(() {
        _errorMessage = 'PIN must be 6 digits';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    final inputPin = _pinController.text.trim();
    
    try {
      final response = await context.read<SelectAttendantProvider>().verifyPin(widget.attendant.apiId, inputPin);
      
      setState(() {
        _isVerifying = false;
        if (!response['success']) {
          _errorMessage = response['message'] ?? 'Invalid PIN';
        }
      });

      // Show verification method in snackbar
      if (response['success']) {
        final verificationMethod = response['isOffline'] == true ? 'offline' : 'online';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PIN verified $verificationMethod'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }

      widget.onPinVerified(response['success']);
      if (response['success']) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _isVerifying = false;
        _errorMessage = 'Error verifying PIN: $e';
      });
      widget.onPinVerified(false);
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Verify Attendant: ${widget.attendant.fullName}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection status indicator
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _isOnline ? Colors.green.shade50 : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: _isOnline ? Colors.green : Colors.orange,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _isOnline ? Icons.wifi : Icons.wifi_off,
                    color: _isOnline ? Colors.green : Colors.orange,
                    size: 16,
                  ),
                  Gap(8),
                  Expanded(
                    child: Text(
                      _connectionStatus,
                      style: TextStyle(
                        fontSize: 12,
                        color: _isOnline ? Colors.green.shade700 : Colors.orange.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(15),
            const Text('Enter PIN'),
            Gap(10),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'Enter 6-digit PIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: ColorsRes.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: ColorsRes.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                errorText: _errorMessage,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                suffixIcon: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _checkConnectionStatus,
                  tooltip: 'Refresh connection status',
                ),
              ),
              onSubmitted: (_) => _verifyPin(),
            ),
            if (_errorMessage != null) ...[
              Gap(10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 16),
                    Gap(8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onPinVerified(false);
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isVerifying ? null : _verifyPin,
          child: _isVerifying
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Verify'),
        ),
      ],
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import '../../model/select_attendant_model.dart';
// import '../../providers/select_attendant_provider.dart';

// class SelectAttendantPinDialog extends StatefulWidget {
//   final SelectAttendantModel attendant;
//   final Function(bool) onPinVerified;

//   const SelectAttendantPinDialog({
//     super.key,
//     required this.attendant,
//     required this.onPinVerified,
//   });

//   @override
//   State<SelectAttendantPinDialog> createState() => _SelectAttendantPinDialogState();
// }

// class _SelectAttendantPinDialogState extends State<SelectAttendantPinDialog> {
//   final TextEditingController _pinController = TextEditingController();
//   bool _isVerifying = false;
//   String? _errorMessage;

//   void _verifyPin() async {
//     setState(() {
//       _isVerifying = true;
//       _errorMessage = null;
//     });

//     final inputPin = _pinController.text.trim();
    
//     try {
//       final response = await context.read<SelectAttendantProvider>().verifyPin(widget.attendant.apiId, inputPin);
      
//       setState(() {
//         _isVerifying = false;
//         if (!response['success']) {
//           _errorMessage = response['message'] ?? 'Invalid PIN';
//         }
//       });

//       widget.onPinVerified(response['success']);
//       if (response['success']) {
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       setState(() {
//         _isVerifying = false;
//         _errorMessage = 'Error verifying PIN: $e';
//       });
//       widget.onPinVerified(false);
//     }
//   }

//   @override
//   void dispose() {
//     _pinController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Verify Attendant: ${widget.attendant.fullName}'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Enter PIN'),
//             Gap(10),
//             TextField(
//               controller: _pinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: 'Enter PIN',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: ColorsRes.grey),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: ColorsRes.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//                 errorText: _errorMessage,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onPinVerified(false);
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: _isVerifying ? null : _verifyPin,
//           child: _isVerifying
//               ? const SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 )
//               : const Text('Verify'),
//         ),
//       ],
//     );
//   }
// }