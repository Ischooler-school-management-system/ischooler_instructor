import '../../../../../common/madpoly.dart';
import '../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../common/network/ischooler_network_helper.dart';
import '../../../profile/data/models/student_model.dart';
import '../network/auth_network.dart';

class AuthRepository {
  final AlertHandlingRepository _alertHandlingRepository;
  final AuthNetwork _authNetwork;
  AuthRepository(
    AlertHandlingRepository alertHandlingRepository,
    AuthNetwork authNetwork,
  )   : _alertHandlingRepository = alertHandlingRepository,
        _authNetwork = authNetwork;

  Future<StudentModel> signIn(
      {required String email, required String password}) async {
    StudentModel newUser = StudentModel.empty();

    try {
      var supabaseUser =
          await _authNetwork.signIn(email: email, password: password);
      Madpoly.print(
        'supabaseUser = $supabaseUser',
        tag: 'auth_repo > signUp',
        developer: "Ziad",
      );
      if (supabaseUser != null) {
        newUser = newUser.copyWith(id: supabaseUser.id);
      }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'auth_repo > sign in',
        showToast: true,
      );
    }
    return newUser;
  }

  Future<bool> signOut() async {
    try {
      await SupabaseCredentials.authInstance.signOut();
      Madpoly.print(
        'signing out now',
        tag: 'auth_repo > signOut',
        developer: "Ziad",
        showToast: true,
      );
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'auth_repo > signout',
        showToast: true,
      );
    }
    return SupabaseCredentials.authInstance.currentUser == null;
  }
}
