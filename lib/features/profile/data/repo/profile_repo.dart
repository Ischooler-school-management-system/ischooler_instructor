import '../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../common/ischooler_model.dart';
import '../../../../common/madpoly.dart';
import '../../../../common/network/ischooler_response.dart';
import '../../../calender/weekly_session/data/models/instructor_model.dart';
import '../../../dashboard/data/repo/ischooler_repository_interface.dart';
import '../network/profile_network.dart';

class ProfileRepository implements IschoolerRepository {
  final AlertHandlingRepository _alertHandlingRepository;
  final ProfileNetwork _adminNetwork;

  ProfileRepository(AlertHandlingRepository alertHandlingRepository,
      ProfileNetwork adminNetwork)
      : _alertHandlingRepository = alertHandlingRepository,
        _adminNetwork = adminNetwork;

  @override
  Future<IschoolerModel> getItem({required String id}) async {
    IschoolerModel listModel = IschoolerModel.empty();
    Madpoly.print(
      ' id >> $id',
      tag: 'repo > getAllItems ',
      developer: "Ziad",
      // showToast: true,
    );
    try {
      IschoolerResponse response = await _adminNetwork.getItem(id: id);
      // if (response.hasData) {

      listModel = InstructorModel.fromMap(response.data);
      Madpoly.print(
        'response = ',
        color: MadpolyColor.green,
        inspectObject: listModel,
        tag: 'profile_repo > getAllItems',
        developer: "Ziad",
      );
      _alertHandlingRepository.addError(
        'data retrieved successfully',
        AlertHandlingTypes.Alert,
        tag: 'profile_repo > getAllItems',
        // showToast: true,
      );
      // }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'profile_repo > getAllItems',
        showToast: true,
      );
    }
    return listModel;
  }

  @override
  Future<bool> updateItem({required IschoolerModel model}) async {
    bool requestSuccess = false;
    try {
      bool successfulRequest = await _adminNetwork.updateItem(model: model);
      if (successfulRequest) {
        _alertHandlingRepository.addError(
          'Data Updated Successfully',
          AlertHandlingTypes.Alert,
          tag: 'profile_repo > updateItem',
          // showToast: true,
        );
        requestSuccess = true;
      } else {
        throw Exception('unable to add user');
      }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'profile_repo > updateItem',
        showToast: true,
      );
    }
    return requestSuccess;
  }
}
