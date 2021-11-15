import 'package:cake_time/birthdays_fb_screen.dart';
import 'package:cake_time/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreInfoScreen extends StatefulWidget {
  var infoDetails;

  MoreInfoScreen(this.infoDetails);

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  var turningDays;
  TextEditingController notesController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    var personMonth = widget.infoDetails["month"];
    var currentYear = DateTime.now().year;
    var personDay = widget.infoDetails["day"];
    var birthday = DateTime(currentYear, personMonth, personDay);
    var date2 = DateTime.now();
    calculateDays(birthday, date2);
  }

  Future<int> calculateDays(DateTime from, DateTime to) async {
    var personMonth = widget.infoDetails["month"];
    var currentMonth = DateTime.now().month;
    var personDay = widget.infoDetails["day"];
    var currentDay = DateTime.now().day;
    if ((personMonth > currentMonth) || (currentMonth == personMonth && personDay == currentDay) || (personMonth == currentMonth && personDay > currentDay)) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      turningDays = (from.difference(to).inHours / 24).round();
      return (from.difference(to).inHours / 24).round();
    } else {
      from = DateTime(from.year + 1, from.month, from.day);
      to = DateTime(to.year + 1, to.month, to.day);
      turningDays = 365 - (to.difference(from).inHours / 24).round();
      return 365 - (to.difference(from).inHours / 24).round();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff8edeb),
      appBar: AppBar(
        title: Text(
          "M O R E  I N F O",
          style: GoogleFonts.getFont(
            'Noto Serif',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: BackButton (
          onPressed: () {
            Navigator.of(context).pop(notesController.text);
          },

        ),
        centerTitle: true,

        backgroundColor: Color(0xffe8a598),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ClipOval(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: CircleAvatar(
                          radius: 58,
                          backgroundImage:
                              AssetImage("${widget.infoDetails["imageURL"]}"),
                          backgroundColor: Color(0xfff8edeb),
                        ),
                      ),
                    ),
                    Text(
                      "${widget.infoDetails['name']}",
                      style: GoogleFonts.getFont(
                        'Noto Serif',
                        fontSize: 24,
                        color: Color(0xff30150d),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          Text(
                            "${widget.infoDetails['relationship']}",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 13,
                              color: Color(0xff30150d),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " | ",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 13,
                              color: Color(0xff30150d),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${widget.infoDetails['zodiac']}",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 13,
                              color: Color(0xff30150d),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        "${widget.infoDetails['birthday']}",
                        style: GoogleFonts.getFont(
                          'Noto Serif',
                          fontSize: 15,
                          color: Color(0xff30150d),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Text(
                            "Turns ",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${widget.infoDetails['age']}",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            " in",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          turningDays.toString() + " days",
                          style: GoogleFonts.getFont(
                            'Noto Serif',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40, right: 300),
                          child: Text(
                            "Notes: ",
                            style: GoogleFonts.getFont(
                              'Noto Serif',
                              fontSize: 18,
                              color: Color(0xff30150d),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 370,
                      height: 125,
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        child: TextFormField(
                          controller: notesController,
                          maxLines: 20,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                ("e.g.Celebration ideas, gift ideas, etc"),
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ),
                      ),

                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 30, right: 150),
                            child: Row(
                              children: [
                                Text(
                                  "Gifted last year: ",
                                  style: GoogleFonts.getFont(
                                    'Noto Serif',
                                    fontSize: 18,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${widget.infoDetails['gift']}",
                                  style: GoogleFonts.getFont(
                                    'Noto Serif',
                                    fontSize: 15,
                                    color: Color(0xff30150d),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )),
                      ],
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
