import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8edeb),
      body: Column(
        children: [
          Expanded(
            flex: 35,
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                  image: AssetImage('assets/caketimeiconother.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Welcome!",
                    style: GoogleFonts.getFont(
                      'Noto Serif',
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff30150d),
                    ),
                  ),

                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 35, right: 35, bottom: 20, top: 20),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 35, right: 35, bottom: 20, top: 20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(
                            width: 2.0,
                            color: Color(0xff30150d),
                          )),
                      child: Text(
                        "signup",
                        style: GoogleFonts.getFont(
                          'Noto Serif',
                          fontSize: 15,
                          color: Color(0xff30150d),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        //1. get the email and password typed
                        print(emailController.text);
                        print(passwordController.text);
                        //2. send the info to firebase auth
                        // result is a type of future object
                        // createUserWith... function call returns an object
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            //if the function has finished successfully, print successful sign up
                            .then((authResult) {
                          print("Successfully signed up! UID: " + authResult.user!.uid);

                          FirebaseDatabase.instance.reference().child(authResult.user!.uid);
                          Navigator.pop(context);
                        }).catchError((error) {
                          print("Failed to signup");
                          print(error.toString());
                        });
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
