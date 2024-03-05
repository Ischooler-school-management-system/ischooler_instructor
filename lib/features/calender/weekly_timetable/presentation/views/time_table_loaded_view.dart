import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/common_features/widgets/ischooler_drop_down_widget.dart';
import '../../../../../common/ischooler_model.dart';
import '../../../../../common/madpoly.dart';
import '../../../../dashboard/logic/cubit/ischooler_list_cubit.dart';
import '../../../weekday/data/models/weekday_model.dart';
import '../../../weekday/data/models/weekdays_list_model.dart';
import '../../../weekday/logic/cubit/weekday_cubit.dart';
import '../../../weekly_session/logic/cubit/weekly_sessions_cubit.dart';
import '../../data/models/weekly_timetable_model.dart';
import '../widgets/day_table_widget.dart';

class TimeTableLoadedView extends StatefulWidget {
  final WeeklyTimetableModel timeTable;

  const TimeTableLoadedView({
    super.key,
    required this.timeTable,
  });

  @override
  State<TimeTableLoadedView> createState() => _TimeTableLoadedViewState();
}

class _TimeTableLoadedViewState extends State<TimeTableLoadedView> {
  WeekdayModel? selectedWeekday;
  // WeekdaysListModel weekdaysListModel = WeekdaysListModel.empty();

  @override
  void initState() {
    super.initState();
    context.read<WeekdaysCubit>().getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    Madpoly.print(
      'building',
      tag: 'time_table_loaded_view > ',
      developer: "Ziad",
    );
    return BlocBuilder<WeekdaysCubit, IschoolerListState>(
      builder: (context, state) {
        WeekdaysListModel weekdaysListModel = WeekdaysListModel.empty();
        if (state.isLoaded() && state.ischoolerAllModel is WeekdaysListModel) {
          weekdaysListModel = state.ischoolerAllModel as WeekdaysListModel;
        }
        if (selectedWeekday == null) {
          selectedWeekday = weekdaysListModel.getTodayItem();
          // setState(() {});
          getWeeklySessions(selectedWeekday);
        }
        List<String> options = weekdaysListModel.getItemNames();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              EduconnectDropdownWidget(
                // labelText: ,
                hint: selectedWeekday?.name ?? 'select a day',
                onChanged: (value) {
                  if (value != null && value != '') {
                    IschoolerModel? selectedData =
                        weekdaysListModel.getModelByName(value);
                    if (selectedData != null) {
                      getWeeklySessions(selectedData);
                      // widget.onChanged(selectedData);
                    }
                  }
                  setState(() {});
                },
                options: options,
              ),
              if (selectedWeekday == null) ...{
                const Expanded(
                  child: Center(
                    child: Text('No day selected'),
                  ),
                )
              } else if (selectedWeekday!.isDayOff) ...{
                Expanded(
                  child: Center(
                    child: Text('${selectedWeekday!.name} is Day off'),
                  ),
                )
              } else ...{
                Expanded(
                  child: DayTableWidget(timeTable: widget.timeTable),
                ),
              }
            ],
          ),
        );
      },
    );
  }

  getWeeklySessions(weekday) async {
    Madpoly.print(
      'weekday = $weekday',
      tag: 'time_table_loaded_view > ',
      developer: "Ziad",
    );
    if (weekday is WeekdayModel) {
      selectedWeekday = weekday;
      if (selectedWeekday != null && !selectedWeekday!.isDayOff) {
        context.read<WeeklySessionsCubit>().getAllItems(
              classId: widget.timeTable.id,
              weekdayId: selectedWeekday!.id,
            );
      }
      // setState(() {});
    }
  }
}
