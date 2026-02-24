import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/payment_entity.dart';
import '../providers/payment_providers.dart';

class PaymentTile extends ConsumerWidget {
  final PaymentEntity payment;
  const PaymentTile({super.key, required this.payment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Card(
      child: ListTile(
        title: Text("₦${payment.total} • ${payment.paymentMethod}"),
        subtitle: Text(payment.description!),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            ref.read(paymentControllerProvider.notifier)
                .deletePayment(payment.id!);
          },
        ),
      ),
    );
  }
}
