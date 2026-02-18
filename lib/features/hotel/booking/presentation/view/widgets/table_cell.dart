


import 'package:flutter/material.dart';

class MTableCell extends StatelessWidget {
  final String text;

  const MTableCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(text),
    );
  }
}