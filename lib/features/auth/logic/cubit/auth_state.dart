// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AuthStatus { init, authenticated, unauthenticated }

class AuthState extends Equatable {
  final StudentModel user;
  final AuthStatus status;

  const AuthState({
    required this.user,
    required this.status,
  });

  factory AuthState.init() {
    return AuthState(
      status: AuthStatus.init,
      user: StudentModel.empty(),
    );
  }

  AuthState updateAuth(StudentModel user) {
    var copyWith = _copyWith(
      status: AuthStatus.authenticated,
      user: user,
    );
    Madpoly.print(
      'new state = $copyWith',
      tag: 'auth_state > updateauth',
      developer: "Ziad",
    );
    return copyWith;
  }

  AuthState updateUnauth() {
    var copyWith = _copyWith(
      user: StudentModel.empty(),
      status: AuthStatus.unauthenticated,
    );
    Madpoly.print(
      'new state = $copyWith',
      tag: 'auth_state > updateUnauth',
      developer: "Ziad",
    );
    return copyWith;
  }

  // AuthState updateRole(UserRole role) {
  //   var copyWith = _copyWith(
  //     user: StudentModel.empty().copyWith(role: role),
  //     status: AuthStatus.init,
  //   );
  //   Madpoly.print(
  //     'new state = $copyWith',
  //     tag: 'auth_state > updateRole',
  //     developer: "Ziad",
  //   );
  //   return copyWith;
  // }

  AuthState _copyWith({
    AuthStatus? status,
    StudentModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  bool isAuthenticated() => status == AuthStatus.authenticated;
  bool isUnauthenticated() => status == AuthStatus.unauthenticated;
  @override
  List<Object> get props => [status, user];
}
