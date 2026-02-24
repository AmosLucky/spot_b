// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../amenities/presentation/providers/amenities_provider.dart';
// import '../../../bed_type/presentation/providers/bed_types_provider.dart';
// import '../../../facilities/presentation/providers/facilities_provider.dart';
// import '../../domain/entities/room_type_entities.dart';
// import '../providers/room_type_provider.dart';

// class RoomTypesPage extends ConsumerStatefulWidget {
//   const RoomTypesPage({super.key});

//   @override
//   ConsumerState<RoomTypesPage> createState() => _RoomTypesPageState();
// }

// class _RoomTypesPageState extends ConsumerState<RoomTypesPage> {
//   final searchController = TextEditingController();

//   void showRoomTypeDialog({RoomTypeEntity? roomType}) {
//     final nameCtrl = TextEditingController(text: roomType?.name ?? '');
//     final totalAdultsCtrl =
//         TextEditingController(text: roomType?.totalAdults.toString() ?? '1');
//     final totalChildrenCtrl =
//         TextEditingController(text: roomType?.totalChildren.toString() ?? '0');
//     final fareCtrl =
//         TextEditingController(text: roomType?.fare.toString() ?? '0');

//     final state = ref.read(roomTypeControllerProvider);
//     final amenities = ref.read(amenitiesControllerProvider).amenities;
//     final facilities = ref.read(facilitiesControllerProvider).facilities;
//     final bedTypes = ref.read(bedTypesControllerProvider).bedTypes;

//     List<int> selectedAmenityIds =
//         roomType?.amenityIds.toList() ?? <int>[];
//     List<int> selectedFacilityIds =
//         roomType?.facilityIds.toList() ?? <int>[];
//     List<int> selectedBedTypeIds =
//         roomType?.bedTypeIds.toList() ?? <int>[];

//     showDialog(
//       context: context,
//       builder: (_) => StatefulBuilder(
//         builder: (context, setDialogState) => AlertDialog(
//           title: Text(roomType == null ? 'Add Room Type' : 'Edit Room Type'),
//           content: SizedBox(
//             width: 400,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     controller: nameCtrl,
//                     decoration: const InputDecoration(labelText: 'Room Name'),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: totalAdultsCtrl,
//                     decoration:
//                         const InputDecoration(labelText: 'Total Adults'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: totalChildrenCtrl,
//                     decoration:
//                         const InputDecoration(labelText: 'Total Children'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: fareCtrl,
//                     decoration: const InputDecoration(labelText: 'Fare'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Amenities'),
//                   Wrap(
//                     spacing: 8,
//                     children: amenities.map<Widget>((a) {
//                       final selected = selectedAmenityIds.contains(a.id);
//                       return FilterChip(
//                         label: Text(a.name),
//                         selected: selected,
//                         onSelected: (val) {
//                           setDialogState(() {
//                             if (val) {
//                               selectedAmenityIds.add(a.id!);
//                             } else {
//                               selectedAmenityIds.remove(a.id);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Facilities'),
//                   Wrap(
//                     spacing: 8,
//                     children: facilities.map<Widget>((f) {
//                       final selected = selectedFacilityIds.contains(f.id);
//                       return FilterChip(
//                         label: Text(f.name),
//                         selected: selected,
//                         onSelected: (val) {
//                           setDialogState(() {
//                             if (val) {
//                               selectedFacilityIds.add(f.id!);
//                             } else {
//                               selectedFacilityIds.remove(f.id);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Bed Types'),
//                   Wrap(
//                     spacing: 8,
//                     children: bedTypes.map<Widget>((b) {
//                       final selected = selectedBedTypeIds.contains(b.id);
//                       return FilterChip(
//                         label: Text(b.name),
//                         selected: selected,
//                         onSelected: (val) {
//                           setDialogState(() {
//                             if (val) {
//                               selectedBedTypeIds.add(b.id!);
//                             } else {
//                               selectedBedTypeIds.remove(b.id);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel')),
//             ElevatedButton(
//               onPressed: () async {
//                 final controller =
//                     ref.read(roomTypeControllerProvider.notifier);

