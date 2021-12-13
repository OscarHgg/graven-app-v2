import 'package:flutter/material.dart';
import 'package:gravenv2_app/widgets/graven_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: GravenCalendar(),
      );
}
