import 'package:audioplayers/audioplayers.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';

import 'header.dart';
import 'room_action.dart';
import 'room_card.dart';
import 'side_container.dart';
import 'statuses.dart'; // Import the HeaderSection widget

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

  List _productSearchResult = [];
  List? _foundProducts = [];

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController();
    readRooms();
    readRegisterInfo();
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

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section for Search Bar and Barcode Scanner
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 16.0),
                        child: HeaderSection(
                          systemProvider: widget.systemProvider,
                          mediaQuery: widget.mediaQuery,
                          hint: selectedCategory ?? 'Filter by Category',
                          statusHint: selectedStatus ?? 'Filter by Status',
                          user: widget.user,
                          hotelCategories: _hotelCategories
                              .whereType<Map<String, dynamic>>()
                              .toList(),
                          statuses: statusOptions,
                          barcodeCtrl: _barcodeController,
                          onClearButtonPressed: (value) {
                            setState(() {
                              _dataRooms = _rooms;
                            });
                          },
                          onSearchButtonPressed: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                _dataRooms = _rooms;
                              });
                            } else {
                              _filterRooms = _rooms.where((roomMap) {
                                var room = roomMap['attributes'];
                                final roomName =
                                    room['name'] ?? ''; // Prevent null
                                final roomCode =
                                    room['code'] ?? ''; // Prevent null
                                return roomName
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    roomCode == value;
                              }).toList();
                              setState(() {
                                _dataRooms = _filterRooms;
                              });
                            }
                          },
                          onKeywordChanged: (value) {
                            print("--------- searching--------------");
                            print(value);
                            if (value.isEmpty) {
                              setState(() {
                                _dataRooms = _rooms;
                              });
                            } else {
                              _filterRooms = _rooms.where((roomMap) {
                                var room = roomMap['attributes']['category'];
                                final roomName =
                                    room['name'] ?? ''; // Prevent null
                                final roomCode =
                                    room['code'] ?? ''; // Prevent null
                                return roomName
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    roomCode == value;
                              }).toList();
                              setState(() {
                                _dataRooms = _filterRooms;
                              });
                            }
                          },
                          onPressed: () {
                            setState(() {
                              _foundProducts = _dataRooms;
                              selectedCategory = null;
                              selectedStatus = null;
                              selectedRoom = {};
                              readRooms();
                            });
                          },
                          onCategorySelected: (selectedItem) {
                            setState(() {
                              selectedCategory =
                                  selectedItem?['attributes']['name'];
                            });
                            _filterCategory(
                                selectedItem?['attributes']['name']);
                            print(
                                'Selected Category: ${selectedItem?['attributes']['name']}');
                            print("category ==>> $_dataRooms");
                          },
                          onStatusSelected: (selectedItem) {
                            //Map decodedValue = jsonDecode(selectedItem);
                            setState(() {
                              selectedStatus = selectedItem?['label'];
                            });
                            _filterByStatus(selectedItem?['value']);
                            print('Selected Status: ${selectedItem?['value']}');
                          },
                        ),
                      ),

                      // Main Dashboard Content Area
                      // showing the list of available rooms
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 2),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Set your desired background color
                              borderRadius: BorderRadius.circular(
                                  5), // Border radius of 5
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1), // Subtle shadow
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(
                                10), // Add some padding inside the container
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      StatusIndicator(
                                        status: 1,
                                        name: 'Available',
                                      ),
                                      SizedBox(width: 10),
                                      StatusIndicator(
                                        status: 2,
                                        name: 'Checked In',
                                      ), // Checked In
                                      SizedBox(width: 10),
                                      StatusIndicator(
                                        status: 3,
                                        name: 'Reserved',
                                      ), // Reserved
                                      SizedBox(width: 10),
                                      StatusIndicator(
                                        status: 4,
                                        name: 'Under Maintenance',
                                      ), // Under Maintenance
                                      SizedBox(width: 10),
                                      StatusIndicator(
                                        status: 5,
                                        name: 'Unavailable',
                                      ), // Unavailable
                                    ],
                                  )),
                              SizedBox(
                                height: widget.mediaQuery.height - 100,
                                child: loading == false
                                    ? GridView.builder(
                                        itemCount: _foundProducts?.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          childAspectRatio: 1.5,
                                        ),
                                        itemBuilder: (context, index) {
                                          var room = _foundProducts?[index]
                                              ['attributes'];
                                          var type = room?['category'] != null
                                              ? room['name']
                                              : 'NIL';
                                          return RoomCard(
                                            room: _foundProducts?[index],
                                            onAction:
                                                (Map<String, dynamic> room,
                                                    BuildContext context) {
                                              setState(() {
                                                btnAction = "book_now";
                                                selectedRoom = {};
                                              });
                                              print(room);
                                              print("------------------");
                                              showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              10)),
                                                ),
                                                builder: (context) {
                                                  return RoomActionModal(
                                                    room: room,
                                                    onBookNow: () {
                                                      print(
                                                          "Book Now Clicked for ${room['attributes']['name']}");
                                                      setState(() {
                                                        selectedRoom = room;
                                                        btnAction = "book_now";
                                                      });
                                                    },
                                                    onEditBooking: () {
                                                      print(
                                                          "Edit Booking Clicked for ${room['attributes']['name']}");
                                                      setState(() {
                                                        selectedRoom = room;
                                                        btnAction =
                                                            "edit_booking";
                                                      });
                                                    },
                                                    onTransfer: () {
                                                      print(
                                                          "Transfer Clicked for ${room['attributes']['name']}");

                                                      setState(() {
                                                        selectedRoom = room;
                                                        btnAction =
                                                            "transfer_booking";
                                                      });
                                                    },
                                                    onMaintenanceReport: () {
                                                      print(
                                                          "Maintenance Report Clicked for ${room['attributes']['name']}");

                                                      setState(() {
                                                        selectedRoom = room;
                                                        btnAction =
                                                            "maintenance_report";
                                                      });
                                                    },
                                                    onFolioHistory: () {
                                                      setState(() {
                                                        selectedRoom = room;
                                                        btnAction =
                                                            "folio_history";
                                                      });
                                                    },
                                                  );
                                                },
                                              );

                                              playSound();
                                            },
                                            backgroundColor: room['color'] !=
                                                    null
                                                ? HexColor(
                                                    room['color'].toString())
                                                : HexColor("#279B0A"),
                                            name: room['name'].toString(),
                                            price: Money.format(room['price'])
                                                .toString(),
                                            type: type.toString(),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ])),
                      ),
                    ],
                  ),
                ),

                // Right Column: Order Summary
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SideContainer(
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
