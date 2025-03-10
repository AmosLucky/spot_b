import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class SecondaryCustomDropDown extends StatefulWidget {
  final String? hintText;
  final String? titleText;
  final String? image;
  final Function()? onTap;
  final Color? color;
  const SecondaryCustomDropDown({super.key, required this.hintText, required this.titleText, required this.onTap, this.image = "assets/icons/pngs/data_icon.png", this.color = const Color(0xffF5F6F7)});

  @override
  State<SecondaryCustomDropDown> createState() => _SecondaryCustomDropDownState();
}

class _SecondaryCustomDropDownState extends State<SecondaryCustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.2.h,),

          if(widget.titleText != '')Text(
            widget.titleText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  child: Row(
                    children: [
                      /*Container(
                        height: 4.h,
                        width: 5.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(image!),
                          ),
                        ),
                      ),*/

                      //SizedBox(width: 2.w,),

                      SizedBox(
                        width: 20.w,
                        child: Text(widget.hintText!, style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 12.sp
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 40,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
