import 'package:flutter/material.dart';

class MoreInfoScreen extends StatefulWidget {
  var infoDetails;

  MoreInfoScreen(this.infoDetails);

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
     body: Column (
       children: [
         Text("${widget.infoDetails}['name']}"),
         Text("${widget.infoDetails}['birthday']}"),
         Text("${widget.infoDetails}['imageUrl']}"),
         Text("${widget.infoDetails}['age']}"),
       ],
     ),
    );
  }
}
