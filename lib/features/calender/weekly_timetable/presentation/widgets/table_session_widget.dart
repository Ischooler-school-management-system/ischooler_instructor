import 'package:flutter/material.dart';

import '../../../../../common/common_features/widgets/ischooler_timeline_tile.dart';
import '../../../../../common/style/ischooler_colors.dart';
import '../../../../../common/style/ischooler_text_theme.dart';
import '../../../weekly_session/data/models/weekly_session_model.dart';

class TableSessionWidget extends StatelessWidget {
  final WeeklySessionModel session;
  final bool isFirst;
  final bool isLast;
  const TableSessionWidget({
    super.key,
    required this.session,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IschoolerTimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      endChild: Container(
        decoration: BoxDecoration(
          color: IschoolerColors.blue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(session.instructorAssignment.subjectModel?.name ??
              'unknown subject'),
          subtitle: Text(session.instructorAssignment.instructor?.name ??
              'unknown instructor'),
        ),
      ),
      startChild: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              session.startTime,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              session.endTime,
              style: IschoolerTextStyles.style12Blue
                  .copyWith(color: IschoolerColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
