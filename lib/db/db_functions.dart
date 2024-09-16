import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:statemanagementprovider/model/model.dart';

class DatabaseHelper {
  static const _databaseName = 'student.db';
  static const _databaseVersion = 1;
  static const table = 'students';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnAge = 'age';
  static const columnPlace = 'place';
  static const columnCourse = 'course';
  static const columnImage = 'image';
  static const columnPhone = 'phone';
  static const columnPincode = 'pincode';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

    Future<Database> _initDatabase() async {
      String path = join(await getDatabasesPath(), _databaseName);
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL,
        $columnPlace TEXT NOT NULL,
        $columnCourse TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnPhone TEXT NOT NULL,
        $columnPincode TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert(table, student.toMap());
  }

  Future<List<Student>> getStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(
      maps.length,
      (index) => Student(
        id: maps[index][columnId],
        name: maps[index][columnName],
        age: maps[index][columnAge],
        place: maps[index][columnPlace],
        course: maps[index][columnCourse],
        image: maps[index][columnImage],
        phone: maps[index][columnPhone],
        pincode: maps[index][columnPincode],
      ),
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId=?',
      whereArgs: [id],
    );
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return db.update(
      table,
      student.toMap(),
      where: '$columnId = ?',
      whereArgs: [student.id],
    );
  }
}
