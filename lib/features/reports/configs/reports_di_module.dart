import 'package:get_it/get_it.dart';
import 'package:cash_flow/features/reports/data/datasources/monthly_report_datasource_impl.dart';
import 'package:cash_flow/features/reports/data/repositories/monthly_report_repository_impl.dart';
import 'package:cash_flow/features/reports/domain/datasources/monthly_report_datasource.dart';
import 'package:cash_flow/features/reports/domain/repositories/monthly_report_repository.dart';
import 'package:cash_flow/features/reports/domain/usecases/save_monthly_report_usecase.dart';
import 'package:cash_flow/features/reports/domain/usecases/get_monthly_reports_usecase.dart';

void setupReportsModule(GetIt getIt) {
  getIt.registerLazySingleton<MonthlyReportDatasource>(
    () => MonthlyReportDatasourceImpl(),
  );

  getIt.registerLazySingleton<MonthlyReportRepository>(
    () => MonthlyReportRepositoryImpl(getIt<MonthlyReportDatasource>()),
  );

  getIt.registerLazySingleton<SaveMonthlyReportUseCase>(
    () => SaveMonthlyReportUseCase(getIt<MonthlyReportRepository>()),
  );

  getIt.registerLazySingleton<GetMonthlyReportsUseCase>(
    () => GetMonthlyReportsUseCase(getIt<MonthlyReportRepository>()),
  );
}

