import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gravenv2_app/theme/colors.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.primary),
                child: Center(
                  child: Text('Upcoming Events'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        color: CustomColors.primary),
                    child: const Center(
                      child: Text('something else'),
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors.primary),
                  child: const Center(
                    child: Text('something else'),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
