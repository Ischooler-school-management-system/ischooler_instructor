import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/common_features/widgets/buttons/ischooler_button_export.dart';
import 'common/common_features/widgets/ischooler_screen.dart';
import 'common/common_features/widgets/ischooler_navbar_item.dart';
import 'common/ischooler_constants.dart';
import 'common/madpoly.dart';
import 'common/style/ischooler_colors.dart';
import 'features/calender/weekly_timetable/presentation/screens/time_table_screen.dart';
import 'features/dashboard/logic/cubit/ischooler_list_cubit.dart';
import 'features/profile/data/models/student_model.dart';
import 'features/profile/logic/cubit/profile_cubit.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';

// ischooler_bottom_navbar
class IschoolerBottomNavbar extends StatefulWidget {
  const IschoolerBottomNavbar({super.key});

  @override
  State<IschoolerBottomNavbar> createState() => _IschoolerBottomNavbarState();
}

class _IschoolerBottomNavbarState extends State<IschoolerBottomNavbar> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProfileCubit>()
        .getItem(id: '9cb0a9f3-5e00-4cb7-b4f8-9762873924ff');
  }

  int _currentIndex = 0;
  screensBuilder(StudentModel studentData) {
    final List<Widget> screens = [
      HomeScreen(studentData: studentData),
      TimeTableScreen(classData: studentData.classData),
      ProfileScreen(studentData: studentData),
    ];
    return screens[_currentIndex];
  }

  List<({Widget icon, String title})> tabsData = [
    (
      icon: const Icon(Icons.home, color: Colors.white),
      title: IschoolerConstants.localization().home,
    ),
    (
      icon: const Icon(Icons.calendar_month_outlined, color: Colors.white),
      title: IschoolerConstants.localization().calender,
    ),
    (
      icon: const Icon(Icons.person, color: Colors.white),
      title: IschoolerConstants.localization().profile,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Madpoly.print('Building Screen',
        developer: 'ziad', tag: 'MawjoodBottomNavBar', isLog: true);

    return IschoolerScreen(
      body: Stack(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
            StudentModel studentData = StudentModel.empty();
            if (state.status == IschoolerStatus.loaded &&
                state.ischoolerModel is StudentModel) {
              studentData = state.ischoolerModel as StudentModel;
            }
            return Positioned.fill(child: screensBuilder(studentData));
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: navBar(),
          ),
          // screens[_currentIndex],
        ],
      ),
    );
  }

  Container navBar() {
    return Container(
      // alignment: Alignment.bottomCenter,
      height: 60,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: IschoolerColors.blue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabsData.asMap().entries.map((entry) {
          var e = entry.value;
          var index = entry.key;
          return IschoolerButton(
              button: IschoolerContainerButton(
            child: IschoolerNavbarItem(
              icon: e.icon,
              title: e.title,
              isSelected: index == _currentIndex,
            ),
            onPressed: () {
              _currentIndex = index;
              setState(() {});
            },
            color: (index == _currentIndex)
                ? IschoolerColors.white.withOpacity(0.2)
                : null,
            padding: const EdgeInsets.all(8),
            borderRadius: 30,
          ));
        }).toList(),
      ),
    );
  }
}
