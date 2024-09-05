

import 'package:hindi_news/model/result_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';




class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "News.db";
  static const String _tableName = "News";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async =>
            db.execute(
                " CREATE TABLE News( "
                    " articleId text, "
                    " image_url text ,"
                    " category text,"
                    " link text,"
                    " title text ,"
                    " source_name text,"
                    " source_icon text, "

                    " description text) ;"),
        version: _version);
  }
  static Future<List<Map<String, Object?>>> getTask() async {
    Database db = await _getDB();
    return await db.query(_tableName);


  }


  // static Future<int> insertUser( NewsResult news) async {
  //   final db = await _getDB();
  //   return await db.insert(_tableName, news.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  Future<bool> isNewsExists(String id) async {
    final db = await _getDB();
    final result = await db.query(
      'news',
      where: 'articleId = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<void> insertUser(NewsResult news) async {
    final db = await _getDB();

    // Check if the news item already exists
    bool exists = await isNewsExists(news.articleId);

    if (!exists) {
      await db.insert(
        'news',
        news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<int> updateUser(int id,NewsResult news) async {
    final db = await _getDB();
    return await db.update(_tableName, news.toJson(), where: 'articleId = ?', whereArgs: [id], conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static  getSingleUser(int id) async {
    final db = await _getDB();
    return db.query(_tableName, where: "employeeCode= ?", whereArgs: [id],limit: 1,orderBy: "articleId DESC",);


  }

  static Future<int> deleteUser(int id) async {
    final db = await _getDB();
    return await db.delete(_tableName, where: 'articleId = ?', whereArgs: [id]);
  }



}