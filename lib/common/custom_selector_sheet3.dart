
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/secondar_bottomsheet.dart';


class CustomSelectorBottomSheet3 extends StatefulWidget {

  const CustomSelectorBottomSheet3({
    required this.height, required this.items, super.key,
    this.onSelect,
  });
  final double height;
  final List<dynamic> items;
  final Function(Map, int)? onSelect;

  @override
  State<CustomSelectorBottomSheet3> createState() => _CustomSelectorBottomSheet3State();
}

class _CustomSelectorBottomSheet3State extends State<CustomSelectorBottomSheet3> {
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
                          widget.onSelect!(widget.items[index], index);
                        }
                        Navigator.pop(context);
                      },
                      title: Text(
                        widget.items[index]['attributes']['name'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp
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
