import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_application_1/services/todo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosInitial()){
    getMytodos();
  }


   List<TodoModel> todos =[];
    getMytodos() async{
      try{
        emit(
          TodosLoading()
        );
        todos = await TodoSrvices().getTodo();
        emit(TodosSucess());
      }
      catch (e){
        emit(TodosError());
    }
  }
}
