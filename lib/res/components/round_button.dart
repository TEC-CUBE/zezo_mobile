import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zezo/res/color.dart';
// import 'package:zezo/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 45.h,
        width: 250.w,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 30, 99, 196),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}
