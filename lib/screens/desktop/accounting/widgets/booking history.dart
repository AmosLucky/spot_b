import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/booking_history_provider.dart';
import 'package:spotstock_inventory/common/provider/booking_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/objectbox.g.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/booking_card.dart';
import 'package:spotstock_inventory/screens/print.dart';
import 'package:spotstock_inventory/widgets/sidebar.dart';

class BookingHistoryScreen extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  const BookingHistoryScreen({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  });

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<BookingHistoryProvider>(context, listen: false);
      provider.loadBookings(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingHistoryProvider>(context);
    return Scaffold(
      backgroundColor: ColorsRes.bgcolor,
      // appBar: AppBar(
      //     // title: const Text('Booking History'),
      //     ),
      body: LayoutBuilder(builder: (context, constrint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constrint.maxHeight,
            ),
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.90,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: SideBarHotel(
                            vertical: 20,
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.80,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Booking History',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 50,
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(05),
                                        border: Border.all(
                                            color: ColorsRes.cardpurple),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.refresh,
                                            color: ColorsRes.cardpurple,
                                          ),
                                          Text(
                                            'Refresh',
                                            style: TextStyle(
                                                color: ColorsRes.cardpurple),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(20),
                              // Gap(20),
                              Container(
                                // height: 306,
                                color: ColorsRes.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: const Text(
                                        'Filters',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Gap(10),
                                    _buildBookingNumberFilter(context),
                                    // const SizedBox(height: 16),
                                    Gap(10),
                                    _buildDateToFilter(context),
                                  ],
                                ),
                              ),
                              Gap(10),
                              _buildPaymentStatusFilter(context),
                              Gap(10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorsRes.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Showing ${provider.bookings.isEmpty ? 0 : 1} to ${provider.bookings.length} of ${provider.totalBookings} entries'),
                                    Gap(10),
                                    if (provider.isLoading &&
                                        provider.bookings.isEmpty)
                                      Center(
                                          child: CircularProgressIndicator()),
                                    if (provider.error != null &&
                                        provider.bookings.isEmpty)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: ColorsRes.cardblue,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error,
                                                color: ColorsRes.white),
                                            Gap(10),
                                            Text(
                                              provider.error!,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (provider.bookings.isNotEmpty)
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              3, // Number of columns
                                          crossAxisSpacing:
                                              16, // Space between columns
                                          mainAxisSpacing:
                                              16, // Space between rows
                                          childAspectRatio:
                                              1.5, // Width/height ratio of each item
                                        ),
                                        itemCount: provider.bookings.length,
                                        itemBuilder: (context, index) {
                                          return BookingCard(
                                              booking:
                                                  provider.bookings[index]);
                                        },
                                      )
                                    else if (!provider.isLoading &&
                                        provider.error == null)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: ColorsRes.cardblue,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.info,
                                                color: ColorsRes.white),
                                            Gap(10),
                                            Text(
                                              'No booking records found matching your filters',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBookingNumberFilter(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: 1000,
        height: 112,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Number',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Gap(10),
                    Container(
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(05),
                        border: Border.all(color: ColorsRes.btndarkshadow),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 40,
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.search),
                            decoration:
                                BoxDecoration(color: ColorsRes.bglightgrey),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search by booking #',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 8),
                              ),
                              onChanged: provider.setSearchQuery,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(20),
                SizedBox(
                  height: 80,
                  width: 700,
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Date From'),
                            Gap(10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorsRes.btndarkshadow)),
                              child: InkWell(
                                onTap: () =>
                                    _selectDate(context, isFromDate: true),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.dateFrom == null
                                            ? 'From date'
                                            : '${provider.dateFrom!.day}/${provider.dateFrom!.month}/${provider.dateFrom!.year}',
                                      ),
                                      const Icon(Icons.calendar_month_outlined,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      Container(
                        height: 80,
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Date To'),
                            Gap(10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorsRes.btndarkshadow)),
                              child: InkWell(
                                onTap: () =>
                                    _selectDate(context, isFromDate: false),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        provider.dateTo == null
                                            ? 'To date'
                                            : '${provider.dateTo!.day}/${provider.dateTo!.month}/${provider.dateTo!.year}',
                                      ),
                                      const Icon(Icons.calendar_month_outlined,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Container(
                        width: 160,
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Status'),
                            const SizedBox(height: 4),
                            DropdownButtonFormField<String>(
                              value: provider.status,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorsRes
                                        .btndarkshadow, // Light grey when inactive
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorsRes
                                        .btndarkshadow, // Blue when focused
                                    width: 0.5,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorsRes.black, width: 1),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                              ),
                              items: [
                                'All Statuses',
                                'Active',
                                'Cancelled',
                                'Completed',
                              ]
                                  .map((status) => DropdownMenuItem(
                                        value: status,
                                        child: Text(status),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  provider.setStatus(value);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStatusFilter(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Container(
      height: 85,
      width: 900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Status',
            style: TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildStatusChip('All (0)', provider.allActivePending,
                  provider.setPaymentStatus),
              Gap(10),
              _buildStatusChip('Active (0)', provider.allActivePending,
                  provider.setPaymentStatus),
              Gap(10),
              _buildStatusChip('Pending Check-in (0)',
                  provider.allActivePending, provider.setPaymentStatus),
              Gap(10),
              _buildStatusChip('Checked in (0)', provider.allActivePending,
                  provider.setPaymentStatus),
              Gap(10),
              _buildStatusChip('Completed (0)', provider.allActivePending,
                  provider.setPaymentStatus),
              Gap(10),
              _buildStatusChip('Cancelled (0)', provider.allActivePending,
                  provider.setPaymentStatus),
              Spacer(),
              Container(
                height: 50,
                width: 130,
                child: Row(
                  children: [
                    const Text('Show:'),
                    const SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: ColorsRes.btndarkshadow,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<int>(
                        underline: Container(),
                        elevation: 5,
                        focusColor: Colors.transparent,
                        value: provider.itemsPerPage,
                        items: [15, 30, 50, 100]
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('$value'),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            provider.setItemsPerPage(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDateToFilter(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Container(
      height: 105,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payment Status'),
                      const SizedBox(height: 4),
                      Container(
                        height: 80,
                        width: 230,
                        decoration: BoxDecoration(
                            // color: ColorsRes.btndarkshadow,
                            ),
                        child: DropdownButtonFormField<String>(
                          value: provider.paymentStatus,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsRes
                                    .btndarkshadow, // Light grey when inactive
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsRes
                                    .btndarkshadow, // Blue when focused
                                width: 0.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsRes.black, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                          ),
                          items: [
                            'All Payment Statuses',
                            'Full paid',
                            'Partially Paid',
                            'Not Paid'
                          ]
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              provider.setCheckOutStatus(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Container(
                  height: 104,
                  width: 230,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Check-in Status'),
                      const SizedBox(height: 4),
                      Container(
                        height: 80,
                        width: 230,
                        child: DropdownButtonFormField<String>(
                          value: provider.checkOutStatus,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsRes
                                    .btndarkshadow, // Light grey when inactive
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsRes
                                    .btndarkshadow, // Blue when focused
                                width: 0.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorsRes.black, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                          ),
                          items: [
                            'All Check-out Statuses',
                            'Checked in',
                            'Reservations'
                          ]
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              provider.setCheckOutStatus(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Check-out Status'),
                    const SizedBox(height: 4),
                    Container(
                      height: 80,
                      width: 230,
                      child: DropdownButtonFormField<String>(
                        value: provider.checkOutStatus,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorsRes
                                  .btndarkshadow, // Light grey when inactive
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  ColorsRes.btndarkshadow, // Blue when focused
                              width: 0.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorsRes.black, width: 1),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        ),
                        items: [
                          'All Check-out Statuses',
                          'Checked Out',
                          'Not Checked Out',
                        ]
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            provider.setCheckOutStatus(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Container(
                  height: 80,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('View Mode'),
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // height: 50,
                            width: 90,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 08,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: ColorsRes.cardpurple),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grid_view_outlined,
                                  color: ColorsRes.cardpurple,
                                  size: 15,
                                ),
                                Gap(10),
                                Text(
                                  'Grid',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: ColorsRes.cardpurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(10),
                          Container(
                            // height: 50,
                            width: 90,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 08),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: ColorsRes.cardpurple),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.list,
                                  color: ColorsRes.cardpurple,
                                  size: 15,
                                ),
                                Gap(10),
                                Text(
                                  'List',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsRes.cardpurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilter(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);

    return Container(
      height: 80,
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Row(
            children: [
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('View Mode'),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: provider.viewMode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    ),
                    items: ['Grid', 'List']
                        .map((mode) => DropdownMenuItem(
                              value: mode,
                              child: Text(mode),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        provider.setViewMode(value);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultsInfo(BuildContext context) {
    return const Row(
      children: [
        Text('Showing 0 to 0 of 0 entries'),
      ],
    );
  }

  Widget _buildNoResultsMessage() {
    return const Center(
      child: Text(
        'No booking records found matching your filters.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildStatusChip(
    String label,
    String selectedValue,
    Function(String) onSelected,
  ) {
    bool isSelected =
        selectedValue == label.split(' ')[0]; // Matching based on first word
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: isSelected
              ? ColorsRes.cardpurple
              : Colors.black, // change text color
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      // disabledColor: Colors.transparent,
      selectedColor: Colors.white, // container color when selected
      backgroundColor: Colors.transparent, // container color when unselected
      onSelected: (selected) {
        if (selected) {
          onSelected(
              label.split(' ')[0]); // pass only the word "All", "Active" etc
        }
      },
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isFromDate}) async {
    final provider = Provider.of<BookingProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isFromDate) {
        provider.setDateFrom(picked);
      } else {
        provider.setDateTo(picked);
      }
    }
  }
}
