import 'package:dio/dio.dart';

import '../routs.dart';

class LoginServices {
  Dio dio = Dio();

  Future<Map> Login(String userName, String password) async {
    Map temp ={};
    await dio.post(Routs.loginApi,
        data: {'username': userName, 'password': password}).then((value) {
          temp =value.data;
    });
    return temp;
  }
}
