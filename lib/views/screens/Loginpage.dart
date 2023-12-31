import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_application_1/views/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';





class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() =>  LoginpageState();
}

class  LoginpageState extends State<Loginpage> { 
 
  final _loginbage =GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final Passwordcontoller = TextEditingController();
  bool passToggle= true;

   @override
  Widget build(BuildContext context){
    return Scaffold (
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 60),
          child:Form( 
            child: Column(
              key: _loginbage,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                    Image.asset(
                        "assets/ppp.png",
                        height: 200,
                        width: 200,
                    ),
                    SizedBox(height:50),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value){
                        bool emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-?/=?/{}][{}]{|}+").hasMatch(value!);
                        if(value.isEmpty){
                          return 'Please enter your Email';
                        }
                        
                        if(!emailValid){
                          return'Enter valid E-mail address!';
                        }
                      }
                    ),
                    SizedBox(height:20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: Passwordcontoller,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        labelText: "password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: (){
                             setState(() {
                             passToggle  =!passToggle;

                          });
                           
                          },
                          child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty){
                          return 'Please enter password';
                        }
                        else if(Passwordcontoller.text.length < 6){
                          return'Password must be atleast six characters long.';
                        }
                      },
                    ),
                    const SizedBox(height:60),
                    InkWell(
                      onTap: ()  async {
                        if(_loginbage.currentState!.validate()){
                        bool result= await  fireBaseLogin( emailcontroller.text,Passwordcontoller.text );
                        if(result == true){
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString('email', emailcontroller.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:(context)=>HomeScreen(
                                email:emailcontroller.text,
                              )
                            ),
                          );
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:Text("Login faild"), 
                          ),
                          
                          );
                        }
                        }
                      },
                      
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),

                        ),
                        child: Center (
                          child: Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:20
                          ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        ),
                        TextButton(onPressed: () {},
                         child: Text(
                          "sign up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                         ),
                         ),
                         
                      ],
                      ),
                ], 
              ),
            ),
          ),
        ),
      );
  }
      Future<bool> fireBaseLogin(String email ,String password) async {
        try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
    if  (userCredential.user !=null){
      return true;
    }
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
    }
      return false;
  } 
}