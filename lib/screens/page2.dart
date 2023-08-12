
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_application_1/services/todo_service.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<TodoModel> todos =[];
  getMytodos() async{
    todos = await TodoSrvices().getTodo();
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    getMytodos();
  }
  
 @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text( todos[index].title ?? '' ),
          
          trailing: Icon(Icons.person),
          leading: Text("${index + 1}"),
        );
      }
    );
  }
}