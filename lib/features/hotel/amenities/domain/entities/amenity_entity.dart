import 'package:flutter/material.dart';

class AmenityEntity {
  final int? id;
  final String name;
  final String description;
  final IconData icon;
  final String status;

  AmenityEntity({
    this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.status,
  });
}
