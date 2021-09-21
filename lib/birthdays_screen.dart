import 'package:flutter/material.dart';
import 'package:cake_time/add_birthday_screen.dart';
import 'package:cake_time/more_info_screen.dart';

class BirthdaysScreen extends StatefulWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  _BirthdaysScreenState createState() => _BirthdaysScreenState();
}

class _BirthdaysScreenState extends State<BirthdaysScreen> {
  var todaysBirthdays = [
    {
      'name': "Sarah Smith",
      'birthday': "09/21 | ",
      'birthdate':"September 21, 1986",
      'relationship': "Co-Worker",
      'imageUrl':
      ("https://www.seekpng.com/png/detail/72-729869_circled-user-female-skin-type-4-icon-profile.png"),
      'age': ("Turns 35")
    },
    {
      'name': "Mary Setian",
      'birthday': "10/21 | ",
      'birthdate': "October 21, 2001",
      'relationship': "Family",
      'imageUrl':
      ("https://www.seekpng.com/png/detail/72-729869_circled-user-female-skin-type-4-icon-profile.png"),
      'age': ("Turns 20")
    },
  ];

  var upcomingBirthdays = [
    {
      'name': "John",
      'birthday': "11/21 | ",
      'birthdate': "Novemeber 21, 2001",
      'relationship': "Friend",
      'imageUrl':
      ("https://png.pngitem.com/pimgs/s/22-220721_circled-user-male-type-user-colorful-icon-png.png"),
      'age': ("Turns 21")
    },
    {
      'name': "Ashley Turner",
      'birthday': "12/13 | ",
      'birthdate': "December 13, 2002",
      'relationship': "Co-Worker",
      'imageUrl':
      ("https://www.seekpng.com/png/detail/72-729869_circled-user-female-skin-type-4-icon-profile.png"),
      'age': ("Turns 19")
    },
    {
      'name': "George Sky",
      'birthday': "10/31 ",
      'birthdate': "October 31, 1965",
      'relationship': "Family",
      'imageUrl':
      ("https://png.pngitem.com/pimgs/s/22-220721_circled-user-male-type-user-colorful-icon-png.png"),
      'age': ("Turns 56")
    },
    {
      'name': "Thomas",
      'birthday': "09/19 | ",
      'birthdate': "September 19, 1978",
      'relationship': "Family",
      'imageUrl':
      ("https://png.pngitem.com/pimgs/s/22-220721_circled-user-male-type-user-colorful-icon-png.png"),
      'age': ("Turns 43")
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Birthdays"),
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Today's Birthdays",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 35,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todaysBirthdays.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 70,
                  margin:
                  EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${todaysBirthdays[index]['imageUrl']}',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${todaysBirthdays[index]['name']}',
                          ),
                          Row(
                            children: [
                              Text(
                                '${todaysBirthdays[index]['birthday']}',
                              ),
                              Text(
                                '${todaysBirthdays[index]['age']}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        tooltip: 'Open navigation menu',
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MoreInfoScreen(todaysBirthdays[index])),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Upcoming Birthdays",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 55,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: upcomingBirthdays.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 70,
                  margin:
                  EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${upcomingBirthdays[index]['imageUrl']}',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${upcomingBirthdays[index]['name']}',
                          ),
                          Row(
                            children: [
                              Text(
                                '${upcomingBirthdays[index]['birthday']}',
                              ),
                              Text(
                                '${upcomingBirthdays[index]['age']}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        tooltip: 'Open navigation menu',
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MoreInfoScreen(upcomingBirthdays[index])),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              flex: 50,
              child: IconButton(
                tooltip: 'Open navigation menu',
                icon: Icon(Icons.cake),
                onPressed: () {},
              ),
            ),
            Spacer(),
            Expanded(
              flex: 50,
              child: IconButton(
                tooltip: "Add a Birthday",
                icon: const Icon(Icons.add_circle_outline_rounded),
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
    );
  }
}
