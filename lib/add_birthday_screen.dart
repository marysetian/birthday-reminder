import'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_field/date_field.dart';

import 'dart:async';


class AddBirthdayScreen extends StatefulWidget {
  const AddBirthdayScreen({Key? key}) : super(key: key);

  @override
  _AddBirthdayScreenState createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends State<AddBirthdayScreen> {

  @override
  Widget build(BuildContext context) {
    final firstDate = DateTime(DateTime.now().year - 120);
    final lastDate = DateTime.now();
    return Scaffold(
      appBar: AppBar (
        title: Text("Add a Birthday"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Name:",
              ),
            ),
          Expanded(
            flex: 20,
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter name",
                ),
              ),
            ),
          ),
          Text(
            "Birthday:",
          ),
          Expanded(
            flex:20,
            child: Container(
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: "Enter birthday"
                ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
            ),
          ),
          Text (
            "Reminder Time",
          ),
          Container(
            child: Expanded(
              flex: 20,
              child: Container(
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: "Enter birthday"
                  ),
                  mode: DateTimeFieldPickerMode.time,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    print(value);
                  },
                ),
              ),
            ),
          ),
        ],
    ),
    );
  }
}
