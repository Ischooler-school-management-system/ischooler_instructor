import '../../../calender/weekly_session/data/models/user_model.dart';
import '../../../class_data/data/models/class_model.dart';

class StudentModel extends UserModel {
  final ClassDataModel classData;
  final bool paymentStatus;

  const StudentModel({
    required super.id,
    required super.dateOfBirth,
    required super.phoneNumber,
    required super.address,
    required super.gender,
    required super.email,
    required super.role,
    required super.name,
    required super.profilePicture,
    required this.classData,
    required this.paymentStatus,
  });
  @override
  factory StudentModel.empty() {
    return StudentModel(
        id: '-1',
        name: '',
        classData: ClassDataModel.empty(),
        // gradeModel: GradeModel.empty(),
        dateOfBirth: null,
        phoneNumber: '',
        address: '',
        gender: '',
        email: '',
        // displayName: '',
        paymentStatus: false,
        role: UserRole.student,
        profilePicture: '');
  }
  @override
  factory StudentModel.dummy() {
    return StudentModel(
      id: '',
      name: 'ziad',
      classData: ClassDataModel.empty(),
      // gradeModel: GradeModel.empty(),
      dateOfBirth: null,
      phoneNumber: '0123786323',
      address: 'a .main b',
      gender: 'male',
      email: 'user@mail.com',
      // displayName: '',
      role: UserRole.student,
      paymentStatus: false,
      profilePicture: '',
    );
  }
  factory StudentModel.fromMap(Map<String, dynamic> map) {
    UserModel userModel =
        UserModel.fromMap(map).copyWith(role: UserRole.student);

    return StudentModel(
      id: userModel.id,
      name: userModel.name,
      dateOfBirth: userModel.dateOfBirth,
      phoneNumber: userModel.phoneNumber,
      address: userModel.address,
      gender: userModel.gender,
      email: userModel.email,
      role: userModel.role,
      profilePicture: userModel.profilePicture,
      classData: ClassDataModel.fromMap(map['class'] ?? {}),
      paymentStatus: map['payment_status'] ?? false,
    );
  }
  @override
  Map<String, dynamic> toDisplayMap() {
    return {
      'Student Name': name,
      'Class': classData.name,
      'Grade': classData.grade.name,
    };
  }

  StudentModel copyFromUser(UserModel userModel) {
    return copyWith(
      id: userModel.id,
      name: userModel.name,
      dateOfBirth: userModel.dateOfBirth,
      phoneNumber: userModel.phoneNumber,
      address: userModel.address,
      gender: userModel.gender,
      email: userModel.email,
      role: userModel.role,
      profilePicture: userModel.profilePicture,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> userMap = super.toMap();
    return {
      ...userMap,
      'class_id': classData.id,
      'payment_status': paymentStatus,
    };
  }

  @override
  StudentModel copyWith({
    String? id,
    String? name,
    DateTime? dateOfBirth,
    ClassDataModel? classModel,
    String? phoneNumber,
    String? address,
    bool? paymentStatus,
    String? gender,
    String? email,
    // String? displayName,
    UserRole? role,
    String? profilePicture, // Add this line
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      classData: classModel ?? classData,
      // gradeModel: gradeModel ?? this.gradeModel,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      // // // displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      profilePicture: profilePicture ?? this.profilePicture, // Add this line
    );
  }

  @override
  String toString() {
    return 'StudentModel{studentId: $id, name: $name, dateOfBirth: $dateOfBirth, '
        'classId: $classData, phoneNumber: $phoneNumber, address: $address, '
        'paymentStatus: $paymentStatus, gender: $gender, email: $email, role: ${role.name}}';
  }

  @override
  List<Object?> get props {
    return [
      dateOfBirth,
      phoneNumber,
      address,
      gender,
      email,
      name,
      role,
      name,
      classData,
      /* gradeModel, */ paymentStatus,
    ];
  }
}