//                 final room = RoomTypeEntity(
//                   id: roomType?.id,
//                   name: nameCtrl.text,
//                   totalAdults: int.tryParse(totalAdultsCtrl.text) ?? 1,
//                   totalChildren: int.tryParse(totalChildrenCtrl.text) ?? 0,
//                   totalBeds:
//                       (int.tryParse(totalAdultsCtrl.text) ?? 1) +
//                           (int.tryParse(totalChildrenCtrl.text) ?? 0),
//                   fare: double.tryParse(fareCtrl.text) ?? 0,
//                   keywords: '',
//                   description: '',
//                   cancellationFee: 0,
//                   cancellationPolicy: '',
//                   amenityIds: selectedAmenityIds,
//                   facilityIds: selectedFacilityIds,
//                   bedTypeIds: selectedBedTypeIds,
//                   isActive: true,
//                 );

//                 if (roomType == null) {
//                   await controller.addRoomType(room);
//                 } else {
//                   await controller.updateRoomType(room);
//                 }

//                 Navigator.pop(context);
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showDeleteDialog(RoomTypeEntity roomType) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Delete Room Type'),
//         content: const Text('Are you sure you want to delete this room type?'),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel')),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent),
//               onPressed: () async {
//                 final controller = ref.read(roomTypeControllerProvider.notifier);
//                 await controller.deleteRoomType(roomType.id!);
//                 Navigator.pop(context);
//               },
//               child: const Text('Delete')),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(roomTypeControllerProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Room Types'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => showRoomTypeDialog(),
//           )
//         ],
//       ),
//       body: state.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: searchController,
//                     decoration: const InputDecoration(
//                       hintText: 'Search room types...',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(),
//                     ),
//                     // onChanged: (value) => ref
//                     //     .read(roomTypeControllerProvider.notifier)
//                     //     .searchRoomType(value),
//                   ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: state.roomTypes.length,
//                       itemBuilder: (context, index) {
//                         final room = state.roomTypes[index];
//                         return ListTile(
//                           title: Text(room.name),
//                           subtitle: Text(
//                               'Adults: ${room.totalAdults}, Children: ${room.totalChildren}, Fare: ${room.fare}'),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.edit,
//                                     color: Colors.blue),
//                                 onPressed: () =>
//                                     showRoomTypeDialog(roomType: room),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete,
//                                     color: Colors.red),
//                                 onPressed: () => showDeleteDialog(room),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }












































// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:spotstock_inventory/features/hotel/amenities/presentation/providers/amenities_provider.dart';
// import 'package:spotstock_inventory/features/hotel/bed_type/presentation/providers/bed_types_provider.dart';
// import 'package:spotstock_inventory/features/hotel/facilities/presentation/providers/facilities_provider.dart';
// import '../../../../../../core/constants/colors/spotstock_colors.dart';
// import '../../domain/entities/room_type_entities.dart';
// import '../providers/room_type_provider.dart';

// class RoomTypesPage extends ConsumerStatefulWidget {
//   const RoomTypesPage({super.key});

//   @override
//   ConsumerState<RoomTypesPage> createState() => _RoomTypesPageState();
// }

// class _RoomTypesPageState extends ConsumerState<RoomTypesPage> {
//   final searchController = TextEditingController();

//   void showRoomTypeDialog({RoomTypeEntity? roomType}) {
//     final nameCtrl = TextEditingController(text: roomType?.name ?? '');
//     final adultsCtrl =
//         TextEditingController(text: roomType?.totalAdults.toString() ?? '1');
//     final childrenCtrl =
//         TextEditingController(text: roomType?.totalChildren.toString() ?? '0');
//     final fareCtrl =
//         TextEditingController(text: roomType?.fare.toString() ?? '0');

