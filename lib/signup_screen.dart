import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded (
            flex: 30,
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
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
                    "Signup",
                    style: TextStyle (
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, right: 35, bottom: 20, top: 20),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, right: 35, bottom: 20, top: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                  Container (
                    width: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                      child: RaisedButton (
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text("Signup"),
                        onPressed: () {
                            Navigator.pop(context);
                          }

                      ),

                  ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
