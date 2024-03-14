import '../../../../../common/common_features/loading/data/models/loading_model.dart';
import '../../../../../common/common_features/loading/data/repo/loading_repo.dart';
import '../../../../../common/ischooler_model.dart';
import '../../../../../common/madpoly.dart';
import '../../../dashboard/logic/cubit/ischooler_list_cubit.dart';
import '../../data/models/instructor_assignments_list_model.dart';
import '../../data/repo/instructor_assignments_list_repo.dart';

part 'instructor_assignments_list_state.dart';

class InstructorAssignmentsListCubit
    extends IschoolerListCubit<InstructorAssignmentsListState> {
  final InstructorAssignmentRepository _instructorAssignmentRepository;
  final LoadingRepository _loadingRepository;

  InstructorAssignmentsListCubit(
    InstructorAssignmentRepository instructorAssignmentRepository,
    LoadingRepository loadingRepository,
  )   : _instructorAssignmentRepository = instructorAssignmentRepository,
        _loadingRepository = loadingRepository,
        super(InstructorAssignmentsListState.init());

  @override
  Future<void> getAllItems({Map<String, dynamic>? eqMap}) async {
    _loadingRepository.startLoading(LoadingType.normal);
    IschoolerListModel response =
        //model is sent here to get the type of request only
        await _instructorAssignmentRepository.getAllItems(
      model: InstructorAssignmentsListModel.empty(),
      eqMap: eqMap,
    );
    if (response is InstructorAssignmentsListModel) {
      emit(state.updateAllInstructorAssignments(response));
    } else {
      Madpoly.print(
        'incorrect model >> ${response.runtimeType}',
        tag: 'instructorAssignments_list_cubit > ',
        showToast: true,
        developer: "Ziad",
      );
    }
    _loadingRepository.stopLoading();
  }

  @override
  Future<void> updateItem({required IschoolerModel model}) async {
    _loadingRepository.startLoading(LoadingType.normal);

    bool successfulRequest =
        await _instructorAssignmentRepository.updateItem(model: model);
    if (successfulRequest) {
      emit(state.updateStatus());
      await getAllItems();
    }
    // _loadingRepository.stopLoading();
  }
}
