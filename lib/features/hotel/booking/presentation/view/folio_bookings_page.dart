import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/booking_entity.dart';
import '../providers/folio_booking_provider.dart';
import '../state/folio_booking_state.dart';

// ─────────────────────────────────────────────
//  Color & Style Constants
// ─────────────────────────────────────────────
class _AppColors {
  static const background = Color(0xFFF4F6FA);
  static const surface = Colors.white;
  static const primary = Color(0xFF1A5CFF);
  static const primaryDark = Color(0xFF1244CC);
  static const textPrimary = Color(0xFF0D1B3E);
  static const textSecondary = Color(0xFF6B7A99);
  static const textMuted = Color(0xFFB0BAD3);
  static const border = Color(0xFFE4E9F2);
  static const headerBg = Color(0xFF0D1B3E);
  static const badgeActive = Color(0xFFE8F5E9);
  static const badgeActiveText = Color(0xFF2E7D32);
  static const badgeInactive = Color(0xFFFFF3E0);
  static const badgeInactiveText = Color(0xFFE65100);
  static const shimmer1 = Color(0xFFEEF1F8);
  static const shimmer2 = Color(0xFFF8F9FC);
}

// ─────────────────────────────────────────────
//  Main Screen
// ─────────────────────────────────────────────
class FolioBookingsPage extends ConsumerStatefulWidget {
  const FolioBookingsPage({super.key});

  @override
  ConsumerState<FolioBookingsPage> createState() => _FolioBookingScreenState();
}

