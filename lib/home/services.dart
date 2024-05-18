import 'package:dio/dio.dart';

import '../routs.dart';
import 'model.dart';

class HomeServices {
  Dio dio = Dio();

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> temp = {};
    await dio.get(Routs.getData).then((value) {
      temp = value.data ?? {};
    });
    return temp;
  }
  Future<Model> updateToDo(bool complete) async {
    Model temp = Model(0, "", false, 0);
    await dio.put(Routs.updateToDo, data: {
      "completed": complete,

    }).then((value) {
      print("the value is ${value.data}");
      temp.id = value.data['id'];
      temp.mission = value.data['todo'];
      temp.complete = value.data['completed'];
      temp.userId = value.data['userId'];
    });
    return temp;
  }

  Future<Model> addToDo(String todo, bool complete, int userId) async {
    Model temp = Model(0, "", false, 0);
    await dio.post(Routs.addToDo, data: {
      "todo": todo,
      "completed": complete,
      "userId": userId,
    }).then((value) {
      print("the value is ${value.data}");
      temp.id = value.data['id'];
      temp.mission = value.data['todo'];
      temp.complete = value.data['completed'];
      temp.userId = value.data['userId'];
    });
    return temp;
  }

  Future<bool> deleteToDo() async {
    bool temp = false;
    await dio
        .delete(
      Routs.deleteToDo,
    )
        .then((value) {
      print("the value is ${value.data}");
      temp = value.data['isDeleted'];
    });
    return temp;
  }
}
