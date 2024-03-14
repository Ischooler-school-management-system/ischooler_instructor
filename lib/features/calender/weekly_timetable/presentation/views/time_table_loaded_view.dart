import 'package:flutter/material.dart';

import '../../../../../common/madpoly.dart';
import '../../../weekday/data/models/weekday_model.dart';
import '../widgets/day_table_widget.dart';

class TimeTableLoadedView extends StatefulWidget {
  const TimeTableLoadedView({super.key});

  @override
  State<TimeTableLoadedView> createState() => _TimeTableLoadedViewState();
}

class _TimeTableLoadedViewState extends State<TimeTableLoadedView> {
  WeekdayModel? selectedWeekday;
  // WeekdaysListModel weekdaysListModel = WeekdaysListModel.empty();

  @override
  Widget build(BuildContext context) {
    Madpoly.print(
      'building',
      tag: 'time_table_loaded_view > ',
      developer: "Ziad",
    );
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                const Expanded(
                  child: DayTableWidget(),
                ),
              }
            ],
          ),
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
        // context.read<WeeklySessionsCubit>().getAllItems(
        //       classId: widget.timeTable.id,
        //       weekdayId: selectedWeekday!.id,
        //     );
      }
      // setState(() {});
    }
  }
}
