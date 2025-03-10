import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SecondaryBottomSheet extends StatefulWidget {
  final Widget child;
  final double height;
  final bool displayClose;

  const SecondaryBottomSheet(
      {Key? key,
        required this.child,
        required this.height,
        this.displayClose = true})
      : super(key: key);

  @override
  State<SecondaryBottomSheet> createState() => _SecondaryBottomSheetState();
}

class _SecondaryBottomSheetState extends State<SecondaryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom, top: 10),
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.5.h,),
            // Center(
            //   child: Container(
            //     height: 0.7.h,
            //     width: 20.w,
            //     decoration: BoxDecoration(
            //         color: Colors.grey.withOpacity(0.5),
            //         borderRadius: BorderRadius.circular(20)
            //     ),
            //   ),
            // ),

            widget.displayClose ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder( borderRadius: BorderRadius. circular(20),),
                      onTap: () {},
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                            backgroundColor:  Color(0xffE6F3FF),
                            radius: 18,
                            child: Icon(Icons.close, color: Colors.black, size: 20,)),
                      ),
                    ),
                  ),
                ],
              ),
            ) : SizedBox(),

            //SizedBox(height: 1.h,),
            Expanded(
              child: Container(
                //padding: const EdgeInsets.symmetric(horizontal: 30),
                child: widget.child,
              ),
            )],
        ),
      ),
    );
  }
}
