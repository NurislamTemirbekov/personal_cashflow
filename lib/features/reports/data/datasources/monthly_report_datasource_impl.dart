import 'package:cash_flow/core/constants/database_constants.dart';
import 'package:cash_flow/core/database/database.dart';
import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';
import 'package:cash_flow/features/reports/domain/datasources/monthly_report_datasource.dart';
import 'package:sqflite/sqflite.dart';

class MonthlyReportDatasourceImpl implements MonthlyReportDatasource {
  MonthlyReportDatasourceImpl();

  Future<Database> get _db async => await AppDatabase.database;

  @override
  Future<String> saveReport(MonthlyReportDbModel report) async {
    final db = await _db;
    await db.insert(
      DatabaseConstants.tableMonthlyReports,
      report.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return report.id;
  }

  @override
  Future<List<MonthlyReportDbModel>> getReportsByUserId(String userId) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableMonthlyReports,
      where: '${DatabaseConstants.columnReportUserId} = ?',
      whereArgs: [userId],
      orderBy: '${DatabaseConstants.columnReportYear} DESC, ${DatabaseConstants.columnReportMonth} DESC',
    );
    return maps.map((map) => MonthlyReportDbModel.fromMap(map)).toList();
  }

  @override
  Future<MonthlyReportDbModel?> getReportByMonth(String userId, int year, int month) async {
    final db = await _db;
    final maps = await db.query(
      DatabaseConstants.tableMonthlyReports,
      where: '${DatabaseConstants.columnReportUserId} = ? '
          'AND ${DatabaseConstants.columnReportYear} = ? '
          'AND ${DatabaseConstants.columnReportMonth} = ?',
      whereArgs: [userId, year, month],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return MonthlyReportDbModel.fromMap(maps.first);
  }

  @override
  Future<void> deleteReport(String reportId) async {
    final db = await _db;
    await db.delete(
      DatabaseConstants.tableMonthlyReports,
      where: '${DatabaseConstants.columnReportId} = ?',
      whereArgs: [reportId],
    );
  }
}

