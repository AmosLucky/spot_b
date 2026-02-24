import 'package:flutter/material.dart';

class FacilityEntity {
  final int? id;
  final String name;
  final IconData icon;
  final String status;

  const FacilityEntity({
    this.id,
    required this.name,
    required this.icon,
    required this.status,
  });
}
