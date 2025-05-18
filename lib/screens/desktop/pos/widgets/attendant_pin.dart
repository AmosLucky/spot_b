import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/attendant_model.dart';

class AttendantPinDialog extends StatefulWidget {
  final AttendantModel attendant;
  final Function(bool) onPinVerified;

  const AttendantPinDialog({
    super.key,
    required this.attendant,
    required this.onPinVerified,
  });

  @override
  State<AttendantPinDialog> createState() => _AttendantPinDialogState();
}

class _AttendantPinDialogState extends State<AttendantPinDialog> {
  final TextEditingController _pinController = TextEditingController();
  bool _isVerifying = false;
  bool _isObscured = true;
  String _errorMessage = '';

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _verifyPin() async {
    if (_pinController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your PIN';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = '';
    });

    try {
      final attendantProvider = context.read<AttendantProvider>();
      final isValid = await attendantProvider.verifyAttendantPin(_pinController.text);

      setState(() {
        _isVerifying = false;
      });

      if (isValid) {
        Navigator.of(context).pop();
        widget.onPinVerified(true);
      } else {
        setState(() {
          _errorMessage = 'Invalid PIN. Please try again.';
        });
        _pinController.clear();
      }
    } catch (e) {
      setState(() {
        _isVerifying = false;
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter Attendant PIN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onPinVerified(false);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Message
            Text(
              'Please enter your PIN to continue, ${widget.attendant.name}.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 30),

            // PIN input field
            TextField(
              controller: _pinController,
              obscureText: _isObscured,
              keyboardType: TextInputType.number,
              maxLength: 6, // Assuming max 6 digit PIN
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: 'Enter PIN',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: _errorMessage.isEmpty ? null : _errorMessage,
              ),
              onSubmitted: (_) => _verifyPin(),
            ),
            const SizedBox(height: 30),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isVerifying ? null : () {
                    Navigator.of(context).pop();
                    widget.onPinVerified(false);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isVerifying ? null : _verifyPin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF473069),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isVerifying
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}