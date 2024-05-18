part of 'home_bloc.dart';

@immutable
class HomeState {
  HomeState();

  factory HomeState.initial() {
    return HomeState();
  }
}

class LoadingHomeData extends HomeState {}

class SuccessHomeData extends HomeState {}

class FailHomeData extends HomeState {}

class ExceptionHomeData extends HomeState {}

class LoadingNewData extends HomeState {}

class SuccessNewData extends HomeState {}

class FailNewData extends HomeState {}

class ExceptionNewData extends HomeState {}

class LoadingDeleteData extends HomeState {}

class SuccessDeleteData extends HomeState {}

class FailDeleteData extends HomeState {}

class ExceptionDeleteData extends HomeState {}

class LoadingUpdateData extends HomeState {}

class SuccessUpdateData extends HomeState {}

class FailUpdateData extends HomeState {}

class ExceptionUpdateData extends HomeState {}
