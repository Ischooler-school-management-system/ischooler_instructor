import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/functions/ischooler_date_time_helper.dart';
import '../../../../common/ischooler_constants.dart';
import '../../../../common/style/ischooler_colors.dart';
import '../../../calender/weekly_session/data/models/instructor_model.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final InstructorModel instructorData;

  const ProfileDetailsWidget({super.key, required this.instructorData});

  @override
  Widget build(BuildContext context) {
    final List<Widget> profileDetailsList = [
      // detailsRowWidget(
      //   IschoolerConstants.localization().the_class,
      //   instructorData.classData.name,
      // ),

      // /// grade
      // detailsRowWidget(
      //   IschoolerConstants.localization().grade,
      //   instructorData.classData.grade.name,
      // ),

      /// Roll Number
      detailsRowWidget(
        IschoolerConstants.localization().roll_number,
        instructorData.id,
      ),

      /// date of birth
      detailsRowWidget(
        IschoolerConstants.localization().date_of_birth,
        IschoolerDateTimeHelper.dateFormat(instructorData.dateOfBirth) ??
            'Unknown',
      ),

      /// Phone Number
      detailsRowWidget(
        IschoolerConstants.localization().phone_number,
        instructorData.phoneNumber,
      ),

      /// Address
      detailsRowWidget(
        IschoolerConstants.localization().address,
        instructorData.address,
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.w,
              // vertical: 24.w,
            ),
            child: Text(
              // 'Student Detail',
              // 'بيانات الطالب',
              IschoolerConstants.localization().instructor_detail,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 12.w,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: IschoolerColors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: profileDetailsList,
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsRowWidget(String title, String data) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0.w,
          vertical: 10.0.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                // color: IschoolerColors.lightBlack,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                data,
                style: const TextStyle(
                  fontSize: 16,
                  // color: IschoolerColors.lightBlack,
                ),
              ),
            ),
          ],
        ));
  }
}
