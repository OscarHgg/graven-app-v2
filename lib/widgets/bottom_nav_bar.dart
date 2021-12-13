import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gravenv2_app/theme/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: CustomColors.secondary,
      color: CustomColors.primary,
      items: const [
        Icon(Icons.home_outlined, size: 30),
        Icon(Icons.calendar_today_outlined, size: 30),
        Icon(Icons.settings_outlined, size: 30),
        Icon(Icons.chat_bubble_outline, size: 30),
      ],
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }
}
