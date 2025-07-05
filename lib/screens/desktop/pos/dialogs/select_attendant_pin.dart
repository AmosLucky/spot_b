import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
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

  void _verifyPin() async {
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
            const Text('Enter PIN'),
            Gap(10),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'Enter PIN',
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
              ),
            ),
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
// // import '../providers/select_attendant_provider.dart';

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
//   final String _defaultPin = '123456';

//   void _verifyPin() {
//     setState(() {
//       _isVerifying = true;
//       _errorMessage = null;
//     });

//     final inputPin = _pinController.text.trim();
//     final attendantProvider = context.read<SelectAttendantProvider>();
//     final isPhoneInStaffList = attendantProvider.attendants.any((staff) => staff.phone == widget.attendant.phone);
//     final isValid = inputPin == _defaultPin && isPhoneInStaffList;

//     setState(() {
//       _isVerifying = false;
//       if (!isValid) {
//         _errorMessage = inputPin != _defaultPin
//             ? 'Invalid PIN'
//             : 'Attendant not found in staff list';
//       }
//     });

//     widget.onPinVerified(isValid);
//     if (isValid) {
//       Navigator.of(context).pop();
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