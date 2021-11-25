import 'package:cake_time/birthdays_fb_screen.dart';
import 'package:cake_time/notification_service.dart';
import 'package:cake_time/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: Color(0xfff8edeb),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Color(0xffe8a598),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Color(0xff30150d),
            textStyle: TextStyle(
              fontFamily: 'NotoSerif',
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
            shape: StadiumBorder(),
            side: BorderSide(
              width: 2.0,
              color: Color(0xff30150d),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black45),
          hintStyle: TextStyle(color: Colors.black45),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff30150d)),
          ),
        ),
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
                    flex: 20,
                    child: Container(
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 30,
                      ),
                      child: ClipRRect(
                        child: Image(
                          image: AssetImage('assets/caketimeiconother.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 30),
                          child: GestureDetector(
                            child: Text("CakeTime",
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffe8a598),
                                )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 35, right: 35, bottom: 30, top: 30),
                          child: GestureDetector(
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Email Address',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 35, right: 35, bottom: 10, top: 10),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 35, bottom: 10),
                          child: OutlinedButton(
                            child: Text(
                              "Login",
                            ),
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Successfully logged in!")),
                                );
                                print("Login successful");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BirthdaysFirebaseScreen()),
                                );
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("User does not exist.")),
                                );
                                print(error.toString());
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 100,
                          child: OutlinedButton(
                            child: Text(
                              "Signup",
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
