import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  DatabaseHelper();

  static const _databaseName = "MusicDatabase.db";
  static const _databaseVersion = 1;

  static const musicTable = 'MusicTable';
  static const columnMusicId = 'id';
  static const columnExpenseDate = 'expenseDate';
  static const columnExpenseMonth = 'expenseMonth';
  static const columnExpenseCategory = 'expenseCategory';
  static const columnExpense = 'expense';
  static const columnExpenseDescription = 'expenseDescription';
  static const columnExpenseIconType = 'expenseIconType';
}