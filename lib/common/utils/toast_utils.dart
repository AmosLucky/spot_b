import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static void showSuccessToast(
      BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'sofia',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontFamily: 'sofia',
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 300),
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        linearMinHeight: 4,
      ),
      backgroundColor: const Color(0xFF4CAF50), // Success green
      foregroundColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
    );
  }

  static void showErrorToast(
      BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'sofia',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontFamily: 'sofia',
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 300),
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        linearMinHeight: 4,
      ),
      backgroundColor: const Color(0xFFE53935), // Error red
      foregroundColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
    );
  }

  static void showInfoToast(
      BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'sofia',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      description: Text(
        description,
        style: const TextStyle(
          fontFamily: 'sofia',
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 300),
      showProgressBar: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
        linearMinHeight: 4,
      ),
      backgroundColor: const Color(0xFF2196F3), // Info blue
      foregroundColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
    );
  }
}