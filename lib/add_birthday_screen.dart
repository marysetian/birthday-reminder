import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:cake_time/notification_service.dart';

class AddBirthdayScreen extends StatefulWidget {
  const AddBirthdayScreen({Key? key}) : super(key: key);

  @override
  _AddBirthdayScreenState createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends State<AddBirthdayScreen> {
  late FirebaseAuth _auth = FirebaseAuth.instance;
  late User loginUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser().whenComplete(() {
      setState(() {

      });
    });
    blah();
  }
  Future<void> getCurrentUser() async {
    final user = _auth.currentUser;
    if(user != null) {
      loginUser = user;
      print("Current user UID is:" + loginUser.uid.toString());
    }
  }
  void blah() {
      FirebaseDatabase.instance
          .reference()
          .child(loginUser.uid.toString())
          .once()
          .then((datasnapshot) {
        print("Succesully loaded the data");
        print(datasnapshot);
        //path becomes the key
        print(datasnapshot.key);
        print(datasnapshot.value);
        //save everything into a list
        var uidList = [];
        //iterate through the hashmap
        datasnapshot.value.forEach((k, v) {
          print(k);
          print(v);
          uidList.add(v["uid"]);
        });
        print("Final uid list: ");
        print(uidList);
      });
  }
  var _controller = TextEditingController();
  var timeController = TextEditingController();
  var giftController = TextEditingController();
  var nameController = TextEditingController();
  var dateValue = TextEditingController();
  var selectedDT;

  DateTime selectedDate = DateTime.now();
  TimeOfDay _time = TimeOfDay(hour: 12, minute: 0);
  String? dropdownValue = "Select relationship";

