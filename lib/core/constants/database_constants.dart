class DatabaseConstants {
  static const String databaseName = 'cash_flow.db';
  static const int databaseVersion = 1;
  static const String tableUser = 'users';
  static const String tableTransactions = 'transactions';
  static const String tableCategories = 'categories';
  static const String columnUserId = 'id';
  static const String columnUsername = 'username';
  static const String columnPasswordHash = 'password_hash';
  static const String columnAvatarPath = 'avatar_path';
  static const String columnCreatedAt = 'created_at';
  static const String columnTracnsactionId = 'id';
  static const String columnTracnsactionUserId = 'user_id';
  static const String columnAmount = 'amount';
  static const String columnDecscription = 'description';
  static const String columnDate = 'date';
  static const String columnCategoryId = 'category_id';
  static const String columnType = 'type'; 
  static const String columnTransactionCreatedAt = 'created_at';
  static const String columnCategoryName = 'name';
  static const String columnCategoryIcon = 'icon';
  static const String columnCategoryType = 'type'; 
  static const String columnCategoryCreatedAt = 'created_at';
  static const String typeIncome = 'income';
  static const String typeExpense = 'expense';
}
  