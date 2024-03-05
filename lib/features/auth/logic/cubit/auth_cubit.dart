import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common_features/loading/data/models/loading_model.dart';
import '../../../../common/common_features/loading/data/repo/loading_repo.dart';
import '../../../../common/madpoly.dart';
import '../../../profile/data/models/student_model.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final LoadingRepository _loadingRepository;

  AuthCubit(
    AuthRepository authRepository,
    LoadingRepository loadingRepository,
  )   : _authRepository = authRepository,
        _loadingRepository = loadingRepository,
        super(AuthState.init());

  Future<void> signIn({required String email, required String password}) async {
    _loadingRepository.startLoading(LoadingType.normal);
    StudentModel userModel =
        await _authRepository.signIn(email: email, password: password);
    if (userModel.id != '') {
      emit(state.updateAuth(userModel));
    }
    _loadingRepository.stopLoading();
  }

  Future<void> signOut() async {
    _loadingRepository.startLoading(LoadingType.normal);
    bool isUnauth = await _authRepository.signOut();
    if (isUnauth) {
      emit(state.updateUnauth());
    }
    _loadingRepository.stopLoading();
  }
}
