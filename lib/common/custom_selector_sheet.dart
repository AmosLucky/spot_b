
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/secondar_bottomsheet.dart';


class CustomSelectorBottomSheet extends StatefulWidget {

  const CustomSelectorBottomSheet({
    required this.height, required this.items, super.key,
    this.onSelect,
  });
  final double height;
  final List<dynamic> items;
  final Function(String, int)? onSelect;

  @override
  State<CustomSelectorBottomSheet> createState() => _CustomSelectorBottomSheetState();
}

class _CustomSelectorBottomSheetState extends State<CustomSelectorBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SecondaryBottomSheet(
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const PageScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      onTap: () {
                        if (widget.onSelect != null) {
                          widget.onSelect!(widget.items[index]['attributes']['name'], index);
                        }
                        Navigator.pop(context);
                      },
                      title: Text(
                        widget.items[index]['attributes']['name'] + " " + "(" + widget.items[index]['attributes']['price'].toString() + ")",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                thickness: 1,
                color: Colors.black.withOpacity(0.2),
              ),
              itemCount: widget.items.length,),
          ),
        ],
      ),
    );
  }
}
