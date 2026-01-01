import 'dart:convert';

class MonthlyReportDbModel {
  final String id;
  final String userId;
  final int month;
  final int year;
  final Map<String, dynamic> reportData;
  final String? pdfPath;
  final int createdAt;

  MonthlyReportDbModel({
    required this.id,
    required this.userId,
    required this.month,
    required this.year,
    required this.reportData,
    this.pdfPath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'month': month,
      'year': year,
      'report_data': jsonEncode(reportData),
      'pdf_path': pdfPath,
      'created_at': createdAt,
    };
  }

  factory MonthlyReportDbModel.fromMap(Map<String, dynamic> map) {
    return MonthlyReportDbModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      month: map['month'] as int,
      year: map['year'] as int,
      reportData: jsonDecode(map['report_data'] as String) as Map<String, dynamic>,
      pdfPath: map['pdf_path'] as String?,
      createdAt: map['created_at'] as int,
    );
  }
}

