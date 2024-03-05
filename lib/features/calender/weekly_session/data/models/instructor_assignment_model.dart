// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../../common/ischooler_model.dart';
import '../../../../class_data/data/models/class_model.dart';
import 'instructor_model.dart';
import 'subject_model.dart';

class InstructorAssignmentModel extends IschoolerModel {
  final InstructorModel? instructor;
  final ClassDataModel? classModel;
  final SubjectModel? subjectModel;
  // final DateTime createdAt;

  const InstructorAssignmentModel({
    required super.id,
    required super.name,
    required this.instructor,
    required this.classModel,
    required this.subjectModel,
    // required this.createdAt,
  });

  factory InstructorAssignmentModel.empty() {
    return InstructorAssignmentModel(
      id: '',
      name: '',
      instructor: InstructorModel.empty(),
      classModel: ClassDataModel.empty(),
      subjectModel: SubjectModel.empty(),
      // createdAt: DateTime.parse(map['created_at']),
    );
  }
  factory InstructorAssignmentModel.dummy() {
    return InstructorAssignmentModel(
      id: '1',
      name: 'name',
      instructor: InstructorModel.dummy(),
      classModel: ClassDataModel.dummy(),
      subjectModel: SubjectModel.dummy(),
      // createdAt: DateTime.parse(map['created_at']),
    );
  }

  factory InstructorAssignmentModel.fromMap(Map<String, dynamic> map) {
    IschoolerModel ischoolerModel = IschoolerModel.fromMap(map);
    return InstructorAssignmentModel(
      id: ischoolerModel.id,
      name: ischoolerModel.name,
      instructor: map['instructor'] == null
          ? null
          : InstructorModel.fromMap(map['instructor']),
      classModel:
          map['class'] == null ? null : ClassDataModel.fromMap(map['class']),
      subjectModel:
          map['subject'] == null ? null : SubjectModel.fromMap(map['subject']),
      // createdAt: DateTime.parse(map['created_at']),
    );
  }
  @override
  Map<String, dynamic> toDisplayMap() {
    return {
      'Name': name,
      'Class': classModel == null ? '' : classModel!.name,
      'instrucor': instructor == null ? '' : instructor!.name,
      'subject': subjectModel == null ? '' : subjectModel!.name,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      if (instructor != null) "instructor_id": instructor!.id,
      if (subjectModel != null) "subject_id": subjectModel!.id,
      if (classModel != null) "class_id": classModel!.id,
    };
  }

  @override
  InstructorAssignmentModel copyWith({
    String? name,
    String? grade,
    InstructorModel? instructor,
    ClassDataModel? classModel,
    SubjectModel? subjectModel,
  }) {
    return InstructorAssignmentModel(
      id: id,
      name: name ?? this.name,
      instructor: instructor ?? this.instructor,
      classModel: classModel ?? this.classModel,
      subjectModel: subjectModel ?? this.subjectModel,
    );
  }

  @override
  String toString() =>
      'InstructorAssignmentModel(instructor: $instructor, classModel: $classModel, subjectModel: $subjectModel)';
}
