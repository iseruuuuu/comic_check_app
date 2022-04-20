import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key? key,
    required this.hintText,
    required this.maxLength,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final int maxLength;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 80.w,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 20.w,
          fontWeight: FontWeight.bold,
        ),
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 3,
              color: CupertinoColors.systemGrey4,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 3,
              color: CupertinoColors.destructiveRed,
            ),
          ),
        ),
        maxLength: maxLength,
      ),
    );
  }
}
