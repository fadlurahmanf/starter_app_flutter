import 'package:sqflite/sqflite.dart';

abstract class BaseDBHelper {
  String? dbPath;

  Future<String> getDBPath();

  Database? db;

  Future<Database> getDB();

  Future<void> init();

  Future<void> close();
}