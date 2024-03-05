import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/common_features/alert_handling/data/models/alert_handling_model.dart';
import '../../../../common/common_features/alert_handling/data/repo/alert_handling_repo.dart';
import '../../../../common/ischooler_model.dart';
import '../../../../common/madpoly.dart';
import '../../../../common/network/ischooler_network_helper.dart';
import '../../../../common/network/ischooler_response.dart';
import '../../../../common/network/ischooler_tables.dart';
import '../../../dashboard/data/network/ischooler_network_interface.dart';

class ProfileNetwork implements IschoolerNetwork {
  final AlertHandlingRepository _alertHandlingRepository;

  ProfileNetwork(AlertHandlingRepository alertHandlingRepository)
      : _alertHandlingRepository = alertHandlingRepository;

  @override
  Future<IschoolerResponse> getItem({required String id}) async {
    IschoolerResponse response = IschoolerResponse.empty();
    try {
      DatabaseTable tableQueryData = IschoolerTables.instructor;

      if (tableQueryData == DatabaseTable.empty()) {
        throw Exception('tableQueryData = $tableQueryData, ');
      }
      /*  final CollectionReference<Map<String, dynamic>> reference =
          IschoolerNetworkHelper.fireStoreInstance.collection(tableQueryData.tableName); */
      User? user = SupabaseCredentials.authInstance.currentUser;

      Madpoly.print(
        'request will be sent is >>  get(), '
        'user: $user',
        inspectObject: user,
        tag: 'profile_network > getItem',
        // color: MadpolyColor.purple,
        isLog: true,
        developer: "Ziad",
      );

      if (user != null) {
        final Map<String, dynamic> query = await SupabaseCredentials.supabase
            .from(tableQueryData.tableName)
            .select(tableQueryData.selectQuery)
            .eq('id', user.id)
            .single();

        Madpoly.print(
          'query= ',
          inspectObject: query,
          color: MadpolyColor.green,
          tag: 'profile_network > getItem',
          developer: "Ziad",
        );
        response = IschoolerResponse(hasData: true, data: query);
      }
    } catch (e) {
      _alertHandlingRepository.addError(
        e.toString(),
        AlertHandlingTypes.MajorUiError,
        tag: 'profile_network > getAllData',
        // showToast: true,
      );
    }
    return response;
  }

  @override
  Future<bool> addItem({required IschoolerModel model}) async {
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
        tag: 'profile_network > add',
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
        tag: 'profile_network > add',
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
        tag: 'profile_network > update',
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
        tag: 'profile_network > update',
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

  @override
  Future<bool> deleteItem({required IschoolerModel model}) async {
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
        tag: 'profile_network > deleteItem',
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
        tag: 'profile_network > delete',
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
