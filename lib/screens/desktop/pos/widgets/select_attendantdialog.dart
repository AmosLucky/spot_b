import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_model.dart';
import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_provider.dart';
import '../../model/select_attendant_model.dart';

class SelectAttendantDialog extends StatefulWidget {
  final Function(SelectAttendantModel) onAttendantSelected;
  final SelectAttendantModel? previouslySelectedAttendant;
  const SelectAttendantDialog({
    super.key,
    required this.onAttendantSelected,
    this.previouslySelectedAttendant,
  });
  @override
  State<SelectAttendantDialog> createState() => _SelectAttendantDialogState();
}

class _SelectAttendantDialogState extends State<SelectAttendantDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelectAttendantProvider>().loadAttendants();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Attendant"),
      content: SizedBox(
        width: 400,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search Attendant'),
            Gap(3),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search attendant...',
                prefixIcon: const Icon(Icons.search),
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
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              onChanged: (value) {
                context.read<SelectAttendantProvider>().searchAttendants(value);
              },
            ),
            Gap(10),
            Expanded(
              child: Consumer<SelectAttendantProvider>(
                builder: (context, attendantProvider, child) {
                  if (attendantProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (attendantProvider.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Failed to load attendants',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          Gap(10),
                          Text(
                            attendantProvider.errorMessage!,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  if (attendantProvider.attendants.isEmpty) {
                    return const Center(
                      child: Text(
                        'No attendants available',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: attendantProvider.attendants.length,
                    itemBuilder: (context, index) {
                      final attendant = attendantProvider.attendants[index];
                      return _buildAttendantItem(context, attendant);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildAttendantItem(BuildContext context, SelectAttendantModel attendant) {
    final isSelected = widget.previouslySelectedAttendant?.id == attendant.id;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          widget.onAttendantSelected(attendant);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isSelected ? Colors.blue : ColorsRes.grey,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected ? Colors.blue.shade50 : Colors.white,
          ),
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: isSelected ? Colors.blue : ColorsRes.grey,
                size: 20,
              ),
              Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attendant.fullName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    ),
                    Gap(2),
                    Text(
                      attendant.department,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gap(2),
                    Text(
                      attendant.hasPinSet ? 'PIN set' : 'No PIN set',
                      style: TextStyle(
                        fontSize: 12,
                        color: attendant.hasPinSet ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// // import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_model.dart';
// import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_provider.dart';

// import '../../model/select_attendant_model.dart';

// class SelectAttendantDialog extends StatefulWidget {
//   final Function(SelectAttendantModel) onAttendantSelected;
//   final SelectAttendantModel? previouslySelectedAttendant;

//   const SelectAttendantDialog({
//     super.key,
//     required this.onAttendantSelected,
//     this.previouslySelectedAttendant,
//   });

//   @override
//   State<SelectAttendantDialog> createState() => _SelectAttendantDialogState();
// }

// class _SelectAttendantDialogState extends State<SelectAttendantDialog> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<SelectAttendantProvider>().loadAttendants();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Select Attendant"),
//       content: SizedBox(
//         width: 400,
//         height: MediaQuery.of(context).size.height * 0.5,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Search Attendant'),
//             Gap(3),
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search attendant...',
//                 prefixIcon: const Icon(Icons.search),
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
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               ),
//               onChanged: (value) {
//                 context.read<SelectAttendantProvider>().searchAttendants(value);
//               },
//             ),
//             Gap(10),
//             Expanded(
//               child: Consumer<SelectAttendantProvider>(
//                 builder: (context, attendantProvider, child) {
//                   if (attendantProvider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (attendantProvider.errorMessage != null) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Failed to load attendants',
//                             style: TextStyle(fontSize: 16, color: Colors.red),
//                           ),
//                           Gap(10),
//                           Text(
//                             attendantProvider.errorMessage!,
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   if (attendantProvider.attendants.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         'No attendants available',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: attendantProvider.attendants.length,
//                     itemBuilder: (context, index) {
//                       final attendant = attendantProvider.attendants[index];
//                       return _buildAttendantItem(context, attendant);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text("Cancel"),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildAttendantItem(BuildContext context, SelectAttendantModel attendant) {
//     final isSelected = widget.previouslySelectedAttendant?.id == attendant.id;
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pop();
//           widget.onAttendantSelected(attendant);
//         },
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(
//               color: isSelected ? Colors.blue : ColorsRes.grey,
//               width: isSelected ? 2 : 1,
//             ),
//             color: isSelected ? Colors.blue.shade50 : Colors.white,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.person,
//                 color: isSelected ? Colors.blue : ColorsRes.grey,
//                 size: 20,
//               ),
//               Gap(10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       attendant.fullName,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: isSelected ? Colors.blue : Colors.black,
//                       ),
//                     ),
//                     Gap(2),
//                     Text(
//                       attendant.department,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     Gap(2),
//                     Text(
//                       attendant.hasPinSet ? 'PIN set' : 'No PIN set',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: attendant.hasPinSet ? Colors.green : Colors.orange,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }