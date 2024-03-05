import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../common/navigation/router.export.dart';
import '../common/network/ischooler_network_helper.dart';
import '../common/style/ischooler_theme_data.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/settings/language/language_bloc/language_bloc.dart';
import '../generated/l10n.dart';
import '../ischooler_bottom_navbar.dart';

class IschoolerMaterialApp extends StatelessWidget {
  final AsyncSnapshot<int> languageSnapshot;
  final int currentLang;

  const IschoolerMaterialApp({
    super.key,
    required this.languageSnapshot,
    required this.currentLang,
  });
  static final BehaviorSubject<int> languageSubject =
      BehaviorSubject<int>.seeded(-1);

  Locale localeMethod(LangState state) {
    if (state is LangUpdated) {
      return decideLanguage(state.updatedLang);
    } else {
      return decideLanguage(currentLang);
    }
  }

  Locale decideLanguage(int langIndex) {
    if ((langIndex == 1)) {
      return const Locale('en', '');
    } else {
      return const Locale('ar', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangBloc, LangState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Educonnect',
          // material app initial settings
          // 1. localization(3)
          locale: localeMethod(state),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          // ----------------------------------

          //   3. themes
          theme: buildThemeData(),
          // ----------------------------------

          // 8. custom navigator
          navigatorKey: IschoolerNavigator.navigatorState,
          onGenerateRoute: IschoolerNavigator.onCreateRoute,
          // ----------------------------------

          // to remove the debug banner showed in the screen
          debugShowCheckedModeBanner: false,

          // home: const IschoolerBottomNavbar(),
          home: startingScreen(),

          ///4. smart dialog:
          /// FlutterSmartDialog is a package that provide dialogs and toasts without a context
          builder: materialAppBuilder(),
        );
        // });
      },
    );
  }

  Widget startingScreen() {
    // if (IschoolerConstants.testMode) {
    //   return const TestScreen();
    // } else {
    User? user = SupabaseCredentials.authInstance.currentUser;
    if (user != null) {
      return const IschoolerBottomNavbar();
    } else {
      return const SigninScreen();
    }
  }
  // return const TestScreen();
  // }
}

TransitionBuilder materialAppBuilder() {
  return FlutterSmartDialog.init(
    // this part makes the font of the app doesn't affect with the device font size
    builder: (context, child) {
      final mediaQueryData = MediaQuery.of(context);

      /// 2. fixed scale:
      ///  here we check if the app opened on tablet to make the scale 0.8
      /// because the tablet font is big when the scale is 1
      bool isTablet = mediaQueryData.size.width > 600;
      return MediaQuery(
        data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(isTablet ? 1.1 : 1.0)),
        child: child ?? const SizedBox(),
      );
    },
  );
}
