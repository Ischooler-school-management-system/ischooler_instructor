// ignore_for_file: use_super_parameters, overridden_fields

import 'package:collection/collection.dart';

import '../../../../../common/ischooler_model.dart';
import '../../../../../common/functions/ischooler_date_time_helper.dart';
import 'weekday_model.dart';

class WeekdaysListModel extends IschoolerListModel {
  const WeekdaysListModel({required super.items});
  factory WeekdaysListModel.empty() {
    return const WeekdaysListModel(items: []);
  }
  factory WeekdaysListModel.dummy() {
    return const WeekdaysListModel(items: [
      WeekdayModel(id: '1', name: 'Friday', isDayOff: true),
      WeekdayModel(id: '2', name: 'Saturday', isDayOff: true),
      WeekdayModel(id: '3', name: 'Sunday', isDayOff: false),
      WeekdayModel(id: '4', name: 'Monday', isDayOff: false),
      WeekdayModel(id: '5', name: 'Tuesday', isDayOff: false),
      WeekdayModel(id: '6', name: 'Wednesday', isDayOff: false),
      WeekdayModel(id: '7', name: 'Thursday', isDayOff: false)
      // Add more instances as needed
    ]);
  }

  @override
  WeekdayModel? getModelByName(String modelName) {
    WeekdayModel? firstWhereOrNull = (items as List<WeekdayModel>)
        .firstWhereOrNull((WeekdayModel item) => item.name == modelName);
    return firstWhereOrNull;
  }

  factory WeekdaysListModel.fromMap(Map map) {
    final List<WeekdayModel> items = List<WeekdayModel>.from(
      map['items'].map(
        (item) => WeekdayModel.fromMap(item),
      ),
    );
    return WeekdaysListModel(items: items);
  }

  WeekdayModel? getTodayItem() {
    String todayName = IschoolerDateTimeHelper.getTodayString();
    IschoolerModel? todayItem =
        items.firstWhereOrNull((element) => element.name == todayName);
    if (todayItem is WeekdayModel) {
      return todayItem;
    }
    return null;
  }
  /* factory WeekdaysListModel.fromMap(List<dynamic> json) {
    List<WeekdayModel> weekdays =
        json.map((dayJson) => WeekdayModel.fromMap(dayJson)).toList();
    return WeekdaysListModel(weekdays: weekdays);
  } */

  /*  List<Map<String, dynamic>> toMap() {
    return weekdays.map((weekday) => weekday.toMap()).toList();
  } */
}
