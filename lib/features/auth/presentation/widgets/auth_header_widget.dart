import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/style/ischooler_text_theme.dart';

import '../../../../common/style/ischooler_colors.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? height;
  final double? width;

  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: IschoolerColors.blue,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(
            90.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: IschoolerTextStyles.style20White,
            ),
            Text(
              subTitle,
              style: IschoolerTextStyles.style14White,
            ),
          ],
        ),
      ),
    );
  }
}
