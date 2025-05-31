import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';

class DatabaseCheckScreen extends StatefulWidget {
  final Function onRetry; // Accept a retry function as a parameter

  const DatabaseCheckScreen({required this.onRetry, super.key});

  @override
  _DatabaseCheckScreenState createState() => _DatabaseCheckScreenState();
}

class _DatabaseCheckScreenState extends State<DatabaseCheckScreen> {
  bool _isError = false; // Track whether an error occurred

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF2FCFE), // #F2FCFE
              Color(0xFFFAF1FE), // #FAF1FE
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: _isError
              ? _buildErrorContent(context) // Show error message and retry
              : CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2,
                ),
        ),
      ),
    );
  }

  // Widget to build error content with a retry button
  Widget _buildErrorContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Failed to initialize the database.",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isError = false; // Reset the error state
            });
            widget.onRetry(); // Call the retry function
          },
          child: const Text("Retry"),
        ),
      ],
    );
  }

  // Function to set the error state when database fails
  void showError() {
    setState(() {
      _isError = true; // Set the error state to true
    });
  }
}
