import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gravenv2_app/theme/colors.dart';
import 'package:gravenv2_app/widgets/graven_calendar.dart';

import 'calendar_screen.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  final List<Widget> screens = [
    const HomePageScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navigationKey,
      appBar: AppBar(
        title: const Text('Graven'),
        backgroundColor: CustomColors.secondary,
      ),
      body: GravenCalendar(),
      // Column(
      //   children: const [
      //     Expanded(
      //       child: GravenCalendar(),
      //     ),
      //   ],
      // ),
    );
  }
}
