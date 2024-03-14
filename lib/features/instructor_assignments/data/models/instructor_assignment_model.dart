// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../common/ischooler_model.dart';
import '../../../calender/weekly_session/data/models/instructor_model.dart';
import '../../../calender/weekly_session/data/models/subject_model.dart';
import '/features/class_data/data/models/class_model.dart';

class InstructorAssignmentModel extends IschoolerModel {
  final InstructorModel? instructor;
  final ClassDataModel? classData;
  final SubjectModel? subjectModel;
  // final DateTime createdAt;

  const InstructorAssignmentModel({
    required super.id,
    required super.name,
    required this.instructor,
    required this.classData,
    required this.subjectModel,
    // required this.createdAt,
  });

  factory InstructorAssignmentModel.empty() {
    return InstructorAssignmentModel(
      id: '',
      name: '',
      instructor: InstructorModel.empty(),
      classData: ClassDataModel.empty(),
      subjectModel: SubjectModel.empty(),
      // createdAt: DateTime.parse(map['created_at']),
    );
  }
  factory InstructorAssignmentModel.dummy() {
    return InstructorAssignmentModel(
      id: '-1',
      name: 'name',
      instructor: InstructorModel.dummy(),
      classData: ClassDataModel.dummy(),
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
      classData:
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
      'Class': classData == null ? '' : classData!.name,
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
      if (classData != null) "class_id": classData!.id,
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
      classData: classModel ?? this.classData,
      subjectModel: subjectModel ?? this.subjectModel,
    );
  }

  @override
  String toString() =>
      'InstructorAssignmentModel(instructor: $instructor, classModel: $classData, subjectModel: $subjectModel)';
}
