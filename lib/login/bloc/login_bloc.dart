import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import '../services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginData data ;
  LoginServices services;
  LoginBloc() :data =LoginData(),services =LoginServices(), super(LoginState.initial()) {
    on<ShowPasswordEvent>(ShowPassword);
    on<SendLoginEvent>(SendLogin);


  }
   void ShowPassword(ShowPasswordEvent event,Emitter<LoginState> emit){
    if(data.secure){
      emit(ShowPasswordState());
      data.secure=false;
    }else{
      emit(HidePasswordState());
    data.secure=true;
    }
  }
  void SendLogin(SendLoginEvent event ,Emitter<LoginState> emit)async{
    emit(LoadingLoginState());
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    try {
      if (data.userNameV.isNotEmpty && data.passwordV.isNotEmpty) {
        services.Login(data.userNameV, data.passwordV).then((value) {
          _sharedPreference.setString('token', value['token']);
          _sharedPreference.setInt('id', value['id']);
        });
        emit(SuccessLoginState());

      } else {
        emit(FailLoginState());
      }
    }catch(e){
      print('the exception is $e');

      emit(ExceptionLoginState());

    }
  }
}
