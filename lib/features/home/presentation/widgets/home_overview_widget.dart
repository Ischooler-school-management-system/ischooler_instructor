import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ischooler_instructor/common/ischooler_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../common/common_features/widgets/ischooler_image_widget.dart';
import '../../../../common/style/ischooler_colors.dart';
import '../../../profile/data/models/student_model.dart';

class HomeOverviewWidget extends StatelessWidget {
  final StudentModel studentData;

  const HomeOverviewWidget({
    super.key,
    required this.studentData,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: Container(
        // alignment: Alignment.bottomCenter,
        height: IschoolerConstants.ischooler_screen_height / 6,
        margin: const EdgeInsets.symmetric(
          // horizontal: 20.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          color: IschoolerColors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          // padding: const EdgeInsets.symmetric(
          //   horizontal: 12.0,
          //   vertical: 8.0,
          // ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customListTile(
                title: Text(
                  'مرحبا ${studentData.name}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  '${studentData.classData.grade.name} | ${studentData.classData.name}',
                  style: const TextStyle(
                      color: IschoolerColors.darkWhite, fontSize: 16),
                ),
                // trailing: CircleAvatar(
                //   radius: 25,
                //   backgroundImage: AssetImage(
                //     IschoolerAssets.blankProfileImage,
                //   ),
                // ),
                trailing: IschoolerImageWidget(
                  circleAvatarRadius: 25.r,
                  url: studentData.profilePicture,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التقدم',
                    style: TextStyle(
                        color: IschoolerColors.darkWhite, fontSize: 14),
                  ),
                  Text(
                    '80%',
                    style: TextStyle(
                        color: IschoolerColors.darkWhite, fontSize: 14),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: LinearProgressIndicator(
                  value: 0.8,
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                  backgroundColor: Colors.grey,
                ),
              ),
              // const SizedBox(height: 4)
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile({
    required Widget title,
    Widget? subtitle,
    Widget? trailing,
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title,
              if (subtitle != null) ...[
                const SizedBox(height: 8.0),
                subtitle,
              ],
            ],
          ),
        ),
        if (trailing != null) trailing
      ],
    );
  }
}
