import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cake_time/add_birthday_screen.dart';
import 'package:cake_time/more_info_screen.dart';

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
  bool isNew = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser().whenComplete(() {
      setState(() {});
    });
    refreshBirthdayList();
    FirebaseDatabase.instance
        .reference()
        .child(loginUser.uid.toString())
        .onChildChanged
        .listen((event) {
      print("Data has been changed");
      refreshBirthdayList();
    });
    FirebaseDatabase.instance
        .reference()
        .child(loginUser.uid.toString())
        .onChildRemoved
        .listen((event) {
      print("Data has been removed");
      refreshBirthdayList();
    });
    FirebaseDatabase.instance
        .reference()
        .child(loginUser.uid.toString())
        .onChildAdded
        .listen((event) {
      print("Data has been added");
      refreshBirthdayList();
    });
  }

  Future<void> getCurrentUser() async {
    var user = _auth.currentUser;
    if (user != null) {
      loginUser = user;
      setState(() {});
    }
  }

  void refreshBirthdayList() {
    FirebaseDatabase.instance
        .reference()
        .child(loginUser.uid.toString())
        .once()
        .then((datasnapshot) {
      var birthdayTmpList = [];
      datasnapshot.value.forEach((k, v) {
        birthdayTmpList.add(v);
      });
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
        } else {
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
      setState(() {});
      upcomingBirthdays = upcomingBirthdayTmpList;
      todaysBirthdays = todayBirthdayTmpList;
      upcomingBirthdays.forEach((v) {
        v["imageURL"] = 'assets/upcoming3.png';
      });
    }).catchError((error) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            //if there aren't any birthdays entered, show this dialog box
            return AlertDialog(
              content: Text(
                  "Looks like you don't have any birthdays entered. To get started, click on the add icon on the bottom app bar!"),
              contentTextStyle: TextStyle(
                fontFamily: 'NotoSerif',
                fontSize: 17,
                color: Color(0xff30150d),
                fontWeight: FontWeight.w500,
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Birthdays",
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "today's birthdays",
              style: TextStyle(
                fontFamily: 'NotoSerif',
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
                return Dismissible(
                  key: ObjectKey(names2),
                  direction: DismissDirection.endToStart,
                  child: Container(
                    height: 70,
                    margin:
                        EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                    color: const Color(0xfff8edeb),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xfff8edeb),
                              backgroundImage: AssetImage(
                                '${todaysBirthdays[index]["imageURL"]}',
                              ),
                            ),
                          ),
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: 'NotoSerif',
                            fontSize: 15,
                            color: Color(0xff30150d),
                            fontWeight: FontWeight.w500,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${todaysBirthdays[index]['name']}'
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 17,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${todaysBirthdays[index]['birthday']}'
                                          .toString(),
                                    ),
                                    Text(
                                      ' | Turns ',
                                    ),
                                    Text(
                                      '${todaysBirthdays[index]['age']}'
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          tooltip: 'More info',
                          icon: Icon(Icons.arrow_forward_ios),
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
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to delete $names2?"),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child(loginUser.uid.toString())
                                        .child('person' +
                                            todaysBirthdays[index]["timeStamp"]
                                                .toString())
                                        .remove();
                                    todaysBirthdays.removeAt(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                '$names2 has been removed')));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "upcoming birthdays",
              style: TextStyle(
                fontFamily: 'NotoSerif',
                fontSize: 22,
                color: Color(0xff30150d),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 100,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: upcomingBirthdays.length,
              itemBuilder: (BuildContext context, int index) {
                final names = upcomingBirthdays[index]['name'];
                return Dismissible(
                  key: ObjectKey(names),
                  direction: DismissDirection.endToStart,
                  child: Container(
                    height: 70,
                    margin:
                        EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                    color: const Color(0xfff8edeb),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Container(
                            margin: EdgeInsets.only(right: 5, bottom: 10),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xfff8edeb),
                              backgroundImage: AssetImage(
                                '${upcomingBirthdays[index]['imageURL']}',
                              ),
                            ),
                          ),
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: 'NotoSerif',
                            fontSize: 15,
                            color: Color(0xff30150d),
                            fontWeight: FontWeight.w500,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${upcomingBirthdays[index]['name']}'
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 17,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${upcomingBirthdays[index]['birthday']}'
                                          .toString(),
                                    ),
                                    Text(
                                      ' | Turns ',
                                    ),
                                    Text(
                                      '${upcomingBirthdays[index]['age']}'
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to delete $names?"),
                              actions: [
                                TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child(loginUser.uid.toString())
                                        .child('person' +
                                            upcomingBirthdays[index]
                                                    ["timeStamp"]
                                                .toString())
                                        .remove();
                                    upcomingBirthdays.removeAt(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                '$names has been removed')));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
