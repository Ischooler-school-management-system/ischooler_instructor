import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import '../../../../common/ischooler_model.dart';
import 'class_model.dart';

class ClassesListModel extends IschoolerListModel {
  const ClassesListModel({required List<ClassDataModel> items})
      : super(items: items);

  factory ClassesListModel.empty() {
    return const ClassesListModel(items: []);
  }
  factory ClassesListModel.dummy() {
    return ClassesListModel(items: [
      ClassDataModel.dummy(),
      ClassDataModel.dummy(),
      ClassDataModel.dummy(),
      ClassDataModel.dummy(),
    ]);
  }
  factory ClassesListModel.fromMap(Map map) {
    List<Map<String, dynamic>> list =
        (map['items'] != null && map['items'] is List<Map<String, dynamic>>)
            ? map['items']
            : [];

    final List<ClassDataModel> items = List<ClassDataModel>.from(
      list.map(
        (item) {
          return ClassDataModel.fromMap(item);
        },
      ),
    );

    return ClassesListModel(items: items);
    // return ClassesListModel.dummy();
  }

  // Function to get a model by name
  @override
  ClassDataModel? getModelByName(String modelName) {
    ClassDataModel? firstWhereOrNull = (items as List<ClassDataModel>)
        .firstWhereOrNull((ClassDataModel item) => item.name == modelName);
    return firstWhereOrNull;
  }
}
