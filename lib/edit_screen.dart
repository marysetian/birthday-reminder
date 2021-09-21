import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_field/date_field.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String? dropdownValue = "Select relationship";
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
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
      appBar: AppBar(
        title: Text("Edit"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 15),
                child: Text("Upload Photo (Optional)"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: IconButton(
                  iconSize: 60,
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    //do something
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "Name:",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 35),
                padding: const EdgeInsets.all(8),
                width: 380,
                child: Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
              "Birthday and Time:",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(height: 20.0,),
              Container(
                width: 380,
                margin:EdgeInsets.only(bottom:35),
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 56,
                  child: DateTimeFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                      hintStyle: TextStyle(color: Colors.black45),
                      labelText: "Select birthday and reminder time",

                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text("Relationship to Person (Optional) "),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 365,
                margin:EdgeInsets.only(bottom: 35),
                child: Container(
                  height: 56,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                    ),

                    items: relationshipTypes.map((String relationshipTypes) {
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
            child: Text("What gift did you get them last year (Optional)"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 380,
                margin: EdgeInsets.only(bottom: 35),
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.black45),
                      labelText: "Enter name",

                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


