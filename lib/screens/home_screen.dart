import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/page1.dart';
import 'package:flutter_application_1/screens/page2.dart';


class HomeScreen extends StatefulWidget {
  String email;
   HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages= [
    Page1(),
    Page2()
    
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
              Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.home,),label:'page1'),
            BottomNavigationBarItem(icon:Icon(Icons.security,), label:'page2')
          ],
          onTap: (value) {
            currentIndex=value;
            setState(() {});
            print(value);
          },
       )
      );
    
  }
}