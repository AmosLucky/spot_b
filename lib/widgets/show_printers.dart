import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/objectbox.g.dart'; // ObjectBox package

// Function to open printer selection dialog

typedef PrinterCallback = void Function(String printerName);

void showPrinterSelectionDialog(
    BuildContext context,
    List<String> printers,
    Box<StoreX> printerBox,
    PrinterCallback nextAction,
    UserDetails user,
    String? btnText) {
  String? selectedPrinter = printers.isNotEmpty ? printers[0] : null;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Select Printer'),
            content: SingleChildScrollView(
              child: Column(
                children: printers.map((printer) {
                  return RadioListTile<String>(
                    title: Text(printer),
                    value: printer,
                    groupValue: selectedPrinter,
                    onChanged: (String? value) {
                      // Update the selected printer using the internal setState of StatefulBuilder
                      setState(() {
                        selectedPrinter = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(btnText != null ? btnText : 'Print Now'),
                onPressed: () {
                  if (selectedPrinter != null) {
                    // Save selected printer and close the dialog
                    savePrinterToObjectBox(
                        printerBox, selectedPrinter!, nextAction, user);
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    print("No printer selected");
                  }
                },
              ),
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog without saving
                },
              ),
            ],
          );
        },
      );
    },
  );
}

void savePrinterToObjectBox(Box<StoreX> printerBox, String selectedPrinter,
    PrinterCallback nextAction, UserDetails user) {
  StoreX printers = StoreX(
    name: "printers",
    value: selectedPrinter,
    billerId: user.id.toString(),
    companyId: user.company!.id.toString(),
    lastUpdated: DateTime.now().toIso8601String(),
  );

  // Check if the printer record already exists
  final existingPrinter = printerBox
      .query(StoreX_.billerId
          .equals(user.id.toString())
          .and(StoreX_.name.equals("printers")))
      .build()
      .findFirst();

  if (existingPrinter != null) {
    // Record exists, update it
    printers.id = existingPrinter.id; // Ensure it has the same ID for updating
    printerBox.put(printers);
  } else {
    // Record does not exist, insert new
    printerBox.put(printers);
  }

  // Proceed with the next action
  nextAction(selectedPrinter);

  print('Printer saved: $selectedPrinter');
}
