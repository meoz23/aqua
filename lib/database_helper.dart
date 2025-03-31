import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'aquarium.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE settings (id INTEGER PRIMARY KEY, fishCount INTEGER, speed REAL, color TEXT)",
        );
      },
    );
  }

  Future<void> saveSettings(int fishCount, double speed, String color) async {
    final db = await database;
    await db.insert("settings", {
      'id': 1,
      'fishCount': fishCount,
      'speed': speed,
      'color': color,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> loadSettings() async {
    final db = await database;
    final result = await db.query("settings", where: "id = 1");
    return result.isNotEmpty ? result.first : null;
  }
}
