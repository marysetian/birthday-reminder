import 'dart:math';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cake_time/notification_service.dart';

class AddBirthdayScreen extends StatefulWidget {
  const AddBirthdayScreen({Key? key}) : super(key: key);

  @override
  _AddBirthdayScreenState createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends State<AddBirthdayScreen> {
  late FirebaseAuth _auth = FirebaseAuth.instance;
  late User loginUser;
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var nameController = TextEditingController();
  var selectedDT;
  var selectedRelationship;
  DateTime selectedDate = DateTime.now();
  TimeOfDay _time = TimeOfDay(hour: 12, minute: 0);

  @override
  void initState() {
    super.initState();
    getCurrentUser().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "A D D  B I R T H D A Y",
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Container(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontFamily: 'NotoSerif',
                    fontSize: 17,
                    color: Color(0xff30150d),
                    fontWeight: FontWeight.w500,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Name:",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 55),
                            padding: const EdgeInsets.all(8),
                            width: 360,
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: "Enter name",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Birthday:",
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 55),
                          padding: const EdgeInsets.all(8),
                          width: 360,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                child: GestureDetector(
                                  child: TextFormField(
                                    controller: dateController,
                                    decoration: InputDecoration(
                                      labelText: "Enter Birthday",
                                    ),
                                    onTap: () {
                                      selectDate(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Reminder Time:",
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 360,
                          height: 68,
                          margin: EdgeInsets.only(bottom: 55),
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: timeController,
                            decoration: InputDecoration(
                              labelText: "Enter Reminder Time",
                            ),
                            onTap: () {
                              selectTime();
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Relationship to Person: ",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 360,
                            margin: EdgeInsets.only(bottom: 55),
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: 56,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  hintText: 'Select relationship',
                                ),
                                value: selectedRelationship,
                                items: [
                                  "Family",
                                  "Friend",
                                  "Co-worker",
                                  "Significant Other",
                                  "Other"
                                ]
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label),
                                          value: label,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() => selectedRelationship = value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 45,
                            child: OutlinedButton(
                              child: Text(
                                "Add to Birthdays",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              onPressed: () {
                                var timeStamp =
                                    new DateTime.now().millisecondsSinceEpoch;
                                var selectedDT =
                                    ("${selectedDate.month}/${selectedDate.day}/${selectedDate.year}");
                                var month = selectedDate.month;
                                var day = selectedDate.day;
                                var year = selectedDate.year;
                                DateTime birthday = DateTime(
                                    DateTime.now().year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    _time.hour,
                                    _time.minute);
                                FirebaseDatabase.instance
                                    .reference()
                                    .child(loginUser.uid.toString() +
                                        "/person" +
                                        timeStamp.toString())
                                    .set({
                                  "name": nameController.text,
                                  "month": month,
                                  "day": day,
                                  "year": year,
                                  "birthday": dateController.text,
                                  "timeStamp": timeStamp.toString(),
                                  "time": _time.toString(),
                                  "relationship": selectedRelationship,
                                  "zodiac": calculateZodiac(selectedDT),
                                  "imageURL": 'assets/todays.png',
                                }).then((value) {
                                  print("Successfully added");
                                }).catchError((error) {
                                  print("Failed to add." + error.toString());
                                });
                                var randomizer = new Random();
                                int id;
                                var numID = randomizer.nextInt(10000);
                                id = numID;
                                NotificationService().showScheduleNotification(id, "title", "body", nameController.text, 10, birthday);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2025),
        initialEntryMode: DatePickerEntryMode.calendar,
        builder: (context, picker) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color(0xff30150d),
                onPrimary: Colors.white,
                onSecondary: Color(0xff30150d),
                surface: Color(0xfff8edeb),
                onSurface: Color(0xff30150d),
              ),
              dialogBackgroundColor: Color(0xfff8edeb),
            ),
            child: picker!,
          );
        });
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        dateController.text =
            "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      });
  }

  void selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (context, picker) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color(0xff30150d),
                onPrimary: Colors.white,
                surface: Color(0xfff8edeb),
                onSurface: Color(0xff30150d),
              ),
            ),
            child: picker!,
          );
        });
    if (newTime != null) {
      setState(() {
        _time = newTime;
        timeController.text = '${_time.format(context)}';
      });
    }
  }

  String calculateAge(var selectedDT) {
    int currentYear = DateTime.now().year;
    int nextYear = DateTime.now().year + 1;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    int personYear = selectedDate.year.toInt();
    int personMonth = selectedDate.month.toInt();
    int personDay = selectedDate.day.toInt();
    int turningAge;

    if ((personMonth > currentMonth) ||
        (personMonth == currentMonth && personDay > currentDay)) {
      turningAge = (currentYear - personYear).toInt();
    } else {
      turningAge = (nextYear - personYear).toInt();
    }
    return turningAge.toString();
  }

  String calculateZodiac(var selectedDT) {
    int month = selectedDate.month.toInt();
    int day = selectedDate.day.toInt();
    String zodiac = " ";
    if (month == 3) {
      (day <= 21 && day >= 1) ? zodiac = "Pisces" : zodiac = "Aries";
    }
    if (month == 4) {
      (day <= 19 && day >= 1) ? zodiac = "Aries" : zodiac = "Taurus";
    }
    if (month == 5) {
      (day <= 20 && day >= 1) ? zodiac = "Taurus" : zodiac = "Gemini";
    }
    if (month == 6) {
      (day <= 21 && day >= 1) ? zodiac = "Gemini" : zodiac = "Cancer";
    }
    if (month == 7) {
      (day <= 22 && day >= 1) ? zodiac = "Cancer" : zodiac = "Leo";
    }
    if (month == 8) {
      (day <= 22 && day >= 1) ? zodiac = "Leo" : zodiac = "Virgo";
    }
    if (month == 9) {
      (day <= 22 && day >= 1) ? zodiac = "Virgo" : zodiac = "Libra";
    }
    if (month == 10) {
      (day <= 22 && day >= 1) ? zodiac = "Libra" : zodiac = "Scorpio";
    }
    if (month == 11) {
      (day <= 22 && day >= 1) ? zodiac = "Scorpio" : zodiac = "Sagittarius";
    }
    if (month == 12) {
      (day <= 21 && day >= 1) ? zodiac = "Sagittarius" : zodiac = "Capricorn";
    }
    if (month == 1) {
      (day <= 21 && day >= 1) ? zodiac = "Capricorn" : zodiac = "Aquarius";
    }
    if (month == 2) {
      (day <= 18 && day >= 1) ? zodiac = "Aquarius" : zodiac = "Pisces";
    }
    return zodiac;
  }
}
