import '../../../../common/ischooler_model.dart';
import '../../../grades/data/models/grade_model.dart';

class ClassDataModel extends IschoolerModel {
  final GradeModel grade;

  const ClassDataModel({
    required super.id,
    required super.name,
    required this.grade,
    // required super.createdAt,
  });

  factory ClassDataModel.empty() {
    return ClassDataModel(
      id: '-1',
      name: '',
      grade: GradeModel.empty(),
      // createdAt: DateTime.now(),
    );
  }

  factory ClassDataModel.dummy() {
    return ClassDataModel(
      id: '1',
      name: 'Class 1',
      grade: GradeModel.dummy(),
      // createdAt: DateTime.now(),
    );
  }

  factory ClassDataModel.fromMap(Map<String, dynamic> map) {
    IschoolerModel ischoolerModel = IschoolerModel.fromMap(map);
    return ClassDataModel(
      id: ischoolerModel.id,
      name: ischoolerModel.name,
      grade: GradeModel.fromMap(map['grade'] ?? {}),
      // createdAt: DateTime.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'grade_id': grade.id,
    };
  }

  @override
  Map<String, dynamic> toDisplayMap() {
    return {
      'Class Name': name,
      'Grade': grade.name,
    };
  }

  @override
  ClassDataModel copyWith({
    String? name,
    GradeModel? grade,
  }) {
    return ClassDataModel(
      id: id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
      // // createdAt: createdAt,
    );
  }
}
