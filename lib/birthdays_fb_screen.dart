import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cake_time/add_birthday_screen.dart';
import 'package:cake_time/more_info_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class BirthdaysFirebaseScreen extends StatefulWidget {
  const BirthdaysFirebaseScreen({Key? key}) : super(key: key);

  @override
  _BirthdaysFirebaseScreenState createState() =>
      _BirthdaysFirebaseScreenState();
}

class _BirthdaysFirebaseScreenState extends State<BirthdaysFirebaseScreen> {
  var todaysBirthdays = [];
  var upcomingBirthdays = [];
  var turningAge;
  late FirebaseAuth _auth = FirebaseAuth.instance;
  late User loginUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser().whenComplete(() {
      setState(() {});
    });
    refreshBirthdayList();
    FirebaseDatabase.instance.reference().child(loginUser.uid.toString()).onChildChanged.listen((event) {
      print("Data has been changed");
      refreshBirthdayList();
    });
    FirebaseDatabase.instance.reference().child(loginUser.uid.toString()).onChildRemoved.listen((event) {
      print("Data has been removed");
      refreshBirthdayList();
    });
    FirebaseDatabase.instance.reference().child(loginUser.uid.toString()).onChildAdded.listen((event) {
      print("Data has been added");
      refreshBirthdayList();
    });
  }

  Future<void> getCurrentUser() async {
    var user = _auth.currentUser;
    if (user != null) {
      loginUser = user;
      setState(() {

      });
      print("Current user UID is:" + loginUser.uid.toString());
    }
  }

  void refreshBirthdayList() {
    FirebaseDatabase.instance.reference().child(loginUser.uid.toString()).once().then((datasnapshot) {
      print("Successfully loaded the data");
      print(datasnapshot);
      //path becomes the key
      print(datasnapshot.key);
      print(datasnapshot.value);
      //save everything into a list
      var birthdayTmpList = [];
      //iterate through the hashmap
      datasnapshot.value.forEach((k, v) {
        print(k);
        print(v);
        birthdayTmpList.add(v);
      });
      print("Final birthday list: ");
      print(birthdayTmpList);

      var todayBirthdayTmpList = [];
      var upcomingBirthdayTmpList = [];
      birthdayTmpList.forEach((v) {
        var personMonth = v["month"];
        var personDay = v["day"];
        var personYear = v["year"];
        var currentMonth = DateTime.now().month;
        var currentDay = DateTime.now().day;
        var currentYear = DateTime.now().year;

        if ((personMonth > currentMonth) ||
            (personMonth == currentMonth && personDay > currentDay) ||
            (personMonth == currentMonth && personDay == currentDay)) {
          turningAge = (currentYear - personYear).toString();
        }
        else {
          turningAge = ((currentYear + 1) - personYear).toString();
        }

        setState(() {});

        v["age"] = turningAge;

        // if the person's month and day is the same as the current month and day, add to today's birthday list
        if (personMonth == currentMonth && personDay == currentDay) {
          todayBirthdayTmpList.add(v);
        }
        // otherwise, add to upcoming birthday list
        else {
          upcomingBirthdayTmpList.add(v);
        }
      });
      //do set state to show it's been updated
      setState(() {});

      upcomingBirthdays = upcomingBirthdayTmpList;
      todaysBirthdays = todayBirthdayTmpList;
    }).catchError((error) {
      print("Failed to load data" + error.toString());
    });
  }


  //load all the birthday info from Firebase Database and display them in ListView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8edeb),
      appBar: AppBar(
        title: Text(
          "B I R T H D A Y S ",
          style: GoogleFonts.getFont(
            'Noto Serif',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xffe8a598),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "today's birthdays",
              style: GoogleFonts.getFont(
                'Noto Serif',
                fontSize: 22,
                color: Color(0xff30150d),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 35,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todaysBirthdays.length,
              itemBuilder: (BuildContext context, int index) {
                final names2 = todaysBirthdays[index]['name'];
                return Dismissible (
                  key: ObjectKey(names2),
                  child: Container(
                    height: 70,
                    margin:
                    EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                    color: const Color(0xfff8edeb),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            backgroundColor: Color(0xfff8edeb),
                            backgroundImage: AssetImage(
                              '${todaysBirthdays[index]["imageURL"]}'.toString(),
                            ),
                          ),
                        ),
                      ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${todaysBirthdays[index]['name']}'.toString(),
                              style: GoogleFonts.getFont(
                                'Noto Serif',
                                fontSize: 17,
                                color: Color(0xff30150d),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        Row(
                          children: [
                            Text(
                              '${todaysBirthdays[index]['birthday']}'.toString(),
                              style: GoogleFonts.getFont(
                                'Noto Serif',
                                fontSize: 15,
                                color: Color(0xff30150d),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              ' | Turns ',
                              style: GoogleFonts.getFont(
                                'Noto Serif',
                                fontSize: 15,
                                color: Color(0xff30150d),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${todaysBirthdays[index]['age']}'.toString(),
                              style: GoogleFonts.getFont(
                                'Noto Serif',
                                fontSize: 15,
                                color: Color(0xff30150d),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                          ],
                        ),

                      Spacer(),
                        IconButton(
                          tooltip: 'More info',
                          icon: const Icon(Icons.arrow_forward_ios),
                          color: Color(0xff30150d),
                          onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>
                              MoreInfoScreen(todaysBirthdays[index]),
                            ),
                        );
                      },
                      ),
                    ],
                  ),
                    ),
                  onDismissed: (direction) {
                    setState(() {

                    });
                    FirebaseDatabase.instance.reference()
                        .child(loginUser.uid.toString())
                        .child('person' +
                        todaysBirthdays[index]["timeStamp"].toString())
                        .remove();
                    todaysBirthdays.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$names2 has been removed')));
                  },
                  background: Container(color: Colors.red),
              );
              },
              ),
              ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "upcoming birthdays",
              style: GoogleFonts.getFont(
                'Noto Serif',
                fontSize: 22,
                color: Color(0xff30150d),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 120,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: upcomingBirthdays.length,
              itemBuilder: (BuildContext context, int index) {
                final names = upcomingBirthdays[index]['name'];
                return Dismissible (
                  key: ObjectKey(names),
                  child: Container(
                    height: 70,
                    margin:
                    EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                    color: const Color(0xfff8edeb),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundColor: Color(0xfff8edeb),
                              backgroundImage: AssetImage(
                                '${upcomingBirthdays[index]['imageURL']}'.toString(),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${upcomingBirthdays[index]['name']}'.toString(),
                              style: GoogleFonts.getFont(
                                'Noto Serif',
                                fontSize: 17,
                                color: Color(0xff30150d),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${upcomingBirthdays[index]['birthday']}'.toString(),
                                  style: GoogleFonts.getFont(
                                    'Noto Serif',
                                    fontSize: 15,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  ' | Turns ',
                                  style: GoogleFonts.getFont(
                                    'Noto Serif',
                                    fontSize: 15,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${upcomingBirthdays[index]['age']}'.toString(),
                                  style: GoogleFonts.getFont(
                                    'Noto Serif',
                                    fontSize: 15,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          tooltip: 'More info',
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MoreInfoScreen(upcomingBirthdays[index]),
                              ),
                            );
                          },
                        ),
                      ],

                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {

                    });
                    FirebaseDatabase.instance.reference()
                        .child(loginUser.uid.toString())
                        .child('person' +
                        upcomingBirthdays[index]["timeStamp"].toString())
                        .remove();
                    upcomingBirthdays.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$names has been removed')));
                  },
                  background: Container(color: Colors.red),

                  );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xfff8edeb), width: 2)),
        ),
        child: BottomAppBar(
          color: Color(0xfff8edeb),
          child: Row(
            children: [
              Expanded(
                flex: 50,
                child: IconButton(
                  tooltip: "Add a Birthday",
                  color: Color(0xff30150d),
                  icon:
                  const Icon(Icons.add_circle_outline_rounded, size: 30.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddBirthdayScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
