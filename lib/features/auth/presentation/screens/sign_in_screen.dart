import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/common_features/widgets/buttons/ischooler_button_export.dart';
import '../../../../common/common_features/widgets/ischooler_screen.dart';
import '../../../../common/ischooler_constants.dart';
import '../../../../common/navigation/router.export.dart';
import '../../../../common/style/ischooler_colors.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/signin_form.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isKeyboardOpen = false;
  @override
  Widget build(BuildContext context) {
    return IschoolerScreen(
      keepMobileView: true,
      alignment: Alignment.center,
      enableflexibleScrolling: true,
      body: Center(
        child: Column(
          children: [
            /// show and hide AuthHeaderWidget widget depending on the keyboard state
            Visibility(
              visible: !isKeyboardOpen,
              child: AuthHeaderWidget(
                height: IschoolerConstants.ischooler_screen_height * 0.25,
                width: IschoolerConstants.ischooler_screen_width,
                title: IschoolerConstants.localization().welcome,
                subTitle: IschoolerConstants.localization().sign_in_prompt,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0.h),
              child: Column(
                children: [
                  SigninForm(
                    onIsKeyboardOpenChanged: (bool value) {
                      isKeyboardOpen = value;
                    },
                  ),

                  // Spacer(),
                  SizedBox(height: 20.h),

                  /// show and hide signup button depending on the keyboard state
                  Visibility(
                    visible: !isKeyboardOpen,
                    child: IschoolerButton(
                      button: IschoolerTextButton(
                        onPressed: onSignupButtonPressed,
                        textButton: IschoolerConstants.localization().sign_up,
                        leadingText:
                            IschoolerConstants.localization().no_account_prompt,
                        color: IschoolerColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSignupButtonPressed() {
    IschoolerNavigator.push(Routes.signupScreen, replace: true);
  }
}
