import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/todo_model.dart';

class TodoSrvices{
  String url='https://jsonplaceholder.typicode.com/todos';
  Future<List<TodoModel>>
   getTodo() async {
  List<TodoModel> todoList =[];
  final response = await Dio().get(url);
  var data = response.data;
  data.forEach((element){
    TodoModel todo =TodoModel.fromJson(element);
    todoList.add(todo);
  });
  return todoList;
    }
  }

