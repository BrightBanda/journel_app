import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'journel.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE folders(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL
        )
   ''');

        await db.execute(''' 
        CREATE TABLE notes(
          id TEXT PRIMARY KEY,
          title TEXT,
          content TEXT,
          mood INTEGER,
          folder_id TEXT,
          date_created TEXT,
          time_created TEXT,
          FOREIGN KEY (folder_id) REFERENCES folders(id)
        )
   ''');
      },
    );
    return _database!;
  }

  Future<void> insertFolder({required String id, required String name}) async {
    final db = await instance.database;
    await db.insert('folders', {
      'id': id,
      'name': name,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllFolders() async {
    final db = await instance.database;
    final result = await db.query('folders');
    return result;
  }

  Future<void> deleteFolderById(String id) async {
    final db = await instance.database;
    db.delete('folders', where: 'id = ?', whereArgs: [id]);
  }
  //

  Future<void> insertNote({
    required String id,
    required String title,
    required String content,
    required int moodIndex,
    required String folder_id,
    required String date_Created,
    required String time_Created,
  }) async {
    final db = await instance.database;
    await db.insert('notes', {
      'id': id,
      'title': title,
      'content': content,
      'mood': moodIndex,
      'folder_id': folder_id,
      'date_created': date_Created,
      'time_created': time_Created,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await instance.database;
    final result = db.query('notes');
    return result;
  }

  Future<void> deleteNoteById(String id) async {
    final db = await instance.database;
    db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
