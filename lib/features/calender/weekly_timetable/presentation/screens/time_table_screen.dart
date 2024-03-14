import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/common_features/widgets/ischooler_screen.dart';
import '../../../../../common/ischooler_constants.dart';
import '../../../../../common/style/ischooler_colors.dart';
import '../../../weekly_session/data/models/weekly_sessions_list_model.dart';
import '../../../weekly_session/logic/cubit/weekly_sessions_cubit.dart';
import '../views/time_table_loaded_view.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({
    super.key,
  });

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  WeeklySessionsListModel weeklySessionsListModel =
      WeeklySessionsListModel.empty();
  @override
  void initState() {
    super.initState();
    // context.read<WeeklyTimetableCubit>().getItemByClassId();
    context.read<WeeklySessionsCubit>().getAllItems(
        // classId: widget.timeTable.id,
        // weekdayId: selectedWeekday!.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return IschoolerScreen(
      showAppBar: true,
      appBar: AppBar(
        backgroundColor: IschoolerColors.blue,
        foregroundColor: IschoolerColors.white,
        title: Text(
          IschoolerConstants.localization().timetable,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: const TimeTableLoadedView(),
    );
  }
}
