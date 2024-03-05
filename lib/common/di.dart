import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../features/auth/data/network/auth_network.dart';

import '../features/auth/data/repo/auth_repo.dart';
import '../features/calender/weekday/data/network/weekday_network.dart';
import '../features/calender/weekday/data/repo/weekday_repo.dart';
import '../features/calender/weekly_session/data/network/weekly_session_network.dart';
import '../features/calender/weekly_session/data/repo/weekly_session_repo.dart';
import '../features/calender/weekly_timetable/data/network/weekly_timetable_network.dart';
import '../features/calender/weekly_timetable/data/repo/weekly_timetable_repo.dart';
import '../features/calender/weekly_timetable_day/data/network/weekly_timetable_day_network.dart';
import '../features/calender/weekly_timetable_day/data/repo/weekly_timetable_day_repo.dart';
import '../features/profile/data/network/profile_network.dart';
import '../features/profile/data/repo/profile_repo.dart';
import 'common_features/alert_handling/data/repo/alert_handling_repo.dart';
import 'common_features/loading/data/repo/loading_repo.dart';

/// Instance of Get It
final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static final DependencyInjection _singleton = DependencyInjection._();

  factory DependencyInjection() => _singleton;

  DependencyInjection._();

  /// here we define all networks and repos for the bloc to have a singleton
  /// from each one to be used across all app
  Future<void> registerSingleton() async {
    getIt.registerLazySingleton(() => Dio());
    getIt.registerLazySingleton(() => Connectivity());

    /// register Networks:
    getIt.registerLazySingleton(() => AuthNetwork(getIt()));
    getIt.registerLazySingleton(() => ProfileNetwork(getIt()));
    getIt.registerLazySingleton(() => WeeklyTimetableNetwork(getIt()));
    getIt.registerLazySingleton(() => WeekdaysNetwork(getIt()));
    getIt.registerLazySingleton(() => WeeklySessionsNetwork(getIt()));
    getIt.registerLazySingleton(() => WeeklyTimetableDayNetwork(getIt()));
    // //--------------------------------------------------------------------------
    /// register Repositories:
    getIt.registerLazySingleton(() => LoadingRepository());
    getIt.registerLazySingleton(() => AlertHandlingRepository());
    getIt.registerLazySingleton(() => AuthRepository(getIt(), getIt()));
    getIt.registerLazySingleton(() => ProfileRepository(getIt(), getIt()));
    getIt.registerLazySingleton(
        () => WeeklyTimetableRepository(getIt(), getIt()));
    getIt.registerLazySingleton(() => WeekdaysRepository(getIt(), getIt()));
    getIt.registerLazySingleton(
        () => WeeklySessionsRepository(getIt(), getIt()));
    getIt.registerLazySingleton(
        () => WeeklyTimetableDaysRepository(getIt(), getIt()));
    //--------------------------------------------------------------------------
  }
}
