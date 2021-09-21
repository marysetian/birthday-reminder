import 'package:cake_time/edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MoreInfoScreen extends StatefulWidget {
  var infoDetails;

  MoreInfoScreen(this.infoDetails);

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.create_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditScreen()),
              );
            },
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      NetworkImage("${widget.infoDetails['imageUrl']}"),
                ),
              ),
              Text(
                "${widget.infoDetails['name']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Row(
                children: [
                  Text("${widget.infoDetails['relationship']}"),
                  Text(
                    " | ",
                  ),
                  Text("Sagittarius"),
                ],
              ),
              Text("${widget.infoDetails['birthdate']}"),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Text(
                      "${widget.infoDetails['age']}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      " in",
                      style: TextStyle(
                        fontSize: 18,
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
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Text(
                    "83 days",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 30, right: 290),
                      child: Text("Notes: ",)
                  ),
                ],
              ),
              Container(

                width: 350,
                height: 125,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ("e.g.Celebration ideas, gift ideas, etc"),
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 235),
                    child: Text("Gifted last year: ",)
                ),
              ],
              ),
              Expanded(
                child: Container(
                  //margin:EdgeInsets.only(top:3),
                  width: 350,
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
