import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQfLite {
  Database? _db;

  Future<Database> get dB async {
    return _db ?? await initialDB();
  }

  Future<Database> initialDB() async {
    String path = await getDatabasesPath();
    String sqlPath = join(path, 'Tasks.db');
    return await openDatabase(sqlPath, onCreate: _CreateDB, version: 1);
  }

  Future<void> _CreateDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE tasks (
id INTEGER NOT NULL PRIMARY KEY,
todo TEXT NOT NULL,
completed INTEGER NOT NULL ,
userId INTEGER NOT NULL
);
''');
  }

   readTasks() async {
    Database db = await dB;
    List<Map> tasks =await db.rawQuery("SELECT* FROM tasks ");
    print("ths tasks is $tasks");
    return tasks;
  }

  Future<void>updateTasks(int id,String todo,int complete,int userId,int newId) async {
    Database db = await dB;

   int x= await db.update('tasks', {'id':newId,'todo':todo,'completed':complete,'userId':userId},where: 'id =?',whereArgs: [id]);
   print("the x is $x");
  }


   removeTasks(int id) async {
    Database db = await dB;
   await db.delete('tasks',where: 'id =?',whereArgs: [id]);
  }

  Future<void> addTask(int id, String todo, int complete, int userId) async {
    Database _db = await dB;
    var tasks = _db.insert('tasks',{
      "id": id,
      "todo": todo,
      "completed":complete,
      "userId": userId,
    },conflictAlgorithm: ConflictAlgorithm.replace);

  }
}
