import 'package:cake_time/add_birthday_screen.dart';
import 'package:cake_time/more_info_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: MyHomePage(
          title: 'Birthdays'
      ),


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
  var birthdayList = [
    {
      'name': "Sarah Smith",
      'birthday': "09/14 | ",
      'imageUrl': ("https://www.seekpng.com/png/detail/72-729869_circled-user-female-skin-type-4-icon-profile.png"),
      'age': ("Turns 35")
    },
    {
      'name': "Sarah Smith",
      'birthday': "09/14 | ",
      'imageUrl': ("https://www.seekpng.com/png/detail/72-729869_circled-user-female-skin-type-4-icon-profile.png"),
      'age': ("Turns 35")
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
        body:Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Today's Birthdays",
              style: TextStyle (
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
          ),
          Expanded (
            child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: birthdayList.length,
            itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 70,
                margin: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right:15),
                      child: Container(
                        margin:EdgeInsets.only(left:10),
                        child: CircleAvatar (
                          backgroundImage: NetworkImage(
                            '${birthdayList[index]['imageUrl']}',
                          ),
                        ),
                      ),
                    ),
                    Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text (
                          '${birthdayList[index]['name']}',
                        ),
                        Row (
                          children: [
                            Text (
                              '${birthdayList[index]['birthday']}',
                            ),
                            Text (
                              '${birthdayList[index]['age']}',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton (
                        tooltip: 'Open navigation menu',
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
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
              style: TextStyle (
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),

            ),
          ),
          Expanded (
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: birthdayList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 70,
                  margin: EdgeInsets.only(right: 10, left: 10 ,top: 5, bottom: 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right:15),
                        child: Container(
                          margin: EdgeInsets.only(left:10),
                          child: CircleAvatar (
                            backgroundImage: NetworkImage(
                              '${birthdayList[index]['imageUrl']}',
                            ),
                          ),
                        ),
                      ),
                      Column (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text (
                            '${birthdayList[index]['name']}',
                          ),
                          Row (
                            children: [
                              Text (
                                '${birthdayList[index]['birthday']}',
                              ),
                              Text (
                                '${birthdayList[index]['age']}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),

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
                    MaterialPageRoute(builder: (context) => AddBirthdayScreen()),
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
