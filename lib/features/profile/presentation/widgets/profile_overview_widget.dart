import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common_features/widgets/ischooler_image_widget.dart';
import '../../../../common/ischooler_constants.dart';
import '../../../../common/style/ischooler_colors.dart';
import '../../../calender/weekly_session/data/models/instructor_model.dart';

class ProfileOverviewWidget extends StatelessWidget {
  final InstructorModel instructorData;
  const ProfileOverviewWidget({
    super.key,
    required this.instructorData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: IschoolerConstants.ischooler_screen_height / 3.2,
      child: Stack(
        children: [
          /// background curved blue container
          Container(
            height: IschoolerConstants.ischooler_screen_height / 5,
            decoration: BoxDecoration(
              color: IschoolerColors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35.r),
                bottomRight: Radius.circular(35.r),
                topLeft: Radius.zero,
                topRight: Radius.zero,
              ),
            ),
          ),

          /// background white container that contains the description
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 18.w,
              ),
              height: IschoolerConstants.ischooler_screen_height / 4.5,
              decoration: BoxDecoration(
                color: IschoolerColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w,
                        vertical: 4.0.h,
                      ),
                      child: const Text(
                        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor',
                        style: TextStyle(
                          fontSize: 14,
                          color: IschoolerColors.lightBlack,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// image and name and profile picture
          Align(
            alignment: const Alignment(0.0, -0.4),
            child: SizedBox(
              height: IschoolerConstants.ischooler_screen_height / 4.5,
              child: Column(
                children: [
                  IschoolerImageWidget(
                    circleAvatarRadius: 40.r,
                    url: instructorData.profilePicture,
                  ),
                  Text(
                    instructorData.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    instructorData.specialization,
                    style: const TextStyle(
                      fontSize: 16,
                      color: IschoolerColors.lightBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