  var relationshipTypes = [
    "Select relationship",
    "Family",
    "Friend",
    "Co-worker",
    "Significant other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8edeb),
      appBar: AppBar(
        title: Text(
          "A D D   B I R T H D A Y",
          style: GoogleFonts.getFont(
            'Noto Serif',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xffe8a598),
        centerTitle: true,
        //automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  "Name:",
                  style: GoogleFonts.getFont(
                    'Noto Serif',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff30150d),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    padding: const EdgeInsets.all(8),
                    width: 400,
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(color: Colors.black45),
                          labelText: "Enter name",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Birthday:",
                  style: GoogleFonts.getFont(
                    'Noto Serif',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff30150d),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.all(8),
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        child: GestureDetector(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintStyle: TextStyle(color: Colors.black45),
                              suffixIcon: Icon(Icons.calendar_today_outlined),
                              labelText: "Enter Birthday",
                            ),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Reminder Time:",
                  style: GoogleFonts.getFont(
                    'Noto Serif',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff30150d),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 68,
                  margin: EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle: TextStyle(color: Colors.black45),
                      suffixIcon: Icon(Icons.access_time_rounded),
                      labelText: "Enter Reminder Time",
                    ),
                    onTap: () {
                      _selectTime();
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Relationship to Person ",
                  style: GoogleFonts.getFont(
                    'Noto Serif',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff30150d),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    margin: EdgeInsets.only(bottom: 30),
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 56,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items:
                            relationshipTypes.map((String relationshipTypes) {
                          return DropdownMenuItem(
                            value: relationshipTypes,
                            child: Text(relationshipTypes),
                          );
                        }).toList(),
                        onChanged: (String? newRelationship) {
                          setState(() {
                            dropdownValue = newRelationship;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "What gift did you get them last year",
                  style: GoogleFonts.getFont(
                    'Noto Serif',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff30150d),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 32),
                    padding: const EdgeInsets.all(8),
                    width: 400,
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: giftController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintStyle: TextStyle(color: Colors.black45),
                          labelText: "Enter gift",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(
                          width: 3.0,
                          color: Color(0xff30150d),
                        ),
                      ),
                      child: Text(
                        "Add to List",
                        style: GoogleFonts.getFont(
                          'Noto Serif',
                          fontSize: 15,
                          color: Color(0xff30150d),
                          fontWeight: FontWeight.w700,
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
                        DateTime birthday = DateTime(DateTime.now().year, selectedDate.month, selectedDate.day, _time.hour, _time.minute);
                        FirebaseDatabase.instance.reference().child(loginUser.uid.toString() + "/person" + timeStamp.toString()).set({
                          "name": nameController.text,
                          "month": month,
                          "day": day,
                          "year": year,
                          //stores birthday as month/day/year for appearance sake
                          "birthday": _controller.text,

                          //stores birthday as milliseconds for calculations sake
                          "timeStamp": timeStamp.toString(),
                          "time": _time.toString(),
                          "relationship": dropdownValue,
                          "zodiac": calculateZodiac(selectedDT),
                          "gift": giftController.text,
                          "imageURL": 'assets/moreinfo.png',
                        }).then((value) {
                          print("Successfully added");
                        }).catchError((error) {
                          print("Failed to add." + error.toString());
                        });
                       // var randomizer = new Random();
                       // int id;
                       // var numID = randomizer.nextInt(10000);
                       // id = numID;
                        //NotificationService().showScheduleNotification(id,
                         //   "title", "body", nameController.text, 10, birthday, loginUser);


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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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
        _controller.text =
            "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
      });
  }

  void _selectTime() async {
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
              //dialogBackgroundColor:Color(0xff30150d),
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

    // if person's birthday month is greater than the current month, use current year to calculate their turning age
    if (personMonth > currentMonth) {
      turningAge = (currentYear - personYear).toInt();
    } else if (personMonth == currentMonth && personDay > currentDay) {
      turningAge = (currentYear - personYear).toInt();
    } else if (personMonth == currentMonth && personDay < currentDay) {
      turningAge = (nextYear - personYear).toInt();
    }
    // otherwise, use the next year to calculate their turning age
    else {
      turningAge = (nextYear - personYear).toInt();
    }
    return turningAge.toString();
  }

  String calculateZodiac(var selectedDT) {
    int month = selectedDate.month.toInt();
    String zodiac = " ";
    int day = selectedDate.day.toInt();
    if (month == 3) {
      if (day >= 21 && day <= 31) {
        zodiac = "Aries";
      } else {
        zodiac = "Pisces";
      }
    }
    if (month == 4) {
      if (day <= 19 && day >= 1) {
        return "Aries";
      } else {
        return "Taurus";
      }
    }
    if (month == 5) {
      if (day <= 20 && day >= 1) {
        return "Taurus";
      } else {
        return "Gemini";
      }
    }
    if (month == 6) {
      if (day <= 20 && day >= 1) {
        return "Gemini";
      } else {
        return "Cancer";
      }
    }
    if (month == 7) {
      if (day <= 22 && day >= 1) {
        return "Cancer";
      } else {
        return "Leo";
      }
    }
    if (month == 8) {
      if (day <= 22 && day >= 1) {
        return "Leo";
      } else {
        return "Virgo";
      }
    }
    if (month == 9) {
      if (day <= 22 && day >= 2) {
        return "Virgo";
      } else {
        return "Libra";
      }
    }
    if (month == 10) {
      if (day <= 22 && day >= 1) {
        return "Libra";
      } else {
        return "Scorpio";
      }
    }
    if (month == 11) {
      if (day <= 21 && day >= 1) {
        return "Scorpio";
      } else {
        return "Sagittarius";
      }
    }
    if (month == 12) {
      if (day <= 21 && day >= 1) {
        return "Sagittarius";
      } else {
        return "Capricorn";
      }
    }
    if (month == 1) {
      if (day <= 20 && day >= 1) {
        return "Capricorn";
      } else {
        return "Aquarius";
      }
    }
    if (month == 2) {
      if (day <= 18 && day >= 1) {
        return "Aquarius";
      } else {
        return "Pisces";
      }
    }
    return zodiac;
  }
}

