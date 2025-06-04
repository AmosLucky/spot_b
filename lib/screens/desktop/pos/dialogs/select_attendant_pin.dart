import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';

import '../../model/select_attendant_model.dart';
// import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_model.dart';

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
  bool _isPinIncorrect = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _verifyPin() {
    final enteredPin = _pinController.text;
    final isVerified = enteredPin == widget.attendant.pin;
    
    if (isVerified) {
      widget.onPinVerified(true);
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isPinIncorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Verify PIN for ${widget.attendant.fullName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _pinController,
            decoration: InputDecoration(
              labelText: 'Enter PIN',
              errorText: _isPinIncorrect ? 'Incorrect PIN' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            keyboardType: TextInputType.number,
            obscureText: true,
          ),
          Gap(10),
        ],
      ),
      actions: [
//  highlighter
        TextButton(
          onPressed: () {
            widget.onPinVerified(false);
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _verifyPin,
          child: const Text('Verify'),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// // import 'package:provider/provider.dart';
// // import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// // import 'package:spotstock_inventory/common/provider/attendant_model.dart';

// import '../../model/select_attendant_model.dart';
// // import 'package:spotstock_inventory/common/provider/attendant_provider.dart';

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
//   bool _isPinIncorrect = false;

//   @override
//   void dispose() {
//     _pinController.dispose();
//     super.dispose();
//   }

//   void _verifyPin() {
//     final enteredPin = _pinController.text;
//     final isVerified = enteredPin == widget.attendant.pin;
    
//     if (isVerified) {
//       widget.onPinVerified(true);
//       Navigator.of(context).pop();
//     } else {
//       setState(() {
//         _isPinIncorrect = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Verify PIN for ${widget.attendant.fullName}'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _pinController,
//             decoration: InputDecoration(
//               labelText: 'Enter PIN',
//               errorText: _isPinIncorrect ? 'Incorrect PIN' : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//             keyboardType: TextInputType.number,
//             obscureText: true,
//           ),
//           Gap(10),
//         ],
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
//           onPressed: _verifyPin,
//           child: const Text('Verify'),
//         ),
//       ],
//     );
//   }
// }