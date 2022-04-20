import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickerItem extends StatelessWidget {
  const PickerItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.fontSize,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300.w,
        height: 70.w,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey4,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            children: [
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                '▼',
                style: TextStyle(
                  fontSize: 30.w,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
