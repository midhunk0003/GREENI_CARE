
import 'package:flutter/material.dart';

class ViewRoom extends StatefulWidget {
  const ViewRoom({ Key? key }) : super(key: key);

  @override
  _ViewRoomState createState() => _ViewRoomState();
}

class _ViewRoomState extends State<ViewRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('view plant'),
      ),
    );
  }
}