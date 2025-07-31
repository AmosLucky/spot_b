import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
import '../../model/select_attendant_model.dart';
import '../../providers/select_attendant_provider.dart';

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
  String? _errorType;
  bool _isOnline = false;
  String _connectionStatus = 'Checking connection...';
  bool _hasOfflinePin = false;

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
      _hasOfflinePin = hasOfflinePin;

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

  String _getErrorMessage(String? errorType, String defaultMessage) {
    switch (errorType) {
      case 'INVALID_INPUT':
        return 'PIN cannot be empty';
      case 'INVALID_FORMAT':
        return 'PIN must be exactly 6 digits (numbers only)';
      case 'INVALID_PIN_OFFLINE':
        return 'Invalid PIN entered (verified offline)';
      case 'INVALID_PIN_ONLINE':
        return 'Invalid PIN entered (verified online)';
      case 'NO_OFFLINE_PIN_NO_INTERNET':
        return 'No internet connection and no offline PIN available.\nPlease connect to internet to verify PIN.';
      case 'NETWORK_ERROR':
        return 'Network error occurred. Please check your connection and try again.';
      case 'AUTH_ERROR':
        return 'Authentication failed. Please login again.';
      case 'USER_NOT_FOUND':
        return 'Attendant not found on server. Please contact administrator.';
      case 'SERVER_ERROR':
        return 'Invalid Pin, please input the correct pin and try again later.';
      case 'SYSTEM_ERROR':
        return 'System error occurred. Please try again or contact support.';
      case 'UNKNOWN_ERROR':
        return 'Unable to verify PIN. Please try again.';
      default:
        return defaultMessage;
    }
  }

  Color _getErrorColor(String? errorType) {
    switch (errorType) {
      case 'INVALID_INPUT':
      case 'INVALID_FORMAT':
        return Colors.orange;
      case 'INVALID_PIN_OFFLINE':
      case 'INVALID_PIN_ONLINE':
        return Colors.red;
      case 'NO_OFFLINE_PIN_NO_INTERNET':
        return Colors.blue;
      case 'NETWORK_ERROR':
      case 'AUTH_ERROR':
      case 'SERVER_ERROR':
        return Colors.red;
      case 'USER_NOT_FOUND':
        return Colors.purple;
      case 'SYSTEM_ERROR':
      case 'UNKNOWN_ERROR':
        return Colors.grey;
      default:
        return Colors.red;
    }
  }

  IconData _getErrorIcon(String? errorType) {
    switch (errorType) {
      case 'INVALID_INPUT':
      case 'INVALID_FORMAT':
        return Icons.warning_outlined;
      case 'INVALID_PIN_OFFLINE':
      case 'INVALID_PIN_ONLINE':
        return Icons.lock_outlined;
      case 'NO_OFFLINE_PIN_NO_INTERNET':
        return Icons.wifi_off_outlined;
      case 'NETWORK_ERROR':
        return Icons.signal_wifi_connected_no_internet_4_outlined;
      case 'AUTH_ERROR':
        return Icons.account_circle_outlined;
      case 'SERVER_ERROR':
        return Icons.error_outline_rounded;
      case 'USER_NOT_FOUND':
        return Icons.person_off_outlined;
      case 'SYSTEM_ERROR':
      case 'UNKNOWN_ERROR':
        return Icons.error_outline;
      default:
        return Icons.error_outline;
    }
  }

  void _verifyPin() async {
    // Clear previous errors
    setState(() {
      _errorMessage = null;
      _errorType = null;
    });

    // Basic client-side validation
    final pin = _pinController.text.trim();
    if (pin.isEmpty) {
      setState(() {
        _errorMessage = 'PIN cannot be empty';
        _errorType = 'INVALID_INPUT';
      });
      return;
    }
    if (pin.length != 6) {
      setState(() {
        _errorMessage = 'PIN must be exactly 6 digits';
        _errorType = 'INVALID_FORMAT';
      });
      return;
    }
    if (!RegExp(r'^\d+$').hasMatch(pin)) {
      setState(() {
        _errorMessage = 'PIN must contain only numbers';
        _errorType = 'INVALID_FORMAT';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    try {
      final response = await context.read<SelectAttendantProvider>().verifyPin(widget.attendant.apiId, pin);

      setState(() {
        _isVerifying = false;
        if (!response['success']) {
          _errorMessage = _getErrorMessage(response['errorType'], response['message'] ?? 'Invalid PIN');
          _errorType = response['errorType'];
        }
      });

      // Show verification method in snackbar for successful verifications
      if (response['success']) {
        final verificationMethod = response['isOffline'] == true ? 'offline' : 'online';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PIN verified successfully ($verificationMethod)'),
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
        _errorMessage = 'System error occurred during PIN verification. Please try again.';
        _errorType = 'SYSTEM_ERROR';
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
                color: _isOnline ? Colors.green.shade50 :
                        _hasOfflinePin ? Colors.orange.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: _isOnline ? Colors.green :
                          _hasOfflinePin ? Colors.orange : Colors.red,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _isOnline ? Icons.wifi :
                     _hasOfflinePin ? Icons.wifi_off : Icons.signal_wifi_off,
                    color: _isOnline ? Colors.green :
                            _hasOfflinePin ? Colors.orange : Colors.red,
                    size: 16,
                  ),
                  Gap(8),
                  Expanded(
                    child: Text(
                      _connectionStatus,
                      style: TextStyle(
                        fontSize: 12,
                        color: _isOnline ? Colors.green.shade700 :
                                _hasOfflinePin ? Colors.orange.shade700 : Colors.red.shade700,
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
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: _getErrorColor(_errorType)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: _getErrorColor(_errorType)),
                ),
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
                  color: _getErrorColor(_errorType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: _getErrorColor(_errorType).withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _getErrorIcon(_errorType),
                       color: _getErrorColor(_errorType),
                       size: 16
                    ),
                    Gap(8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: _getErrorColor(_errorType).withOpacity(0.8),
                           fontSize: 12
                        ),
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
// import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
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
//   String? _errorType;
//   bool _isOnline = false;
//   String _connectionStatus = 'Checking connection...';
//   bool _hasOfflinePin = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkConnectionStatus();
//   }

//   Future<void> _checkConnectionStatus() async {
//     final isConnected = await InternetUtils.isConnected();
//     final provider = context.read<SelectAttendantProvider>();
//     final hasOfflinePin = await provider.hasOfflinePin(widget.attendant.apiId);
        
//     setState(() {
//       _isOnline = isConnected;
//       _hasOfflinePin = hasOfflinePin;
      
//       if (isConnected && hasOfflinePin) {
//         _connectionStatus = 'Online - PIN can be verified offline or online';
//       } else if (isConnected) {
//         _connectionStatus = 'Online - PIN will be verified online';
//       } else if (hasOfflinePin) {
//         _connectionStatus = 'Offline - PIN will be verified offline';
//       } else {
//         _connectionStatus = 'Offline - No offline PIN available';
//       }
//     });
//   }

//   String _getErrorMessage(String? errorType, String defaultMessage) {
//     switch (errorType) {
//       case 'INVALID_INPUT':
//         return 'PIN cannot be empty';
//       case 'INVALID_FORMAT':
//         return 'PIN must be exactly 6 digits (numbers only)';
//       case 'INVALID_PIN_OFFLINE':
//         return 'Invalid PIN entered (verified offline)';
//       case 'INVALID_PIN_ONLINE':
//         return 'Invalid PIN entered (verified online)';
//       case 'NO_OFFLINE_PIN_NO_INTERNET':
//         return 'No internet connection and no offline PIN available.\nPlease connect to internet to verify PIN.';
//       case 'NETWORK_ERROR':
//         return 'Network error occurred. Please check your connection and try again.';
//       case 'AUTH_ERROR':
//         return 'Authentication failed. Please login again.';
//       case 'USER_NOT_FOUND':
//         return 'Attendant not found on server. Please contact administrator.';
//       case 'SERVER_ERROR':
//         return 'Invalid Pin, please input the correct pin and try again later.';
//       case 'SYSTEM_ERROR':
//         return 'System error occurred. Please try again or contact support.';
//       case 'UNKNOWN_ERROR':
//         return 'Unable to verify PIN. Please try again.';
//       default:
//         return defaultMessage;
//     }
//   }

//   Color _getErrorColor(String? errorType) {
//     switch (errorType) {
//       case 'INVALID_INPUT':
//       case 'INVALID_FORMAT':
//         return Colors.orange;
//       case 'INVALID_PIN_OFFLINE':
//       case 'INVALID_PIN_ONLINE':
//         return Colors.red;
//       case 'NO_OFFLINE_PIN_NO_INTERNET':
//         return Colors.blue;
//       case 'NETWORK_ERROR':
//       case 'AUTH_ERROR':
//       case 'SERVER_ERROR':
//         return Colors.red;
//       case 'USER_NOT_FOUND':
//         return Colors.purple;
//       case 'SYSTEM_ERROR':
//       case 'UNKNOWN_ERROR':
//         return Colors.grey;
//       default:
//         return Colors.red;
//     }
//   }

//   IconData _getErrorIcon(String? errorType) {
//     switch (errorType) {
//       case 'INVALID_INPUT':
//       case 'INVALID_FORMAT':
//         return Icons.warning_outlined;
//       case 'INVALID_PIN_OFFLINE':
//       case 'INVALID_PIN_ONLINE':
//         return Icons.lock_outlined;
//       case 'NO_OFFLINE_PIN_NO_INTERNET':
//         return Icons.wifi_off_outlined;
//       case 'NETWORK_ERROR':
//         return Icons.signal_wifi_connected_no_internet_4_outlined;
//       case 'AUTH_ERROR':
//         return Icons.account_circle_outlined;
//       case 'SERVER_ERROR':
//         return Icons.error_outline_rounded;
//       case 'USER_NOT_FOUND':
//         return Icons.person_off_outlined;
//       case 'SYSTEM_ERROR':
//       case 'UNKNOWN_ERROR':
//         return Icons.error_outline;
//       default:
//         return Icons.error_outline;
//     }
//   }

//   void _verifyPin() async {
//     // Clear previous errors
//     setState(() {
//       _errorMessage = null;
//       _errorType = null;
//     });

//     // Basic client-side validation
//     final pin = _pinController.text.trim();
//     if (pin.isEmpty) {
//       setState(() {
//         _errorMessage = 'PIN cannot be empty';
//         _errorType = 'INVALID_INPUT';
//       });
//       return;
//     }

//     if (pin.length != 6) {
//       setState(() {
//         _errorMessage = 'PIN must be exactly 6 digits';
//         _errorType = 'INVALID_FORMAT';
//       });
//       return;
//     }

//     if (!RegExp(r'^\d+$').hasMatch(pin)) {
//       setState(() {
//         _errorMessage = 'PIN must contain only numbers';
//         _errorType = 'INVALID_FORMAT';
//       });
//       return;
//     }

//     setState(() {
//       _isVerifying = true;
//     });

//     try {
//       final response = await context.read<SelectAttendantProvider>().verifyPin(widget.attendant.apiId, pin);
      
//       setState(() {
//         _isVerifying = false;
//         if (!response['success']) {
//           _errorMessage = _getErrorMessage(response['errorType'], response['message'] ?? 'Invalid PIN');
//           _errorType = response['errorType'];
//         }
//       });

//       // Show verification method in snackbar for successful verifications
//       if (response['success']) {
//         final verificationMethod = response['isOffline'] == true ? 'offline' : 'online';
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('PIN verified successfully ($verificationMethod)'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }

//       widget.onPinVerified(response['success']);
//       if (response['success']) {
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       setState(() {
//         _isVerifying = false;
//         _errorMessage = 'System error occurred during PIN verification. Please try again.';
//         _errorType = 'SYSTEM_ERROR';
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
//             // Connection status indicator
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: _isOnline ? Colors.green.shade50 : 
//                        _hasOfflinePin ? Colors.orange.shade50 : Colors.red.shade50,
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border.all(
//                   color: _isOnline ? Colors.green : 
//                          _hasOfflinePin ? Colors.orange : Colors.red,
//                   width: 1,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     _isOnline ? Icons.wifi : 
//                     _hasOfflinePin ? Icons.wifi_off : Icons.signal_wifi_off,
//                     color: _isOnline ? Colors.green : 
//                            _hasOfflinePin ? Colors.orange : Colors.red,
//                     size: 16,
//                   ),
//                   Gap(8),
//                   Expanded(
//                     child: Text(
//                       _connectionStatus,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: _isOnline ? Colors.green.shade700 : 
//                                _hasOfflinePin ? Colors.orange.shade700 : Colors.red.shade700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Gap(15),
//             const Text('Enter PIN'),
//             Gap(10),
//             TextField(
//               controller: _pinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: 'Enter 6-digit PIN',
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
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: _getErrorColor(_errorType)),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: _getErrorColor(_errorType)),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: _checkConnectionStatus,
//                   tooltip: 'Refresh connection status',
//                 ),
//               ),
//               onSubmitted: (_) => _verifyPin(),
//             ),
//             if (_errorMessage != null) ...[
//               Gap(10),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: _getErrorColor(_errorType).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: _getErrorColor(_errorType).withOpacity(0.3)),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(
//                       _getErrorIcon(_errorType), 
//                       color: _getErrorColor(_errorType), 
//                       size: 16
//                     ),
//                     Gap(8),
//                     Expanded(
//                       child: Text(
//                         _errorMessage!,
//                         style: TextStyle(
//                           color: _getErrorColor(_errorType).withOpacity(0.8), 
//                           fontSize: 12
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
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