import 'package:gotrue/src/types/user.dart';

import '../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../common/network/ischooler_network_helper.dart';

class AuthNetwork {
  final AlertHandlingRepository _alertHandlingRepository;

  AuthNetwork(AlertHandlingRepository alertHandlingRepository)
      : _alertHandlingRepository = alertHandlingRepository;

  // final FirebaseAuth instance = FirebaseAuth.instance;
  final instance = SupabaseCredentials.authInstance;

  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      final userCredential = await SupabaseCredentials.authInstance.signUp(
        email: email,
        password: password,
      );
      final User? supabaseUser = userCredential.user;
      if (supabaseUser != null) {
        return supabaseUser;
      }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'auth_network > signup',
        showToast: true,
      );
    }

    return null;
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      final userCredential =
          await SupabaseCredentials.authInstance.signInWithPassword(
        email: email,
        password: password,
      );
      final User? supabaseUser = userCredential.user;
      if (supabaseUser != null) {
        return supabaseUser;
      }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'auth_network > signin',
        showToast: true,
      );
      return null;
    }
    return null;
  }
}