class _FolioBookingScreenState extends ConsumerState<FolioBookingsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(folioBookingControllerProvider.notifier).loadBookings();
    });
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(folioBookingControllerProvider);

    return Scaffold(
      backgroundColor: _AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Column(
          children: [
            /// _TopBar(selectedDate: state.selectedDate),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _SearchFilterRow(searchCtrl: _searchCtrl),
                    const SizedBox(height: 20),
                    _TableHeader(),
                    const SizedBox(height: 8),
                    Expanded(child: _BookingList(state: state)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Top Bar
// ─────────────────────────────────────────────
class _TopBar extends ConsumerWidget {
  final DateTime? selectedDate;
  const _TopBar({this.selectedDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = selectedDate ?? DateTime.now();
    final formatted = DateFormat('dd/MM/yyyy').format(date);

    return Container(
      decoration: const BoxDecoration(
        color: _AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        children: [
          // Logo / Brand mark
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.book_online, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Text(
            'Folio Bookings',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          // Date picker chip
          _DateChip(label: formatted),
        ],
      ),
    );
  }
}

class _DateChip extends ConsumerWidget {
  final String label;
  const _DateChip({required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.light(
                primary: _AppColors.primary,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          // ref
          //     .read(folioBookingControllerProvider.notifier)
          //     .setSelectedDate(picked);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: _AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 15, color: _AppColors.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _AppColors.textPrimary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Search + Filter Row
// ─────────────────────────────────────────────
class _SearchFilterRow extends ConsumerWidget {
  final TextEditingController searchCtrl;
  const _SearchFilterRow({required this.searchCtrl});

  static const _filters = ['All', 'Active', 'Inactive'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(folioBookingControllerProvider);

    return Row(
      children: [
        // Search field
        Expanded(
          flex: 3,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _AppColors.border),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x06000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: TextField(
              controller: searchCtrl,
              onChanged: (v) => ref
                  .read(folioBookingControllerProvider.notifier)
                  .setSearchQuery(v),
              style: const TextStyle(
                fontSize: 14,
                color: _AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Search by customer name or booking reference...',
                hintStyle: const TextStyle(
                  color: _AppColors.textMuted,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search,
                    color: _AppColors.textMuted, size: 20),
                suffixIcon: searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close,
                            size: 18, color: _AppColors.textMuted),
                        onPressed: () {
                          searchCtrl.clear();
                          ref
                              .read(folioBookingControllerProvider.notifier)
                              .setSearchQuery('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter dropdown
        _FilterDropdown(
          filters: _filters,
          selected: state.selectedFilter,
          onChanged: (v) =>
              ref.read(folioBookingControllerProvider.notifier).setFilter(v),
        ),
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onChanged;

  const _FilterDropdown({
    required this.filters,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: _AppColors.textSecondary),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _AppColors.textPrimary,
          ),
          items: filters
              .map((f) => DropdownMenuItem(value: f, child: Text(f)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Table Header
// ─────────────────────────────────────────────
class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
        color: _AppColors.headerBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Expanded(flex: 3, child: _HeaderCell('CUSTOMER NAME')),
          Expanded(flex: 3, child: _HeaderCell('CUSTOMER PHONE')),
          Expanded(flex: 3, child: _HeaderCell('ATTENDANT')),
          Expanded(flex: 2, child: _HeaderCell('ARRIVAL')),
          Expanded(flex: 2, child: _HeaderCell('DEPARTURE')),
          Expanded(flex: 2, child: _HeaderCell('STATUS')),
          SizedBox(
              width: 110,
              child: _HeaderCell('ACTIONS', align: TextAlign.center)),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final TextAlign align;
  const _HeaderCell(this.label, {this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: align,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF8A9EC9),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Booking List
// ─────────────────────────────────────────────
class _BookingList extends StatelessWidget {
  final FolioBookingState state;
  const _BookingList({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) return Center(child: const CircularProgressIndicator());

    if (state.error != null) {
      return _ErrorView(message: state.error!);
    }

    final bookings = state.filteredBookings;

    if (bookings.isEmpty) {
      return const _EmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: bookings.length,
      itemBuilder: (ctx, i) => _BookingRow(
        booking: bookings[i],
        index: i,
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Booking Row Card
// ─────────────────────────────────────────────
class _BookingRow extends StatefulWidget {
  final BookingEntity booking;
  final int index;
  const _BookingRow({required this.booking, required this.index});

  @override
  State<_BookingRow> createState() => _BookingRowState();
}

class _BookingRowState extends State<_BookingRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);

    Future.delayed(Duration(milliseconds: 60 * widget.index), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;
    final isActive = booking.status.toLowerCase() == 'active';

    return FadeTransition(
      opacity: _anim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(_anim),
        child: MouseRegion(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                // Customer name with avatar
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      _Avatar(name: "booking.customerName"),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "booking.customerName",
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: _AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                // Phone
                Expanded(
                  flex: 3,
                  child: Text(
                    " booking.customerPhone" ?? '—',
                    style: const TextStyle(
                      fontSize: 13,
                      color: _AppColors.textSecondary,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                // Attendant
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: _AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          " booking.attendantName" ?? '—',
                          style: const TextStyle(
                            fontSize: 13,
                            color: _AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrival
                Expanded(
                  flex: 2,
                  child: _DateLabel(date: booking.dateFrom),
                ),
                // Departure
                Expanded(
                  flex: 2,
                  child: _DateLabel(date: booking.updatedAt),
                ),
                // Status badge
                Expanded(
                  flex: 2,
                  child: _StatusBadge(isActive: isActive),
                ),
                // Action button
                SizedBox(
                  width: 110,
                  child: _ViewDetailsButton(booking: booking),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Sub-widgets
// ─────────────────────────────────────────────
class _Avatar extends StatelessWidget {
  final String name;
  const _Avatar({required this.name});

  Color _colorFromName(String n) {
    final colors = [
      const Color(0xFF1A5CFF),
      const Color(0xFF7B2FF7),
      const Color(0xFF00BFA5),
      const Color(0xFFF4511E),
      const Color(0xFF0097A7),
      const Color(0xFFFF6F00),
    ];
    return colors[n.codeUnits.first % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty
        ? name.trim().split(' ').take(2).map((w) => w[0].toUpperCase()).join()
        : '?';

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: _colorFromName(name).withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _colorFromName(name),
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  final DateTime? date;
  const _DateLabel({this.date});

  @override
  Widget build(BuildContext context) {
    if (date == null) {
      return const Text('—',
          style: TextStyle(color: _AppColors.textMuted, fontSize: 13));
    }
    final formatted = DateFormat('MMM dd, yyyy').format(date!);
    return Text(
      formatted,
      style: const TextStyle(
        fontSize: 13,
        color: _AppColors.textSecondary,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;
  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isActive ? _AppColors.badgeActive : _AppColors.badgeInactive,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? _AppColors.badgeActiveText
                  : _AppColors.badgeInactiveText,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            isActive ? 'Active' : 'Inactive',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? _AppColors.badgeActiveText
                  : _AppColors.badgeInactiveText,
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewDetailsButton extends ConsumerWidget {
  final BookingEntity booking;
  const _ViewDetailsButton({required this.booking});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigate to details
          // ref
          //     .read(folioBookingControllerProvider.notifier)
          //     .selectBooking(booking);
        },
        style: TextButton.styleFrom(
          backgroundColor: _AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ).copyWith(
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.15),
          ),
        ),
        child: const Text(
          'View Details',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}



// ─────────────────────────────────────────────
//  Empty State
// ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.inbox_outlined,
                size: 36, color: _AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text(
            'No bookings found',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: _AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try adjusting your search or filter',
            style: TextStyle(fontSize: 14, color: _AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Error View
// ─────────────────────────────────────────────
class _ErrorView extends ConsumerWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.error_outline, size: 36, color: Colors.red),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => ref
                .read(folioBookingControllerProvider.notifier)
                .loadBookings(),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
            style: TextButton.styleFrom(
              backgroundColor: _AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
