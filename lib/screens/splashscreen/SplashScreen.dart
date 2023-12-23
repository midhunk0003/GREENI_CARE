import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/StarterModel.dart';
import 'package:greeni_care/SCREENS/splashscreen/StraterScreen.dart';
import 'package:greeni_care/WIDGETS/AppProgressIndecator.dart';
import 'package:greeni_care/routes/routs_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

final userEnterName = 'midhun';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    userEnterNameorNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                // color: Colors.amber,
                margin: EdgeInsets.only(top: 200),
                height: 244,
                width: 231,
                child: Image.asset('asset/images/logosplash.png'),
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.black,
                // margin: EdgeInsets.only(top: 200),
                child: AppProgressIndecator(),
              ),
            ),
            Text(
              'MADE by MIDHUN K',
              style: TextStyle(color: Colors.green[700]),
            )
          ],
        ),
      ),
    );
  }

  Future<void> gotoHomeStarterScreen(context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => StraterScreen(),
      ),
    );
  }

  Future<void> gotoHomeScreenOne(context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => RoutsManager(),
      ),
    );
  }

  Future<void> userEnterNameorNot() async {
    final starterDB = await Hive.openBox<StarterModel>('starter_db');
    if (starterDB.isEmpty) {
      gotoHomeStarterScreen(context);
      print(starterDB.values);
    } else {
      gotoHomeScreenOne(context);
      print(123);
    }
  }
}
