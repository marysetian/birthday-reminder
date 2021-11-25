import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
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
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffe8a598),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 35, right: 35, bottom: 20, top: 50),
                        child: TextField(
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Enter Email Address',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 35, right: 35, bottom: 20, top: 20),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Enter Password',
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
                              "Signup",
                            ),
                            onPressed: () {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((authResult) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Successfully signed up!")),
                                );
                                print("Successfully signed up! UID: " +
                                    authResult.user!.uid);
                                FirebaseDatabase.instance
                                    .reference()
                                    .child(authResult.user!.uid);
                                Navigator.pop(context);
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Email or password is invalid, please try again.")),
                                );
                                print(error.toString());
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
