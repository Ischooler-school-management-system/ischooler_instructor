import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/common_features/widgets/ischooler_screen.dart';
import '../../../../../common/ischooler_constants.dart';
import '../../../../../common/style/ischooler_colors.dart';
import '../../../../class_data/data/models/class_model.dart';
import '../../../../dashboard/logic/cubit/ischooler_list_cubit.dart';
import '../../../weekly_session/data/models/weekly_sessions_list_model.dart';
import '../../data/models/weekly_timetable_model.dart';
import '../../logic/cubit/weekly_timetable_cubit.dart';
import '../views/time_table_loaded_view.dart';

class TimeTableScreen extends StatefulWidget {
  final ClassDataModel classData;

  const TimeTableScreen({super.key, required this.classData});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  WeeklySessionsListModel weeklySessionsListModel =
      WeeklySessionsListModel.empty();
  @override
  void initState() {
    super.initState();
    // timetableResponseTest();
    context
        .read<WeeklyTimetableCubit>()
        .getItemByClassId(classId: widget.classData.id);
  }

  @override
  Widget build(BuildContext context) {
    return IschoolerScreen(
      showAppBar: true,
      appBar: AppBar(
        backgroundColor: IschoolerColors.blue,
        foregroundColor: IschoolerColors.white,
        title: Text(
          IschoolerConstants.localization().home,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WeeklyTimetableCubit, WeeklyTimetableState>(
        builder: (context, state) {
          WeeklyTimetableModel? timeTable;
          if (state.status == IschoolerStatus.loaded &&
              state.weeklyTimetableModel.id != '-1') {
            timeTable = state.weeklyTimetableModel;
          }
          if (timeTable != null) {
            return TimeTableLoadedView(timeTable: timeTable);
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
