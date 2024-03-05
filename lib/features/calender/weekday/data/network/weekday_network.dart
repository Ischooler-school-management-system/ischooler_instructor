import '../../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../../common/madpoly.dart';
import '../../../../../common/network/ischooler_network_helper.dart';
import '../../../../../common/network/ischooler_response.dart';
import '../../../../../common/network/ischooler_tables.dart';
import '../models/weekday_model.dart';
import '../models/weekdays_list_model.dart';

class WeekdaysNetwork {
  final AlertHandlingRepository _alertHandlingRepository;

  WeekdaysNetwork(AlertHandlingRepository alertHandlingRepository)
      : _alertHandlingRepository = alertHandlingRepository;
/*  
    final List<Map<String, dynamic>> weekdays =
        await SupabaseCredentials.supabase.from('weekday').select();
    weekdaysListModel = WeekdaysListModel.fromMap({'items': weekdays});
 */
  Future<IschoolerResponse> getAllItems(
      {required WeekdaysListModel model,
      DatabaseTable? table,
      String? orderBy}) async {
    IschoolerResponse response = IschoolerResponse.empty();
    try {
      DatabaseTable tableQueryData = IschoolerTables.weekday;

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
        tag: 'weekdays_network > getAllItems',
        // color: MadpolyColor.purple,
        isLog: true,
        developer: "Ziad",
      );
      final List<Map<String, dynamic>> query = await SupabaseCredentials
          .supabase
          .from(tableQueryData.tableName)
          .select(tableQueryData.selectQuery)
          .order(orderBy ?? 'created_at', ascending: true);

      Madpoly.print(
        'query= ',
        inspectObject: query,
        color: MadpolyColor.green,
        tag: 'weekdays_network > getAllItems',
        developer: "Ziad",
      );
      response = IschoolerResponse(hasData: true, data: {'items': query});
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.MajorUiError,
        tag: 'weekday_network > getAllData',
        // showToast: true,
      );
    }
    return response;
  }

  Future<bool> addItem({required WeekdayModel model}) async {
    bool dataStored = false;
    // String? docName = addWithId ? model.id : null;
    try {
      DatabaseTable tableQueryData =
          IschoolerNetworkHelper.getTableQueryData(model);
      if (tableQueryData == DatabaseTable.empty()) {
        throw Exception(
          'tableQueryData = $tableQueryData, '
          'unable to add (model = $model) data',
        );
      }
      Map<String, dynamic> data = model.toMap();
      Madpoly.print(
        'request will be sent is >> insert(), '
        'tableQueryData: $tableQueryData, '
        'data = $data',
        tag: 'weekdays_network > add',
        // color: MadpolyColor.purple,
        isLog: true,
        developer: "Ziad",
      );
      final query = await SupabaseCredentials.supabase
          .from(tableQueryData.tableName)
          .insert(data);
      Madpoly.print(
        color: MadpolyColor.green,
        'query =',
        inspectObject: query,
        tag: 'weekdays_network > add',
        developer: "Ziad",
      );
      // await response.doc(model.id).set(model.toMap());
      dataStored = true;
    } catch (e) {
      _alertHandlingRepository.addError(
        // 'unable to add user',
        /* developerMessage: */ e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'admin_network > addData > catch',
        showToast: true,
      );
    }

    return dataStored;
  }

  Future<bool> updateItem({required WeekdayModel model}) async {
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
        tag: 'weekdays_network > update',
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
        tag: 'weekdays_network > update',
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

  Future<bool> deleteItem({required WeekdayModel model}) async {
    bool dataDeleted = false;
    try {
      DatabaseTable tableQueryData =
          IschoolerNetworkHelper.getTableQueryData(model);
      if (tableQueryData == DatabaseTable.empty()) {
        throw Exception(
          'tableQueryData = $tableQueryData, '
          'unable to delete (model = $model) data',
        );
      }
      Madpoly.print(
        'request will be sent is >> delete(), '
        'tableQueryData: $tableQueryData, ',
        inspectObject: model,
        tag: 'weekdays_network > deleteItem',
        isLog: true,
        // color: MadpolyColor.purple,
        developer: "Ziad",
      );
      final query = await SupabaseCredentials.supabase
          .from(tableQueryData.tableName)
          .delete()
          .eq('id', model.id);
      Madpoly.print(
        'query= ',
        inspectObject: query,
        color: MadpolyColor.green,
        tag: 'weekdays_network > delete',
        developer: "Ziad",
      );

      dataDeleted = true;
    } catch (e) {
      _alertHandlingRepository.addError(
        'unable to add user',
        developerMessage: e.toString(),
        AlertHandlingTypes.ServerError,
        tag: 'admin_network > delete > catch',
        showToast: true,
      );
    }

    return dataDeleted;
  }
}
