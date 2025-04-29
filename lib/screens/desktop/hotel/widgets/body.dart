import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/primary_text_field.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';
import '../../../../common/custom_selector_sheet3.dart';
import '../../../../common/secondary_custom_dropdown.dart';
import '../../../../common/style.dart';
import '../../../../widgets/sidebar.dart';
import '../../../mobile/home/pages/transactions.dart';
import '../../home/hotel_screen_desktop.dart';
import 'side_container.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;

  const Body({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController _barcodeController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _dogeNames = [
    '2012',
    '2886',
    '34376',
  ];

  List _rooms = [];
  List _hotelCategories = [];
  List _filterRooms = [];
  List _dataRooms = [];
  bool _searching = false;
  bool _isInvoiceOpen = false;
  Map _registerInfo = {};
  Map<String, dynamic> selectedRoom = {};
  String btnAction = "book_now";
  String? selectedCategory;
  String? selectedStatus;
  bool loading = false;
  String selectedRoomType = '';
  Map<String, dynamic>? selectedRoomItem = {};
  DateTimeRange? _selectedDateRange;
  Map? selectedRange;
  String hintValue = '';
  DateTimeRange? pickedDateRange;
  bool searchingRooms = false;
  bool roomSearched = false;
  Map roomResult = {};
  List selectedRooms = [];

  List _productSearchResult = [];
  List? _foundProducts = [];
  String selectedRoomTypeId = '';
  final adultController = TextEditingController(text: "1");
  final childrenController = TextEditingController(text: '0');
  final roomNoController = TextEditingController(text: "1");
  final DateFormat formatter = DateFormat('MM/dd/yyyy');

  @override
  void initState() {
    super.initState();
    getRoomTypes();
    _barcodeController = TextEditingController();
    readRooms();
    readRegisterInfo();
  }

  String getFormattedDateRange() {
    if (_selectedDateRange != null) {
      final DateFormat formatter = DateFormat('MM/dd/yyyy');
      return '${formatter.format(_selectedDateRange!.start)}-${formatter.format(_selectedDateRange!.end)}';
    }
    return 'Select Date Range';
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      saveText: 'Select Date',
      initialDateRange: _selectedDateRange ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          ),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDateRange != null && pickedDateRange != _selectedDateRange) {
      setState(() {
        _selectedDateRange = pickedDateRange;
      });
      // widget.onDateRangeSelected(
      //     pickedDateRange); // Pass the selected date range to parent
    }
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }

  Future<void> playSound() async {
    // Play the audio file from assets
    await _audioPlayer.play(AssetSource('images/Heater-4_1.mp3'));
  }

  Future<void> getRoomTypes() async {
    var response = await widget.systemProvider.getRoomTypes();
    print("---------------- rooms types -------------");
    // print(data);
    systemProvider.roomTypesItems;
    print("All room types ==>> ${systemProvider.roomTypesItems}");
    setState(() {});
  }

  Future<void> searchRooms() async {
    setState(() {
      searchingRooms = true;
      roomSearched = false;
    });
    //var response;
    var response = await widget.systemProvider.getAvailableRooms(
        selectedRoomTypeId,
        adultController.text.trim(),
        childrenController.text.trim(),
        roomNoController.text.trim(),
        formatter.format(_selectedDateRange!.start),
        formatter.format(_selectedDateRange!.end));
    print("---------------- rooms types -------------");
    print(response);
    //systemProvider.roomTypesItems;
    print("room result ==>> ${response}");
    setState(() {
      roomResult = response;
      searchingRooms = false;
      roomSearched = true;
    });
  }

  Future<void> readRooms() async {
    setState(() {
      loading = true;
    });
    final data = await widget.systemProvider.getHotelRooms();
    final hotelCategory = await widget.systemProvider.getHotelCategories();
    final hotel =
        await widget.systemProvider.fetchHotelReservations(true, true);
    print("---------------- rooms -------------");
    // print(data);
    print("Total number of hotel rooms ==>> ${data.length}");
    print("hotel Reservation ===>> $hotel");
    setState(() {
      _rooms = data;
      _foundProducts = data;
      _dataRooms = data;
      _hotelCategories = hotelCategory;
      loading = false;
    });
  }

  Future<List<dynamic>> getRooms() async {
    return await widget.systemProvider.getHotelRooms();
  }

  Future<void> readRegisterInfo() async {
    final data = await widget.systemProvider.getCurrentRegister(app: "HOTEL");
    print("---------current open register ----------");
    print(data);
    setState(() {
      _registerInfo = data;
    });
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sysP = context.watch<SystemProvider>();

    final List<Map<String, dynamic>> statusOptions = [
      {'value': 1, 'label': 'Available', 'color': Color(0xFF279B0A)},
      {'value': 2, 'label': 'Checked In', 'color': Color(0xFFE96D3A)},
      {'value': 3, 'label': 'Reserved', 'color': Color(0xFFDAA520)},
      {'value': 4, 'label': 'Under Maintenance', 'color': Color(0xFFF62947)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dashboard Content Area
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height, // Set max height
                  ),
                  child: Container(
                    width: 200, // Fixed width for sidebar
                    child: SideBarHotel(
                      vertical: 20,
                      user: widget.user,
                      systemProvider: widget.systemProvider,
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section for Search Bar and Barcode Scanner

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            child: Consumer<SystemProvider>(
                              builder: (context, systemProvider, child) =>
                                  SecondaryCustomDropDown(
                                      color: Colors.grey.withOpacity(0.3),
                                      hintText: selectedRoomType,
                                      titleText: "Room Type",
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            isDismissible: true,
                                            context: context,
                                            builder: (context) {
                                              return CustomSelectorBottomSheet3(
                                                height: 40.h,
                                                onSelect: (value, index) {
                                                  setState(() {
                                                    selectedRoomTypeId =
                                                        value['attributes']
                                                                ['id']
                                                            .toString();
                                                    selectedRoomType =
                                                        value['attributes']
                                                            ['name'];
                                                  });
                                                  debugPrint(
                                                      "valueeee ===>> $selectedRoomType");
                                                },
                                                items: systemProvider
                                                    .roomTypesItems,
                                              );
                                            });
                                      }),
                              //const SizedBox(height: 15),
                              // SizedBox(height: 5.h, width: 30.w,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       log(systemProvider.roomTypesItems.toString());
                              //     },
                              //     child: CustomDropdown(
                              //       items: systemProvider.roomTypesItems.toSet().toList(),
                              //       selectedItem: selectedRoomItem,
                              //       getItemLabel: (item) => item['attributes']['name'],
                              //       onChanged: (value) {
                              //         selectedRoomItem = value;
                              //         selectedRoomType = value!['attributes']['name'];
                              //       },
                              //       hintText: "Select room type",
                              //       dropdownColor: Colors.white,
                              //     ),
                              //   ),),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Check-in & Check-out Dates",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(
                                  height: 1.2.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    _selectDateRange(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 13.0,
                                      horizontal: 25.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16),
                                        const SizedBox(width: 8),
                                        Text(
                                          getFormattedDateRange(),
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0, left: 30),
                            child: OutlinedButton(
                              onPressed: () async {
                                // Check if the register is open before navigating
                                _navigateToPage(
                                  context,
                                  HotelScreenDesktop(),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: secondaryColor,
                                    width: 1), // Outline color and width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24, // Horizontal padding
                                  vertical: 16, // Vertical padding
                                ),
                              ),
                              child: Text(
                                "DASHBOARD",
                                style: TextStyle(color: secondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: PrimaryTextField(
                                  controller: roomNoController,
                                  hintText: "Enter number of rooms",
                                  titleSize: 12.sp,
                                  title: "No of rooms")),
                          SizedBox(
                            width: 1.w,
                          ),
                          Expanded(
                              child: PrimaryTextField(
                                  controller: adultController,
                                  hintText: "Enter number of adults",
                                  titleSize: 12.sp,
                                  title: "Adults")),
                          SizedBox(
                            width: 1.w,
                          ),
                          Expanded(
                              child: PrimaryTextField(
                                  controller: childrenController,
                                  hintText: "Enter number of children",
                                  titleSize: 12.sp,
                                  title: "Children")),
                        ],
                      ),

                      SizedBox(
                        height: 4.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 5.h,
                            child: !searchingRooms
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: secondaryColor),
                                    onPressed: () {
                                      if (selectedRoomTypeId != '' &&
                                          _selectedDateRange != null) {
                                        setState(() {
                                          selectedRoom = {};
                                          btnAction = "k";
                                        });
                                        searchRooms();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Provide all required details to continue'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Search Rooms",
                                      style: TextStyle(color: Colors.white),
                                    ))
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      roomSearched && roomResult.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),

                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Text(
                                      "Please select rooms for each day of your stay. You need to select the \nsame number of rooms for each day.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 5.h,
                                  ),

                                  Container(
                                    width: 70.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Date",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Rooms",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _selectedDateRange != null
                                            ? Text(
                                                "${formatter.format(_selectedDateRange!.start)} - ${formatter.format(_selectedDateRange!.end)}",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              )
                                            : Text("Select Date"),
                                        GestureDetector(
                                          onTap: () {
                                            //print(sysP.roomResult);
                                          },
                                          child: Container(
                                            //width: MediaQuery.of(context).size.width,
                                            //height: 20.h,
                                            decoration: BoxDecoration(
                                              //color: Colors.pink,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 11, vertical: 5),
                                            child: Wrap(
                                              runAlignment:
                                                  WrapAlignment.spaceBetween,
                                              spacing: 0.2.w,
                                              //runSpacing: 0.0,
                                              children: List.generate(
                                                roomResult['rooms'].length,
                                                (i) {
                                                  return Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      customBorder:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      onTap: () {
                                                        //amountController.text = amount[i];
                                                        if (!selectedRooms.contains(
                                                                roomResult[
                                                                        'rooms']
                                                                    [i]) &&
                                                            selectedRooms
                                                                    .length <=
                                                                (int.parse(roomNoController
                                                                        .text) -
                                                                    1)) {
                                                          selectedRooms.add(
                                                              roomResult[
                                                                  'rooms'][i]);
                                                          selectedRooms
                                                              .toSet()
                                                              .toList();
                                                          print(
                                                              "selected room $selectedRooms");
                                                          setState(() {
                                                            selectedRoom =
                                                                roomResult[
                                                                    'rooms'][i];
                                                            btnAction =
                                                                "book_now";
                                                            selectedRooms.contains(
                                                                roomResult[
                                                                        'rooms']
                                                                    [i]);
                                                          });
                                                        } else {
                                                          setState(() {
                                                            selectedRooms.remove(
                                                                roomResult[
                                                                        'rooms']
                                                                    [i]);
                                                            if (selectedRooms
                                                                .isEmpty) {
                                                              selectedRoom = {};
                                                              btnAction = "k";
                                                            }
                                                          });
                                                          if (selectedRooms
                                                                  .length ==
                                                              (int.parse(
                                                                  roomNoController
                                                                      .text))) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'You can only select the number of rooms specified during search'),
                                                              ),
                                                            );
                                                          }
                                                          print(
                                                              "selected room $selectedRooms");
                                                        }
                                                        // setState(() {
                                                        //   selectedRooms.contains(roomResult['rooms'][i]);
                                                        // });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                // left: 2.w,
                                                                // right: 2.w,
                                                                // bottom: 1.h,
                                                                // top: 1.h,
                                                                ),
                                                        child: Container(
                                                          width: 5.w,
                                                          height: 5.h,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 5,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: selectedRooms
                                                                    .contains(
                                                                        roomResult['rooms']
                                                                            [i])
                                                                ? Colors
                                                                    .deepPurple
                                                                : Colors.grey
                                                                    .withOpacity(
                                                                        0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Center(
                                                              child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                roomResult['rooms']
                                                                        [i][
                                                                    'room_number'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: selectedRooms.contains(roomResult['rooms']
                                                                            [i])
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //SizedBox(height: 2.h,),
                                ],
                              ),
                            )
                          : SizedBox(), // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 3.0, horizontal: 16.0),
                      //   child: HeaderSection(
                      //     systemProvider: widget.systemProvider,
                      //     mediaQuery: widget.mediaQuery,
                      //     hint: selectedCategory ?? 'Filter by Category',
                      //     statusHint: selectedStatus ?? 'Filter by Status',
                      //     user: widget.user,
                      //     hotelCategories: _hotelCategories
                      //         .whereType<Map<String, dynamic>>()
                      //         .toList(),
                      //     statuses: statusOptions,
                      //     barcodeCtrl: _barcodeController,
                      //     onClearButtonPressed: (value) {
                      //       setState(() {
                      //         _dataRooms = _rooms;
                      //       });
                      //     },
                      //     onSearchButtonPressed: (value) {
                      //       if (value.isEmpty) {
                      //         setState(() {
                      //           _dataRooms = _rooms;
                      //         });
                      //       } else {
                      //         _filterRooms = _rooms.where((roomMap) {
                      //           var room = roomMap['attributes'];
                      //           final roomName =
                      //               room['name'] ?? ''; // Prevent null
                      //           final roomCode =
                      //               room['code'] ?? ''; // Prevent null
                      //           return roomName
                      //                   .toLowerCase()
                      //                   .contains(value.toLowerCase()) ||
                      //               roomCode == value;
                      //         }).toList();
                      //         setState(() {
                      //           _dataRooms = _filterRooms;
                      //         });
                      //       }
                      //     },
                      //     onKeywordChanged: (value) {
                      //       print("--------- searching--------------");
                      //       print(value);
                      //       if (value.isEmpty) {
                      //         setState(() {
                      //           _dataRooms = _rooms;
                      //         });
                      //       } else {
                      //         _filterRooms = _rooms.where((roomMap) {
                      //           var room = roomMap['attributes']['category'];
                      //           final roomName =
                      //               room['name'] ?? ''; // Prevent null
                      //           final roomCode =
                      //               room['code'] ?? ''; // Prevent null
                      //           return roomName
                      //                   .toLowerCase()
                      //                   .contains(value.toLowerCase()) ||
                      //               roomCode == value;
                      //         }).toList();
                      //         setState(() {
                      //           _dataRooms = _filterRooms;
                      //         });
                      //       }
                      //     },
                      //     onPressed: () {
                      //       setState(() {
                      //         _foundProducts = _dataRooms;
                      //         selectedCategory = null;
                      //         selectedStatus = null;
                      //         selectedRoom = {};
                      //         readRooms();
                      //       });
                      //     },
                      //     onCategorySelected: (selectedItem) {
                      //       setState(() {
                      //         selectedCategory =
                      //             selectedItem?['attributes']['name'];
                      //       });
                      //       _filterCategory(
                      //           selectedItem?['attributes']['name']);
                      //       print(
                      //           'Selected Category: ${selectedItem?['attributes']['name']}');
                      //       print("category ==>> $_dataRooms");
                      //     },
                      //     onStatusSelected: (selectedItem) {
                      //       //Map decodedValue = jsonDecode(selectedItem);
                      //       setState(() {
                      //         selectedStatus = selectedItem?['label'];
                      //       });
                      //       _filterByStatus(selectedItem?['value']);
                      //       print('Selected Status: ${selectedItem?['value']}');
                      //     },
                      //   ),
                      // ),
                      //
                      // // Main Dashboard Content Area
                      // // showing the list of available rooms
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 16, vertical: 2),
                      //   child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors
                      //             .white, // Set your desired background color
                      //         borderRadius: BorderRadius.circular(
                      //             5), // Border radius of 5
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.black
                      //                 .withOpacity(0.1), // Subtle shadow
                      //             spreadRadius: 2,
                      //             blurRadius: 5,
                      //             offset: const Offset(0, 2),
                      //           ),
                      //         ],
                      //       ),
                      //       padding: const EdgeInsets.all(
                      //           10), // Add some padding inside the container
                      //       child: Column(children: [
                      //         Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 vertical: 3.0, horizontal: 16.0),
                      //             child: Row(
                      //               children: [
                      //                 StatusIndicator(
                      //                   status: 1,
                      //                   name: 'Available',
                      //                 ),
                      //                 SizedBox(width: 10),
                      //                 StatusIndicator(
                      //                   status: 2,
                      //                   name: 'Checked In',
                      //                 ), // Checked In
                      //                 SizedBox(width: 10),
                      //                 StatusIndicator(
                      //                   status: 3,
                      //                   name: 'Reserved',
                      //                 ), // Reserved
                      //                 SizedBox(width: 10),
                      //                 StatusIndicator(
                      //                   status: 4,
                      //                   name: 'Under Maintenance',
                      //                 ), // Under Maintenance
                      //                 SizedBox(width: 10),
                      //                 StatusIndicator(
                      //                   status: 5,
                      //                   name: 'Unavailable',
                      //                 ), // Unavailable
                      //               ],
                      //             )),
                      //         SizedBox(
                      //           height: widget.mediaQuery.height - 100,
                      //           child: loading == false
                      //               ? GridView.builder(
                      //                   itemCount: _foundProducts?.length,
                      //                   gridDelegate:
                      //                       const SliverGridDelegateWithFixedCrossAxisCount(
                      //                     crossAxisCount: 3,
                      //                     crossAxisSpacing: 5,
                      //                     mainAxisSpacing: 5,
                      //                     childAspectRatio: 1.5,
                      //                   ),
                      //                   itemBuilder: (context, index) {
                      //                     var room = _foundProducts?[index]
                      //                         ['attributes'];
                      //                     var type = room?['category'] != null
                      //                         ? room['name']
                      //                         : 'NIL';
                      //                     return RoomCard(
                      //                       room: _foundProducts?[index],
                      //                       onAction:
                      //                           (Map<String, dynamic> room,
                      //                               BuildContext context) {
                      //                         setState(() {
                      //                           btnAction = "book_now";
                      //                           selectedRoom = {};
                      //                         });
                      //                         print(room);
                      //                         print("------------------");
                      //                         showModalBottomSheet(
                      //                           context: context,
                      //                           shape: RoundedRectangleBorder(
                      //                             borderRadius:
                      //                                 BorderRadius.vertical(
                      //                                     top: Radius.circular(
                      //                                         10)),
                      //                           ),
                      //                           builder: (context) {
                      //                             return RoomActionModal(
                      //                               room: room,
                      //                               onBookNow: () {
                      //                                 print(
                      //                                     "Book Now Clicked for ${room['attributes']['name']}");
                      //                                 setState(() {
                      //                                   selectedRoom = room;
                      //                                   btnAction = "book_now";
                      //                                 });
                      //                               },
                      //                               onEditBooking: () {
                      //                                 print(
                      //                                     "Edit Booking Clicked for ${room['attributes']['name']}");
                      //                                 setState(() {
                      //                                   selectedRoom = room;
                      //                                   btnAction =
                      //                                       "edit_booking";
                      //                                 });
                      //                               },
                      //                               onTransfer: () {
                      //                                 print(
                      //                                     "Transfer Clicked for ${room['attributes']['name']}");
                      //
                      //                                 setState(() {
                      //                                   selectedRoom = room;
                      //                                   btnAction =
                      //                                       "transfer_booking";
                      //                                 });
                      //                               },
                      //                               onMaintenanceReport: () {
                      //                                 print(
                      //                                     "Maintenance Report Clicked for ${room['attributes']['name']}");
                      //
                      //                                 setState(() {
                      //                                   selectedRoom = room;
                      //                                   btnAction =
                      //                                       "maintenance_report";
                      //                                 });
                      //                               },
                      //                               onFolioHistory: () {
                      //                                 setState(() {
                      //                                   selectedRoom = room;
                      //                                   btnAction =
                      //                                       "folio_history";
                      //                                 });
                      //                               },
                      //                             );
                      //                           },
                      //                         );
                      //
                      //                         playSound();
                      //                       },
                      //                       backgroundColor: room['color'] !=
                      //                               null
                      //                           ? HexColor(
                      //                               room['color'].toString())
                      //                           : HexColor("#279B0A"),
                      //                       name: room['name'].toString(),
                      //                       price: Money.format(room['price'])
                      //                           .toString(),
                      //                       type: type.toString(),
                      //                     );
                      //                   },
                      //                 )
                      //               : Center(
                      //                   child: CircularProgressIndicator(),
                      //                 ),
                      //         ),
                      //       ])),
                      // ),
                    ],
                  ),
                ),

                // Right Column: Order Summary
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SideContainer(
                    checkInDate: DateTime.parse(
                        roomResult['check_in'] ?? DateTime.now().toString()),
                    checkOutDate: DateTime.parse(
                        roomResult['check_out'] ?? DateTime.now().toString()),
                    rooms: _dataRooms,
                    action: btnAction,
                    room: selectedRoom,
                    mediaQuery: widget.mediaQuery,
                    registerInfo: _registerInfo,
                    systemProvider: widget.systemProvider,
                    user: widget.user,
                    onRefreshRoom: () {
                      setState(() {
                        _foundProducts = _dataRooms;
                        selectedCategory = null;
                        selectedStatus = null;
                        selectedRoom = {};
                        readRooms();
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _filterCategory(String? value) {
    print("Value == $value");
    setState(() {
      _productSearchResult = _rooms;
      _foundProducts = _productSearchResult;
    });
    print("Onchanged called");
    setState(() {
      _productSearchResult = _dataRooms.where((room) {
        print("Result ===>> ${room['attributes']['category']?['name']}");
        return room['attributes']['category']?['name'] != null
            ? (room['attributes']['category']?['name'])
                .toLowerCase()
                .contains(value?.toLowerCase())
            : false;
      }).toList();
      _foundProducts = _productSearchResult;
    });
    //debugPrint(_foundProducts.toString());
    debugPrint("Found product ==>> ${_foundProducts.toString()}");
  }

  void _filterByStatus(int? value) {
    setState(() {
      _productSearchResult = _rooms;
      _foundProducts = _productSearchResult;
    });
    setState(() {
      _productSearchResult = _dataRooms.where((room) {
        return room['attributes']['status'] == value;
      }).toList();
      _foundProducts = _productSearchResult;
    });
    debugPrint("Found product ==>> ${_foundProducts.toString()}");
  }
}
