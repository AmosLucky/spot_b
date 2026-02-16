import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../../booking_premium_service/presentation/providers/booking_premium_service_providers.dart';
import '../../../../premium_type/presentation/providers/premium_type_provider.dart';
import '../../providers/booking_history_provider.dart';
import 'table_cell.dart';
import 'table_header.dart';

class AddPremiumServiceTab extends ConsumerWidget {
  const AddPremiumServiceTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(bookingPremiumServiceFormProvider);
    final formController = ref.read(bookingPremiumServiceFormProvider.notifier);
    final booking = ref.watch(bookingHistoryControllerProvider).selectedBooking;
    final premiumState = ref.watch(premiumTypeControllerProvider);

    if (booking == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No booking selected',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    final rooms = booking.roomNumbers!.split(',').map((e) => e.trim()).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Main Form Card
            _buildFormCard(
              context,
              formState,
              formController,
              rooms,
              premiumState,
              booking,
              ref,
            ),

            const SizedBox(height: 24),

            // Existing Services Table
            _buildExistingServicesCard(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(
    BuildContext context,
    dynamic formState,
    dynamic formController,
    List<String> rooms,
    dynamic premiumState,
    dynamic booking,
    WidgetRef ref,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header

          // Form Content
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Room Selection
                _buildRoomSelection(rooms, formState, formController),

                const SizedBox(height: 32),

                // Services Section Header
                _buildSectionHeader(formState.items.length),

                const SizedBox(height: 20),

                // Service Items
                ...List.generate(formState.items.length, (index) {
                  final item = formState.items[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildServiceItem(
                      context,
                      item,
                      index,
                      formState.items.length,
                      premiumState,
                      formController,
                    ),
                  );
                }),

                const SizedBox(height: 12),

                // Add Service Button
                _buildAddServiceButton(formController),

                const SizedBox(height: 32),

                // Total Section
                _buildTotalSection(formState),

                const SizedBox(height: 28),

                // Save Button
                _buildSaveButton(context, formController, booking, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomSelection(
    List<String> rooms,
    dynamic formState,
    dynamic formController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: SpotstockColors.c473069.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.meeting_room_rounded,
                color: SpotstockColors.c473069,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Select Room',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: formState.selectedRoom,
          hint: const Text(
            "Choose room number",
            style: TextStyle(color: Colors.grey),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: SpotstockColors.c473069,
                width: 2,
              ),
            ),
          ),
          items: rooms.map((r) {
            return DropdownMenuItem(
              value: r,
              child: Row(
                children: [
                  Icon(
                    Icons.door_front_door_outlined,
                    size: 18,
                    color: SpotstockColors.c473069,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Room $r",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (v) {
            if (v != null) {
              formController.selectRoom(v);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(int itemCount) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: SpotstockColors.c473069.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.list_alt_rounded,
            color: SpotstockColors.c473069,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: SpotstockColors.c473069.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
            style: TextStyle(
              color: SpotstockColors.c473069,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem(
    BuildContext context,
    dynamic item,
    int index,
    int totalItems,
    dynamic premiumState,
    dynamic formController,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Item Header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      SpotstockColors.c473069,
                      SpotstockColors.c473069.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Service Item',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              const Spacer(),
              if (totalItems > 1)
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red[400],
                    size: 22,
                  ),
                  onPressed: () {
                    formController.removeServiceRow(index);
                  },
                  tooltip: 'Remove service',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Service Dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Service',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: item.serviceId,
                hint: const Text(
                  "Choose premium service",
                  style: TextStyle(color: Colors.grey),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: premiumState.all.map<DropdownMenuItem<int>>((service) {
                  return DropdownMenuItem<int>(
                    value: service.id,
                    child: Text(service.name),
                  );
                }).toList(),
                onChanged: (v) {
                  if (v != null) {
                    final service =
                        premiumState.all.firstWhere((e) => e.id == v);
                    formController.updateService(index, service);
                  }
                },
              )
            ],
          ),

          const SizedBox(height: 16),

          // Quantity and Total Row
          Row(
            children: [
              // Quantity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: item.quantity.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: SpotstockColors.c473069,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.shopping_cart_outlined,
                          color: SpotstockColors.c473069,
                          size: 20,
                        ),
                      ),
                      onChanged: (v) {
                        final qty = int.tryParse(v) ?? 1;
                        formController.updateQuantity(index, qty);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Total
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            SpotstockColors.c473069.withOpacity(0.12),
                            SpotstockColors.c473069.withOpacity(0.06),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: SpotstockColors.c473069.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            color: SpotstockColors.c473069,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "₦${item.total.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: SpotstockColors.c473069,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddServiceButton(dynamic formController) {
    return OutlinedButton.icon(
      onPressed: formController.addServiceRow,
      icon: const Icon(Icons.add_circle_outline_rounded, size: 22),
      label: const Text(
        'Add Another Service',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: SpotstockColors.c473069,
        side: BorderSide(
          color: SpotstockColors.c473069.withOpacity(0.5),
          width: 2,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildTotalSection(dynamic formState) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SpotstockColors.c473069.withOpacity(0.12),
            SpotstockColors.c473069.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: SpotstockColors.c473069.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: SpotstockColors.c473069,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: SpotstockColors.c473069.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Total',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A5568),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'All services included',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "₦${formState.overallTotal.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: SpotstockColors.c473069,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    dynamic formController,
    dynamic booking,
    WidgetRef ref,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SpotstockColors.c473069.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          final bookingController =
              ref.read(bookingPremiumServiceControllerProvider.notifier);

          await formController.save(
            booking,
            bookingController,
          );

          ref
              .read(bookingPremiumServiceControllerProvider.notifier)
              .load(booking.id!);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: SpotstockColors.c473069,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.save_rounded, size: 24),
            SizedBox(width: 12),
            Text(
              'Save Premium Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExistingServicesCard(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingHistoryControllerProvider);
    final premiumState = ref.watch(bookingPremiumServiceControllerProvider);
    final booking = bookingState.selectedBooking;

    if (booking?.id == null) {
      return const SizedBox();
    }

    if (premiumState.isLoading) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(
                color: SpotstockColors.c473069,
              ),
              const SizedBox(height: 16),
              Text(
                'Loading services...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final services = premiumState.services
        .where((e) => e.bookingId == booking!.id!)
        .toList();

    if (services.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No premium services added yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add services above to see them here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    final overallTotal = services.fold(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  SpotstockColors.c473069.withOpacity(0.1),
                  SpotstockColors.c473069.withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SpotstockColors.c473069,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved Premium Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Services added to this booking',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: SpotstockColors.c473069,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${services.length} ${services.length == 1 ? 'service' : 'services'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table
          Padding(
            padding: const EdgeInsets.all(24),
            child: Table(
              border: TableBorder.all(
                color: Colors.grey[200]!,
                width: 1.5,
                borderRadius: BorderRadius.circular(12),
              ),
              children: [
                // Header
                TableRow(
                  decoration: BoxDecoration(
                    color: SpotstockColors.c473069.withOpacity(0.08),
                  ),
                  children: const [
                    TableHeader('Service'),
                    TableHeader('Qty'),
                    TableHeader('Unit Price'),
                    TableHeader('Days'),
                    TableHeader('Total'),
                  ],
                ),

                // Data Rows
                ...services.map(
                  (service) => TableRow(
                    children: [
                      MTableCell(service.serviceName ?? "-"),
                      MTableCell(service.quantity.toString()),
                      MTableCell("₦${service.unitPriceAtTime}"),
                      MTableCell(service.numberOfDays.toString()),
                      MTableCell("₦${service.totalPrice}"),
                    ],
                  ),
                ),

                // Footer Row (Total)
                TableRow(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        SpotstockColors.c473069.withOpacity(0.15),
                        SpotstockColors.c473069.withOpacity(0.1),
                      ],
                    ),
                  ),
                  children: [
                    const MTableCell(""),
                    const MTableCell(""),
                    const MTableCell(""),
                    const MTableCell("Overall Total"),
                    MTableCell("₦$overallTotal"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
