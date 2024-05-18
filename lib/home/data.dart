import 'package:sqflite/sqflite.dart';

import '../DataBase/SQfLite_file.dart';
import 'model.dart';

class HomeData {
  Map<String, dynamic> list = {"": {}};

  List<dynamic> viewList = [];
  int length = 0;
  String newTodo = '';
  bool complete = false;
  int userId = 0;

  String getName(int index) => viewList[index]['todo'];

  int getId(int index) => viewList[index]['id'];

  bool getComplete(int index) => viewList[index]['completed'];

  int getUserId(int index) => viewList[index]['userId'];

  int getCount() => viewList.length ?? 0;

  void getItem() {
    length = list['todos'].length ?? 0;
    viewList = list['todos'];
  }

  void addItems() async {
    getItem();
    SQfLite sql = SQfLite();
    for (int i = 0; i < viewList.length; i++) {
      print("inside");
      await sql.addTask(viewList[i]['id'], viewList[i]['todo'],
          getBool(viewList[i]['completed']), viewList[i]['userId']);
    }
  }

  int getBool(bool boolean) {
    return boolean ? 1 : 0;
  }

  Future<void> readSqlData() async {
    SQfLite sql = SQfLite();

    await sql.readTasks().then((value) {
      for (int i = 0; i < value.length; i++) {
        addMapToList(value[i]);
      }
    });
  }

  addMapToList(Map map) {
    Map newOne = {'id': 0, 'todo': '', 'completed': 0, 'userId': 0};

    newOne['id'] = map['id'];
    newOne['todo'] = map['todo'];
    newOne['completed'] = map['completed'] > 0 ? true : false;
    newOne['userId'] = map['userId'];
    viewList.add(newOne);
  }

  Future<void> addnewItem(Model model) async{
    SQfLite _sql =SQfLite();
    Map<String, dynamic> value = {
      "id": model.id,
      "todo": model.mission,
      "completed": model.complete,
      "userId": model.userId
    };
    viewList.add(value);
  await  _sql.addTask(value['id'], value['todo'], getBool(value['completed']), value['userId']);


  }

  Future<void> removeItem(int index) async{
    SQfLite _sql =SQfLite();

    viewList.removeAt(index);
    await _sql.removeTasks(index);
  }

  Future<void> updateItem(int index, Model model)async {
    SQfLite _sql =SQfLite();
    int id = viewList[index]['id'];
    await _sql.updateTasks(id,model.mission,getBool(model.complete), model.userId,model.id).then((value) {
      viewList[index]['id'] = model.id;
      viewList[index]['todo'] = model.mission;
      viewList[index]['completed'] = model.complete;
      viewList[index]['userId'] = model.userId;
    });



  }
}
