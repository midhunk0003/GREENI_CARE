import 'package:flutter/material.dart';
import 'package:greeni_care/routes/routs_manager.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({Key? key}) : super(key: key);

  @override
  _BottomnavigationbarState createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: RoutsManager.selectedIndexNotifier,
      builder: (BuildContext ctx, dynamic updateIndex, Widget? _) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 30, offset: Offset(0, 20))
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(38),
            child: BottomNavigationBar(
              currentIndex: updateIndex,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black,
              onTap: (newIndex) {
                RoutsManager.selectedIndexNotifier.value = newIndex;
              },
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset('asset/images/Home.png'), label: 'home'),
                BottomNavigationBarItem(
                  icon: Image.asset('asset/images/Plus_Math.png'),
                  label: 'ADD plant',
                ),
                BottomNavigationBarItem(
                    icon: Image.asset('asset/images/Today.png'),
                    label: 'reminder'),
              ],
            ),
          ),
        );
      },
    );
  }
}
