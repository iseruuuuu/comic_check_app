import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoListScreen extends StatelessWidget {
  const NoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Book is Empty',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.w,
            ),
          ),
          SizedBox(height: 60.w),
          Image.asset(
            'assets/images/no_list.png',
            width: 170.w,
            height: 170.w,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
