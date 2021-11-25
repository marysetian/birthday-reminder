import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreInfoScreen extends StatefulWidget {
  var infoDetails;

  MoreInfoScreen(this.infoDetails);

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  var turningDays;
  var data;
  var gift;
  late FirebaseAuth _auth = FirebaseAuth.instance;
  late User loginUser;
  TextEditingController notesController = new TextEditingController();
  TextEditingController giftController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    var personMonth = widget.infoDetails["month"];
    var currentYear = DateTime.now().year;
    var personDay = widget.infoDetails["day"];
    var birthday = DateTime(currentYear, personMonth, personDay);
    var currentDate = DateTime.now();
    calculateDays(birthday, currentDate);
    getCurrentUser().whenComplete(() {
      setState(() {});
    });
    getNotes();
  }

  Future<void> calculateDays(DateTime from, DateTime to) async {
    var personMonth = widget.infoDetails["month"];
    var personDay = widget.infoDetails["day"];
    var currentMonth = DateTime.now().month;
    var currentDay = DateTime.now().day;

    if ((personMonth > currentMonth) ||
        (currentMonth == personMonth && personDay == currentDay) ||
        (personMonth == currentMonth && personDay > currentDay)) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      turningDays = (from.difference(to).inHours / 24).round();
    } else {
      from = DateTime(from.year + 1, from.month, from.day);
      to = DateTime(to.year + 1, to.month, to.day);
      turningDays = 365 - (to.difference(from).inHours / 24).round();
    }
  }

  Future<void> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      loginUser = user;
    }
  }

  void save() {
    var timeStamp = widget.infoDetails['timeStamp'];
    FirebaseDatabase.instance
        .reference()
        .child(loginUser.uid.toString() + "/person" + timeStamp)
        .update({
      "notes": notesController.text,
      "gift": giftController.text,
    });
  }

  void getNotes() {
    var timeStamp = widget.infoDetails['timeStamp'];
    FirebaseDatabase.instance
        .reference()
        .child(loginUser.uid.toString())
        .once()
        .then((datasnapshot) {
      var tmpList = [];
      datasnapshot.value.forEach((k, v) {
        tmpList.add(v);
      });
      tmpList.forEach((v) {
        if (timeStamp.toString() == v["timeStamp"].toString()) {
          var data = v["notes"];
          var gift = v["gift"];
          notesController.text = data;
          giftController.text = gift;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "M O R E  I N F O",
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      child: ClipOval(
                        child: Container(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage("${widget.infoDetails["imageURL"]}"),
                            backgroundColor: Color(0xfff8edeb),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${widget.infoDetails['name']}",
                        style: TextStyle(
                          fontFamily: 'NotoSerif',
                          fontSize: 28,
                          color: Color(0xff30150d),
                          fontWeight: FontWeight.w500,
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
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.infoDetails['relationship']}",
                            ),
                            Text(
                              " | ",
                            ),
                            Text(
                              "${widget.infoDetails['zodiac']}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "${widget.infoDetails['birthday']}",
                        style: TextStyle(
                          fontFamily: 'NotoSerif',
                          fontSize: 15,
                          color: Color(0xff30150d),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: 'NotoSerif',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff30150d),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Turns ",
                            ),
                            Text(
                              "${widget.infoDetails['age']}",
                            ),
                            Text(
                              " in",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8, top: 5),
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                        child: Text(
                          turningDays.toString() + " days",
                          style: TextStyle(
                            fontFamily: 'NotoSerif',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40, right: 310),
                      child: Text(
                        "Notes: ",
                        style: TextStyle(
                          fontFamily: 'NotoSerif',
                          fontSize: 18,
                          color: Color(0xff30150d),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        child: TextFormField(
                          controller: notesController,
                          initialValue: data,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText:
                                ("e.g.Celebration ideas, gift ideas, etc"),
                          ),
                          onChanged: (notesController) {
                            save();
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 240),
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          "Last year's gift: ",
                          style: TextStyle(
                            fontFamily: 'NotoSerif',
                            fontSize: 18,
                            color: Color(0xff30150d),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        child: TextFormField(
                          controller: giftController,
                          initialValue: gift,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: ("What gift did you get them last year?"),
                          ),
                          onChanged: (giftController) {
                            save();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
