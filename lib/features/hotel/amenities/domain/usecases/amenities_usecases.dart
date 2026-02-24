// import '../../data/local/app_database.dart';
// import '../../domain/entities/amenity_entity.dart';
// import 'package:flutter/material.dart';

// class AmenitiesUseCases {
//   final AppDatabase db;

//   AmenitiesUseCases(this.db);

//   Future<List<AmenityEntity>> getAllAmenities() async {
//     final rows = await db.getAllAmenities();
//     return rows.map((e) => AmenityEntity(
//       id: e.id,
//       name: e.name,
//       description: e.description,
//       icon: _iconFromString(e.icon),
//       status: e.status,
//     )).toList();
//   }

//   Stream<List<AmenityEntity>> watchAmenities() {
//     return db.watchAllAmenities().map((rows) => rows.map((e) => AmenityEntity(
//       id: e.id,
//       name: e.name,
//       description: e.description,
//       icon: _iconFromString(e.icon),
//       status: e.status,
//     )).toList());
//   }

//   Future<void> addAmenity(AmenityEntity amenity) async {
//     await db.insertAmenity(AmenitiesTableCompanion.insert(
//       name: amenity.name,
//       description: amenity.description,
//       icon: _iconToString(amenity.icon),
//       status: amenity.status,
//     ));
//   }

//   Future<void> updateAmenity(AmenityEntity amenity) async {
//     await db.updateAmenity(
//       AmenitiesTableData(
//         id: amenity.id!,
//         name: amenity.name,
//         description: amenity.description,
//         icon: _iconToString(amenity.icon),
//         status: amenity.status,
//       ),
//     );
//   }

//   Future<void> deleteAmenity(int id) async => await db.deleteAmenity(id);

//   IconData _iconFromString(String name) {
//     switch (name) {
//       case 'Icons.bed': return Icons.bed;
//       case 'Icons.tv': return Icons.tv;
//       case 'Icons.wifi': return Icons.wifi;
//       case 'Icons.ac_unit': return Icons.ac_unit;
//       default: return Icons.star;
//     }
//   }

//   String _iconToString(IconData icon) {
//     if (icon == Icons.bed) return 'Icons.bed';
//     if (icon == Icons.tv) return 'Icons.tv';
//     if (icon == Icons.wifi) return 'Icons.wifi';
//     if (icon == Icons.ac_unit) return 'Icons.ac_unit';
//     return 'Icons.star';
//   }
// }
