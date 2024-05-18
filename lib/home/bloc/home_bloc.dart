import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import '../services.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeData data = HomeData();
  HomeServices _services = HomeServices();

  HomeBloc() : super(HomeState.initial()) {
    on<GetDataEvent>(getData);
    on<AddDataEvent>(addData);
    on<DeleteDataEvent>(deleteData);
    on<UpdateDataEvent>(updateData);
  }

  void updateData(UpdateDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingUpdateData());

    try {
      await _services.updateToDo(data.complete).then((value)async {

        if (value.isEmptyModel()) {
         await data.updateItem(event.index, value);
          emit(SuccessUpdateData());
        } else {
          emit(FailUpdateData());
        }
      });
    } catch (e) {
      print("the exception is $e");
      emit(ExceptionUpdateData());
    }
  }

  void deleteData(DeleteDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingDeleteData());

    try {
      await _services.deleteToDo().then((value)async {
        if (value) {
          await data.removeItem(event.index);
          emit(SuccessDeleteData());
        } else {
          emit(FailDeleteData());
        }
      });
    } catch (e) {
      print("the exception is $e");
      emit(ExceptionDeleteData());
    }
  }

  void addData(AddDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingNewData());
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    int userID =  _sharedPreference.getInt('id') ?? 5;
    try {
      if (data.newTodo.isNotEmpty) {
        await _services
            .addToDo(data.newTodo, data.complete, userID)
            .then((value)async {

          if (value.isEmptyModel()){
           await data.addnewItem(value);
            emit(SuccessNewData());
          } else {
            emit(FailNewData());
          }
        });
      } else {
        emit(FailNewData());
      }
    } catch (e) {
      print("the exception is $e");
      emit(ExceptionNewData());
    }
  }

  void getData(GetDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeData());
    try {
      await _services.getData().then((value) async {
        if (value.isNotEmpty) {
          data.list = value;
          data.addItems();
          emit(SuccessHomeData());
        } else {
          await data.readSqlData().then((_) {
            if (data.viewList.isNotEmpty) {
              emit(SuccessHomeData());
            } else {
              emit(FailHomeData());
            }

          });
        }
      });
    } catch (e) {
      print("the exception is $e");
      await data.readSqlData().then((_) {
        if (data.viewList.isNotEmpty) {
          emit(SuccessHomeData());
        } else {
          emit(ExceptionHomeData());
        }
      });
    }
  }
}
