import 'package:flutter/material.dart';

class AppProgressIndecator extends StatefulWidget {
  const AppProgressIndecator({Key? key}) : super(key: key);

  @override
  _AppProgressIndecatorState createState() => _AppProgressIndecatorState();
}

class _AppProgressIndecatorState extends State<AppProgressIndecator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //set width of the progress indicator
        width: MediaQuery.of(context).size.width / 2,
        height: 10,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                minHeight: 8,
                color: Color.fromARGB(255, 12, 74, 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
