import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common_features/widgets/buttons/ischooler_button.dart';
import '../../../../common/common_features/widgets/buttons/models/buttons_model.dart';
import '../../../../common/style/ischooler_colors.dart';

class HomeShortcutButton extends StatelessWidget {
  final String title;
  final Widget icon;
  const HomeShortcutButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IschoolerButton(
      button: IschoolerContainerButton(
        child: Column(
          children: [
            Container(
              // alignment: Alignment.bottomCenter,
              height: 45.h,
              width: 45.h,
              margin: const EdgeInsets.symmetric(
                // horizontal: 20.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: IschoolerColors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: icon,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
