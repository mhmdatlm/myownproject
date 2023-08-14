
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_application_1/services/todo_service.dart';
import 'package:flutter_application_1/views/cubit/cubit/todos_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
 @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(),
      child: BlocConsumer<TodosCubit, TodosState>(
        builder: (context, state) {
        if (state is TodosLoading) {
          return Center(child: CircularProgressIndicator(),
          );
        }
        if (state is TodosError){
          return Center(
            child: Text("Error"),
          );
        }
      return  ListView.builder(
      itemCount: context.watch<TodosCubit>().todos.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text( context.watch<TodosCubit>().todos[index].title ?? '' ),
          
          trailing: Icon(Icons.person),
          leading: Text("${index + 1}"),
        );
      },
    );
        },
        listener: (context ,State){},
      
      ),
      );
  }
}