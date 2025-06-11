import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import '../../model/select_attendant_model.dart';
import '../../providers/select_attendant_provider.dart';
// import '../providers/select_attendant_provider.dart';

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
  final String _defaultPin = '123456';

  void _verifyPin() {
    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    final inputPin = _pinController.text.trim();
    final attendantProvider = context.read<SelectAttendantProvider>();
    final isPhoneInStaffList = attendantProvider.attendants.any((staff) => staff.phone == widget.attendant.phone);
    final isValid = inputPin == _defaultPin && isPhoneInStaffList;

    setState(() {
      _isVerifying = false;
      if (!isValid) {
        _errorMessage = inputPin != _defaultPin
            ? 'Invalid PIN'
            : 'Attendant not found in staff list';
      }
    });

    widget.onPinVerified(isValid);
    if (isValid) {
      Navigator.of(context).pop();
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
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import '../../model/select_attendant_model.dart';

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
//   final TextEditingController _phoneController = TextEditingController();
//   bool _isVerifying = false;
//   String? _errorMessage;

//   void _verifyPhone() {
//     setState(() {
//       _isVerifying = true;
//       _errorMessage = null;
//     });

//     final inputPhone = _phoneController.text.trim();
//     final isValid = inputPhone == widget.attendant.phone && widget.attendant.hasPinSet;

//     setState(() {
//       _isVerifying = false;
//       if (!isValid) {
//         _errorMessage = inputPhone != widget.attendant.phone
//             ? 'Invalid PIN (phone number does not match)'
//             : 'Attendant has no PIN set';
//       }
//     });

//     widget.onPinVerified(isValid);
//     if (isValid) {
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
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
//             Text('Enter PIN (Your Phone Number)'),
//             Gap(10),
//             TextField(
//               controller: _phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 hintText: 'Enter your phone number as PIN',
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
//           onPressed: _isVerifying ? null : _verifyPhone,
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