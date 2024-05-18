part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetDataEvent extends HomeEvent {}

class AddDataEvent extends HomeEvent {}
@immutable
class DeleteDataEvent extends HomeEvent {
  int index;
  DeleteDataEvent(this.index);
}

class UpdateDataEvent extends HomeEvent{
  int index;
  UpdateDataEvent(this.index);
}
