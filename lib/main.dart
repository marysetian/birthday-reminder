import 'package:cake_time/add_birthday_screen.dart';
import 'package:cake_time/birthdays_screen.dart';
import 'package:cake_time/more_info_screen.dart';
import 'package:cake_time/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded (
            flex: 40,
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 30),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(80.0),
                child: Image(
                  image: NetworkImage('https://cdn.dribbble.com/users/1473783/screenshots/6084221/dribbleiconscake-01_4x.png?compress=1&resize=400x300'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded (
            flex: 50,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Login",
                    style: TextStyle (
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20,),
                  child: Text (
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                ),
                Expanded (
                  child: Container (
                    width: 100,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: RaisedButton (
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Text("Login"),
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BirthdaysScreen()),
                          );

                      },
                    ),
                  ),
                ),
                Expanded (
                  child: Container (
                    width: 100,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: RaisedButton (
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Text("Signup"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded (
            flex: 10,
            child: Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



              ],
            ),
          ),
        ],
      ),
    );
  }
}
