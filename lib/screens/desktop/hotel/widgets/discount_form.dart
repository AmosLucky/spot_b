import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';

class DiscountFormScreen extends StatelessWidget {
  final TextEditingController amountController =
      TextEditingController(text: "0.03");
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
    text: DateFormat('MM/dd/yyyy').format(DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add Discount Form
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add Discount',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Discount Amount',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                            // Gap(5),
                            Container(
                              width: 200,
                              height: 45,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorsRes.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Expanded(
                                child: TextField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    // labelText: 'Discount Amount'
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              height: 45,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorsRes.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              width: 200,
                              child: TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  // labelText: 'Date'
                                ),
                                readOnly: true,
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    dateController.text =
                                        DateFormat('MM/dd/yyyy')
                                            .format(selectedDate);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsRes.grey),
                              borderRadius: BorderRadius.circular(5)),
                          width: 250,
                          child: TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Enter any note about the checkout',
                              hintStyle: TextStyle(fontSize: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "CSRF token mismatch.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "All discounts require approval by an administrator before they take effect.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: ColorsRes.cardpurple),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.percent,
                              color: Colors.white,
                              size: 10,
                            ),
                            Text(
                              "Add Discount",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Discount History
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Discount History",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: ColorsRes.cardpurple,
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh_outlined,
                          size: 10,
                          color: Colors.white,
                        ),
                        Text(
                          "Refresh",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorsRes.grey,
                    )),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 85,
                          decoration:
                              BoxDecoration(color: ColorsRes.bglightgrey),
                          child: Text(
                            '#',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Gap(5),
                        Text(
                          '1',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: ColorsRes.black,
                      thickness: 2,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 85,
                          decoration:
                              BoxDecoration(color: ColorsRes.bglightgrey),
                          child: Text(
                            'Date',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Gap(5),
                        Text(
                          '05/01/2025',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: ColorsRes.black,
                      thickness: 2,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 85,
                          decoration:
                              BoxDecoration(color: ColorsRes.bglightgrey),
                          child: Text(
                            'Amount',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Gap(5),
                        Text(
                          'N145000',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: ColorsRes.black,
                      thickness: 2,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 85,
                          decoration:
                              BoxDecoration(color: ColorsRes.bglightgrey),
                          child: Text(
                            'Description',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Gap(5),
                        Text(
                          '-',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: ColorsRes.black,
                      thickness: 2,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 85,
                          decoration:
                              BoxDecoration(color: ColorsRes.bglightgrey),
                          child: Text(
                            'Status',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Gap(5),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: ColorsRes.orange,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            'PENDING',
                            style: TextStyle(fontSize: 4, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: ColorsRes.black,
                      thickness: 2,
                      width: 1,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 104,
                          decoration:
                              BoxDecoration(color: ColorsRes.bglightgrey),
                          child: Text(
                            'Actions',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  // color: ColorsRes.orange,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(
                                Icons.thumb_up_alt,
                                size: 10,
                                color: Colors.green,
                              ),
                            ),
                            Gap(10),
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorsRes.red),
                                  color: ColorsRes.orange,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(
                                Icons.thumb_down,
                                size: 10,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // DataColumn _buildColumn(String label) {
  //   return DataColumn(
  //     label: Container(
  //       decoration: BoxDecoration(
  //         border: Border(right: BorderSide(color: Colors.grey.shade300)),
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 8),
  //       child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
  //     ),
  //   );
  // }

  // DataCell _buildCell(Widget child) {
  //   return DataCell(
  //     Container(
  //       decoration: BoxDecoration(
  //         border: Border(right: BorderSide(color: Colors.grey.shade300)),
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 8),
  //       child: child,
  //     ),
  //   );
  // }
}