//     final state = ref.read(roomTypeControllerProvider);
//     final amenities = ref.read(amenitiesControllerProvider).amenities;
//     final facilities = ref.read(facilitiesControllerProvider).facilities;
//     final bedTypes = ref.read(bedTypesControllerProvider).bedTypes;

//     List<int> selectedAmenityIds = roomType?.amenityIds.toList() ?? [];
//     List<int> selectedFacilityIds = roomType?.facilityIds.toList() ?? [];
//     List<int> selectedBedTypeIds = roomType?.bedTypeIds.toList() ?? [];

//     showDialog(
//       context: context,
//       builder: (_) => StatefulBuilder(
//         builder: (context, setDialogState) => AlertDialog(
//           title: Text(roomType == null ? 'Add Room Type' : 'Edit Room Type'),
//           content: SizedBox(
//             width: 400,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     controller: nameCtrl,
//                     decoration: const InputDecoration(labelText: 'Room Name'),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: adultsCtrl,
//                     decoration:
//                         const InputDecoration(labelText: 'Total Adults'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: childrenCtrl,
//                     decoration:
//                         const InputDecoration(labelText: 'Total Children'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: fareCtrl,
//                     decoration: const InputDecoration(labelText: 'Fare'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Amenities'),
//                   Wrap(
//                     spacing: 8,
//                     children: amenities.map<Widget>((a) {
//                       final selected = selectedAmenityIds.contains(a.id);
//                       return FilterChip(
//                         label: Text(a.name),
//                         selected: selected,
//                         onSelected: (val) {
//                           setDialogState(() {
//                             if (val) {
//                               selectedAmenityIds.add(a.id!);
//                             } else {
//                               selectedAmenityIds.remove(a.id);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Facilities'),
//                   Wrap(
//                     spacing: 8,
//                     children: facilities.map<Widget>((f) {
//                       final selected = selectedFacilityIds.contains(f.id);
//                       return FilterChip(
//                         label: Text(f.name),
//                         selected: selected,
//                         onSelected: (val) {
//                           setDialogState(() {
//                             if (val) {
//                               selectedFacilityIds.add(f.id!);
//                             } else {
//                               selectedFacilityIds.remove(f.id);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Bed Types'),
//                   Wrap(
//                     spacing: 8,
//                     children: bedTypes.map<Widget>((b) {
//                       final selected = selectedBedTypeIds.contains(b.id);
//                       return FilterChip(
//                         label: Text(b.name),
//                         selected: selected,
//                         onSelected: (val) {
//                           setDialogState(() {
//                             if (val) {
//                               selectedBedTypeIds.add(b.id!);
//                             } else {
//                               selectedBedTypeIds.remove(b.id);
//                             }
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel')),
//             ElevatedButton(
//                 onPressed: () async {
//                   final controller =
//                       ref.read(roomTypeControllerProvider.notifier);
//                   final room = RoomTypeEntity(
//                     id: roomType?.id,
//                     name: nameCtrl.text,
//                     totalAdults: int.tryParse(adultsCtrl.text) ?? 1,
//                     totalChildren: int.tryParse(childrenCtrl.text) ?? 0,
//                     totalBeds: (int.tryParse(adultsCtrl.text) ?? 1) +
//                         (int.tryParse(childrenCtrl.text) ?? 0),
//                     fare: double.tryParse(fareCtrl.text) ?? 0,
//                     keywords: '',
//                     description: '',
//                     cancellationFee: 0,
//                     cancellationPolicy: '',
//                     amenityIds: selectedAmenityIds,
//                     facilityIds: selectedFacilityIds,
//                     bedTypeIds: selectedBedTypeIds,
//                     isActive: true,
//                   );

//                   if (roomType == null) {
//                     await controller.addRoomType(room);
//                   } else {
//                     await controller.updateRoomType(room);
//                   }

//                   Navigator.pop(context);
//                 },
//                 child: const Text('Save')),
//           ],
//         ),
//       ),
//     );
//   }

