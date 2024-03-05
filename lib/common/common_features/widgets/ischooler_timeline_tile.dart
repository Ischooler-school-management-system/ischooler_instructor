import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../style/ischooler_colors.dart';

class IschoolerTimelineTile extends StatelessWidget {
  final bool hasIndicator;
  final Widget? endChild;
  final Widget? startChild;
  final bool isFirst;
  final bool isLast;
  const IschoolerTimelineTile({
    super.key,
    this.hasIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    this.endChild,
    this.startChild,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      hasIndicator: hasIndicator,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle:
          const IndicatorStyle(width: 10, color: IschoolerColors.blue),
      beforeLineStyle: const LineStyle(color: IschoolerColors.blue),
      alignment: TimelineAlign.manual,
      lineXY: 0.25,
      endChild: endChild,
      startChild: startChild,
    );
  }
}
