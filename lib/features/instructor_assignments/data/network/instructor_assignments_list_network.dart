import '../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../common/ischooler_model.dart';
import '../../../../common/madpoly.dart';
import '../../../../common/network/ischooler_network_helper.dart';
import '../../../../common/network/ischooler_response.dart';
import '../../../../common/network/ischooler_tables.dart';
import '../../../dashboard/data/network/ischooler_list_network_interface.dart';

class InstructorAssignmentNetwork implements IschoolerListNetwork {
  final AlertHandlingRepository _alertHandlingRepository;

  InstructorAssignmentNetwork(AlertHandlingRepository alertHandlingRepository)
      : _alertHandlingRepository = alertHandlingRepository;

  @override
  Future<IschoolerResponse> getAllItems({
    required IschoolerListModel model,
    DatabaseTable? table,
    Map<String, dynamic>? eqMap,
  }) async {
    IschoolerResponse response = IschoolerResponse.empty();
    try {
      DatabaseTable tableQueryData =
          table ?? IschoolerNetworkHelper.getTableQueryData(model);

      if (tableQueryData == DatabaseTable.empty()) {
        throw Exception(
          'tableQueryData = $tableQueryData, '
          'unable to get (model = $model) data',
        );
      }
      /*  final CollectionReference<Map<String, dynamic>> reference =
          IschoolerNetworkHelper.fireStoreInstance.collection(tableQueryData.tableName); */
      Madpoly.print(
        'request will be sent is >>  get(), '
        'tableQueryData: $tableQueryData',
        // inspectObject: tableQueryData,
        tag: 'dashboard_network > getAllItems',
        // color: MadpolyColor.purple,
        isLog: true,
        developer: "Ziad",
      );
      var query = SupabaseCredentials.supabase
          .from(tableQueryData.tableName)
          .select(tableQueryData.selectQuery);
      if (eqMap != null && eqMap.isNotEmpty) {
        query = query.eq(eqMap.keys.first, eqMap.values.first);
      }
      final List<Map<String, dynamic>> responseData =
          await query.order('created_at', ascending: true);

      Madpoly.print(
        'query= ',
        inspectObject: responseData,
        color: MadpolyColor.green,
        tag: 'dashboard_network > getAllItems',
        developer: "Ziad",
      );
      response =
          IschoolerResponse(hasData: true, data: {'items': responseData});
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.MajorUiError,
        tag: 'admin_network > getAllData',
        // showToast: true,
      );
    }
    return response;
  }

  @override
  Future<bool> updateItem({required IschoolerModel model}) async {
    bool dataUpdated = false;
    // String? docName = addWithId ? model.id : null;
    try {
      DatabaseTable tableQueryData =
          IschoolerNetworkHelper.getTableQueryData(model);
      if (tableQueryData == DatabaseTable.empty()) {
        throw Exception(
          'tableQueryData = $tableQueryData, '
          'unable to update (model = $model) data',
        );
      }
      Map<String, dynamic> data = model.toMapFromChild();
      Madpoly.print(
        'request will be sent is >> update(), '
        'table: ${tableQueryData.tableName}, '
        'data = ',
        inspectObject: data,
        tag: 'dashboard_network > update',
        // color: MadpolyColor.purple,
        isLog: true,
        developer: "Ziad",
      );
      final query = await SupabaseCredentials.supabase
          .from(tableQueryData.tableName)
          .update(data)
          .match(model.idToMap());
      Madpoly.print(
        'query= ',
        color: MadpolyColor.green,
        inspectObject: query,
        tag: 'dashboard_network > update',
        developer: "Ziad",
      );
      // await response.doc(model.id).set(model.toMap());
      dataUpdated = true;
    } catch (e) {
      _alertHandlingRepository.addError(
        // 'unable to add user',
        /* developerMessage: */ e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'admin_network > update > catch',
        showToast: true,
      );
    }

    return dataUpdated;
  }
}
