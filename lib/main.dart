import 'package:cake_time/birthdays_fb_screen.dart';
import 'package:cake_time/notification_service.dart';
import 'package:cake_time/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await NotificationService().initNotification();
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
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8edeb),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Expanded(
                flex: 40,
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 30,),
                  child: ClipRRect(
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
                        "login",
                        style: GoogleFonts.getFont(
                          'Noto Serif',
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff30150d),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 35, right: 35, bottom: 10, top: 10),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email Address',
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
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(),
                      ),
                    ),


                    Expanded(
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(
                              width: 2.0,
                              color: Color(0xff30150d),
                            ),
                          ),
                          child: Text(
                            "login",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 15,
                              color: Color(0xff30150d),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                              print("Login successful");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BirthdaysFirebaseScreen()),
                              );
                            }).catchError((error) {
                              print("Login failed");
                              print(error.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
