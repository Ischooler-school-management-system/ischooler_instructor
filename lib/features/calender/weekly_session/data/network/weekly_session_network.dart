import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../../common/madpoly.dart';
import '../../../../../common/network/ischooler_network_helper.dart';
import '../../../../../common/network/ischooler_response.dart';
import '../../../../../common/network/ischooler_tables.dart';
import '../models/weekly_session_model.dart';

class WeeklySessionsNetwork {
  final AlertHandlingRepository _alertHandlingRepository;

  WeeklySessionsNetwork(AlertHandlingRepository alertHandlingRepository)
      : _alertHandlingRepository = alertHandlingRepository;

  Future<IschoolerResponse> getAllItems(
      /* {
    required String weeklyTimetableId,
    required String weekdayId,
    DatabaseTable? table,
  } */
      ) async {
    IschoolerResponse response = IschoolerResponse.empty();
    try {
      /*  final CollectionReference<Map<String, dynamic>> reference =
          IschoolerNetworkHelper.fireStoreInstance.collection(tableQueryData.tableName); */

      User? user = SupabaseCredentials.authInstance.currentUser;
      Madpoly.print(
        'request will be sent is >> get(), '
        '',
        tag: 'weekly_sessions_network > getAllItems',
        // color: MadpolyColor.purple,
        isLog: true,
        developer: "Ziad",
      );
      if (user != null) {
        final List<Map<String, dynamic>> weeklySessions =
            await SupabaseCredentials.supabase
                .from('weekly_sessions')
                .select('*,instructor_assignment('
                    'subject(id,name),class(id,name),instructor(id,name)'
                    '),weekly_timetable_day(*))')
                .eq('instructor_assignment.instructor_id', user.id)
                .order('id', ascending: true);

        Madpoly.print(
          'query= ',
          inspectObject: weeklySessions,
          color: MadpolyColor.green,
          tag: 'weekly_sessions_network > getAllItems',
          developer: "Ziad",
        );
        response =
            IschoolerResponse(hasData: true, data: {'items': weeklySessions});
      }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.MajorUiError,
        tag: 'weekly_session_network > getAllData',
        // showToast: true,
      );
    }
    return response;
  }

  Future<bool> addItem({required WeeklySessionModel model}) async {
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
        tag: 'weekly_sessions_network > add',
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
        tag: 'weekly_sessions_network > add',
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

  Future<bool> updateItem({required WeeklySessionModel model}) async {
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
        tag: 'weekly_sessions_network > update',
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
        tag: 'weekly_sessions_network > update',
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

  Future<bool> deleteItem({required WeeklySessionModel model}) async {
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
        tag: 'weekly_sessions_network > deleteItem',
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
        tag: 'weekly_sessions_network > delete',
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
