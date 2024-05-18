part of 'login_bloc.dart';

@immutable
 class LoginState {
  LoginState();
  factory LoginState.initial(){
    return LoginState();
  }
}

final class LoadingLoginState extends LoginState {}
final class SuccessLoginState extends LoginState {}
final class FailLoginState extends LoginState {}
final class ExceptionLoginState extends LoginState {}

final class ShowPasswordState extends LoginState {}
final class HidePasswordState extends LoginState{}

