import '../../../../../common/common_features/loading/data/models/loading_model.dart';
import '../../../../../common/common_features/loading/data/repo/loading_repo.dart';
import '../../../../../common/ischooler_model.dart';
import '../../../../../common/madpoly.dart';
import '../../../dashboard/logic/cubit/ischooler_cubit.dart';
import '../../../dashboard/logic/cubit/ischooler_list_cubit.dart';
import '../../../dashboard/logic/cubit/ischooler_state.dart';
import '../../data/models/student_model.dart';
import '../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends IschoolerCubit<ProfileState> {
  final ProfileRepository _profileRepository;
  final LoadingRepository _loadingRepository;

  ProfileCubit(
    ProfileRepository profileRepository,
    LoadingRepository loadingRepository,
  )   : _profileRepository = profileRepository,
        _loadingRepository = loadingRepository,
        super(ProfileState.init());

  @override
  Future<void> getItem({required String id}) async {
    _loadingRepository.startLoading(LoadingType.normal);
    IschoolerModel response =
        //model is sent here to get the type of request only
        await _profileRepository.getItem(id: id);
    if (response is StudentModel) {
      emit(state.updateData(response));
    } else {
      Madpoly.print(
        'incorrect model >> ${response.runtimeType}',
        tag: 'profiles_list_cubit > ',
        showToast: true,
        developer: "Ziad",
      );
    }
    _loadingRepository.stopLoading();
  }

  @override
  Future<void> addItem({required IschoolerModel model}) async {
    _loadingRepository.startLoading(LoadingType.normal);
    await _profileRepository.addItem(model: model);
    emit(state.updateStatus());
    // await getAllItems();
    // _loadingRepository.stopLoading();
  }

  @override
  Future<void> updateItem({required IschoolerModel model}) async {
    _loadingRepository.startLoading(LoadingType.normal);
    bool successfulRequest = await _profileRepository.updateItem(model: model);
    if (successfulRequest) {
      emit(state.updateStatus());
      // await getAllItems();
    } // _loadingRepository.stopLoading();
  }

  @override
  Future<void> deleteItem({required IschoolerModel model}) async {
    _loadingRepository.startLoading(LoadingType.normal);
    await _profileRepository.deleteItem(model: model);
    emit(state.updateStatus());
    // await getAllItems();
  }
}