//   void showDeleteDialog(RoomTypeEntity roomType) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Delete Room Type'),
//         content: const Text('Are you sure you want to delete this room type?'),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel')),
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: SpotstockColors.red),
//               onPressed: () {
//                 ref
//                     .read(roomTypeControllerProvider.notifier)
//                     .deleteRoomType(roomType.id!);
//                 Navigator.pop(context);
//               },
//               child: const Text('Delete')),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(roomTypeControllerProvider);
//     final roomTypes = state.roomTypes;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// HEADER
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Room Types',
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 ElevatedButton.icon(
//                   onPressed: () => showRoomTypeDialog(),
//                   icon: const Icon(Icons.add),
//                   label: const Text('Add Room Type'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             /// SEARCH
//             TextField(
//               controller: searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search room types...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) => ref
//                   .read(roomTypeControllerProvider.notifier)
//                   .searchRoomType(value),
//             ),
//             const SizedBox(height: 20),

//             /// TABLE
//             Expanded(
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//                 child: state.isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : ListView.separated(
//                         itemCount: roomTypes.length,
//                         separatorBuilder: (_, __) => const Divider(height: 1),
//                         itemBuilder: (context, index) {
//                           final room = roomTypes[index];
//                           return ListTile(
//                             title: Text(room.name),
//                             subtitle: Text(
//                                 'Adults: ${room.totalAdults}, Children: ${room.totalChildren}, Fare: ${room.fare}'),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.edit,
//                                       color: SpotstockColors.blue),
//                                   onPressed: () =>
//                                       showRoomTypeDialog(roomType: room),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete,
//                                       color: SpotstockColors.red),
//                                   onPressed: () => showDeleteDialog(room),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/entities/room_type_entities.dart';
// import '../../domain/usecases/Deleteroom_type_use_case.dart';
// import '../../domain/usecases/add_room_type_use_case.dart';
// import '../../domain/usecases/get_room_types_use_case.dart';
// import '../../domain/usecases/update_room_type_usecase.dart';
// import '../state/room_type_state.dart';


// class RoomTypeController extends StateNotifier<RoomTypeState> {
//   final GetRoomTypesUseCase getUseCase;
//   final AddRoomTypeUseCase addUseCase;
//   final UpdateRoomTypeUseCase updateUseCase;
//   final DeleteRoomTypeUseCase deleteUseCase;

//   RoomTypeController({
//     required this.getUseCase,
//     required this.addUseCase,
//     required this.updateUseCase,
//     required this.deleteUseCase,
//   }) : super(RoomTypeState.initial()) {
//     loadRoomTypes();
//   }

//   List<RoomTypeEntity> _allRoomTypes = [];

//   // ---------------- Load ----------------

//   Future<void> loadRoomTypes() async {
//     state = state.copyWith(isLoading: true);
//     final list = await getUseCase.call();
//     _allRoomTypes = list;
//     state = state.copyWith(roomTypes: list, isLoading: false);
//   }

//   // ---------------- CRUD ----------------

//   Future<void> addRoomType(RoomTypeEntity entity) async {
//     await addUseCase.call(entity);
//     resetForm();
//     loadRoomTypes();
//   }

//   Future<void> updateRoomType(RoomTypeEntity entity) async {
//     await updateUseCase.call(entity);
//     resetForm();
//     loadRoomTypes();
//   }

//   Future<void> deleteRoomType(int id) async {
//     await deleteUseCase.call(id);
//     loadRoomTypes();
//   }

//   // ---------------- Form ----------------

//   void toggleAmenity(int id) {
//     final list = [...state.selectedAmenityIds];
//     list.contains(id) ? list.remove(id) : list.add(id);
//     state = state.copyWith(selectedAmenityIds: list);
//   }

//   void toggleFacility(int id) {
//     final list = [...state.selectedFacilityIds];
//     list.contains(id) ? list.remove(id) : list.add(id);
//     state = state.copyWith(selectedFacilityIds: list);
//   }

//   void toggleBedType(int id) {
//     final list = [...state.selectedBedTypeIds];
//     list.contains(id) ? list.remove(id) : list.add(id);
//     state = state.copyWith(selectedBedTypeIds: list);
//   }

//   void changeStatus(String status) {
//     state = state.copyWith(status: status);
//   }

//   void resetForm() {
//     state = state.copyWith(
//       status: 'Active',
//       selectedAmenityIds: [],
//       selectedFacilityIds: [],
//       selectedBedTypeIds: [],
//     );
//   }
// }























// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:spotstock_inventory/core/database/tables/amenities_table.dart';
// import 'package:spotstock_inventory/features/hotel/facilities/domain/entities/facility_entity.dart';

// import '../../../amenities/domain/entities/amenity_entity.dart';
// import '../../../bed_type/domain/entities/bed_type.dart';
// import '../../domain/entities/room_type_entities.dart';
// import '../../domain/usecases/Deleteroom_type_use_case.dart';
// import '../../domain/usecases/add_room_type_use_case.dart';
// import '../../domain/usecases/get_room_types_use_case.dart';
// import '../../domain/usecases/update_room_type_usecase.dart';
// import '../state/room_type_state.dart';

// class RoomTypeController extends StateNotifier<RoomTypeState> {
//   final GetRoomTypesUseCase getUseCase;
//   final AddRoomTypeUseCase addUseCase;
//   final UpdateRoomTypeUseCase updateUseCase;
//   final DeleteRoomTypeUseCase deleteUseCase;

//   RoomTypeController({
//     required this.getUseCase,
//     required this.addUseCase,
//     required this.updateUseCase,
//     required this.deleteUseCase,
//   }) : super(RoomTypeState.initial()) {
//     loadRoomTypes();
//   }

//   List<RoomTypeEntity> _allRoomTypes = [];

//   // MOCK: replace with actual providers or useCases to fetch
//   List<AmenityEntity> allAmenities = [];
//   List<FacilityEntity> allFacilities = [];
//   List<BedType> allBedTypes = [];

//   // ---------------- Load ----------------
//   Future<void> loadRoomTypes() async {
//     state = state.copyWith(isLoading: true);
//     final list = await getUseCase.call();
//     _allRoomTypes = list;
//     state = state.copyWith(roomTypes: list, isLoading: false);
//   }

//   // ---------------- CRUD ----------------
//   Future<void> addRoomType(RoomTypeEntity entity) async {
//     await addUseCase.call(entity);
//     resetForm();
//     loadRoomTypes();
//   }

//   Future<void> updateRoomType(RoomTypeEntity entity) async {
//     await updateUseCase.call(entity);
//     resetForm();
//     loadRoomTypes();
//   }

//   Future<void> deleteRoomType(int id) async {
//     await deleteUseCase.call(id);
//     loadRoomTypes();
//   }

//   // ---------------- SEARCH ----------------
//   void searchRoomType(String query) {
//     final filtered = _allRoomTypes
//         .where((r) => r.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     state = state.copyWith(roomTypes: filtered);
//   }

//   // ---------------- Form ----------------
//   void toggleAmenity(int id) {
//     final list = [...state.selectedAmenityIds];
//     list.contains(id) ? list.remove(id) : list.add(id);
//     state = state.copyWith(selectedAmenityIds: list);
//   }

//   void toggleFacility(int id) {
//     final list = [...state.selectedFacilityIds];
//     list.contains(id) ? list.remove(id) : list.add(id);
//     state = state.copyWith(selectedFacilityIds: list);
//   }

//   void toggleBedType(int id) {
//     final list = [...state.selectedBedTypeIds];
//     list.contains(id) ? list.remove(id) : list.add(id);
//     state = state.copyWith(selectedBedTypeIds: list);
//   }

//   void resetForm() {
//     state = state.copyWith(
//       selectedAmenityIds: [],
//       selectedFacilityIds: [],
//       selectedBedTypeIds: [],
//     );
//   }
// }

