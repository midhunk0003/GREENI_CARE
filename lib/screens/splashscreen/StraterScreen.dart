import 'package:flutter/material.dart';
import 'package:greeni_care/MODEL/StarterModel.dart';
import 'package:greeni_care/database/Starter_function.dart';
import 'package:greeni_care/routes/routs_manager.dart';

final String STARTER_KEY = 'starterkey';

class StraterScreen extends StatefulWidget {
  const StraterScreen({Key? key}) : super(key: key);

  @override
  _StraterScreenState createState() => _StraterScreenState();
}

class _StraterScreenState extends State<StraterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                // color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 130),
                child: const Center(
                  child: Text(
                    'Make Your life \n      greener',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 114, 122, 67),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 388,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: Image.asset('asset/images/starterimage.png'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  addStarterornot();
                });
              },
              child: Container(
                width: 259.47,
                height: 71,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 114, 122, 67),
                ),
                child: const Center(
                  child: Text(
                    'Get startd!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            const Expanded(child: Text('MADE by MIDHUN K'))
          ],
        ),
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

  Future<void> addStarterornot() async {
    if (STARTER_KEY.isEmpty) {
      print('some thing went wrong');
    } else {
      final _startervalue = StarterModel(starterClick: STARTER_KEY);
      addNameStarter(_startervalue);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) {
            return RoutsManager();
          },
        ),
      );
    }
  }
}
