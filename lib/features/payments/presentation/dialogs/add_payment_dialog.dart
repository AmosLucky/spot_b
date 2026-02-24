import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/payment_entity.dart';
import '../providers/payment_providers.dart';

class AddPaymentDialog extends ConsumerStatefulWidget {
  final int bookingId;
  const AddPaymentDialog({super.key, required this.bookingId});

  @override
  ConsumerState<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends ConsumerState<AddPaymentDialog> {

  final amount = TextEditingController();
  final tax = TextEditingController(text: "0");
  final desc = TextEditingController();
  String method = "Cash";

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Add Payment"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextField(controller: amount, decoration: const InputDecoration(labelText: "Amount")),
          TextField(controller: tax, decoration: const InputDecoration(labelText: "Tax")),
          TextField(controller: desc, decoration: const InputDecoration(labelText: "Description")),

          DropdownButton<String>(
            value: method,
            items: ["Cash","Transfer","POS","Card"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v)=> setState(()=>method=v!),
          )
        ],
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          child: const Text("Save"),
          onPressed: () async {

            await ref.read(paymentControllerProvider.notifier).addPayment(
              PaymentEntity(
                bookingId: widget.bookingId,
                amount: double.parse(amount.text),
                tax: double.parse(tax.text),
                paymentMethod: method,
                description: desc.text,
                date: DateTime.now(),
                userId: 1,
                registerId: 1,
              ),
            );

            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
