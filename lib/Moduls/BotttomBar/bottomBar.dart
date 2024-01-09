import 'package:flutter/material.dart';
import '../Another_Screen/anotherScreen.dart';
import '../Goal_Screen/goal_screen.dart';
import '../Home_Screen/homeScreen.dart';
import '../Setting_Screen/settingScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  var currentIndex = 0;
  var bodyList = [
    HomeScreen(),
    GoalScreen(),
    AnotherScreen(),
    SettingScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Column(
        children: [
          Expanded(
            child: bodyList.elementAt(currentIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        // backgroundColor: Colors.blue.shade300,
        iconSize: 35,
        selectedItemColor: Colors.indigo.shade900,
        unselectedItemColor: Colors.black26,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.recycling,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}