import 'package:flutter/material.dart';
import 'package:gravenv2_app/models/event.dart';
import 'package:gravenv2_app/models/user.dart';
import 'package:gravenv2_app/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class GravenCalendar extends StatefulWidget {
  const GravenCalendar({
    Key? key,
  }) : super(key: key);

  @override
  _GravenCalendarState createState() => _GravenCalendarState();
}

class _GravenCalendarState extends State<GravenCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late final List<Event> _allEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _allEvents = [
      Event(
        date: DateTime(2021, 12, 24),
        title: 'Städdag',
        description: 'Description 1',
        participants: [
          User(
            firstName: 'Janne',
            lastName: 'Eriksson',
          ),
          User(
            firstName: 'Kalle',
            lastName: 'Kula',
          ),
          User(
            firstName: 'Mikael',
            lastName: 'Mikaelsson',
          ),
        ],
      ),
      Event(
        date: DateTime(2021, 12, 24),
        title: 'Event 2',
        description: 'Description 2',
        participants: [
          User(
            firstName: 'Janne',
            lastName: 'Eriksson',
          ),
          User(
            firstName: 'Kalle',
            lastName: 'Kula',
          ),
          User(
            firstName: 'Mikael',
            lastName: 'Mikaelsson',
          ),
        ],
      ),
      Event(
        date: DateTime(2020, 6, 3),
        title: 'Event 3',
        description: 'Description 3',
        participants: [
          User(
            firstName: 'Janne',
            lastName: 'Eriksson',
          ),
          User(
            firstName: 'Kalle',
            lastName: 'Kula',
          ),
          User(
            firstName: 'Mikael',
            lastName: 'Mikaelsson',
          ),
        ],
      ),
      Event(
        date: DateTime(2021, 12, 24),
        title: 'Event 4',
        description: 'Description 4',
        participants: [
          User(
            firstName: 'Janne',
            lastName: 'Eriksson',
          ),
          User(
            firstName: 'Kalle',
            lastName: 'Kula',
          ),
          User(
            firstName: 'Mikael',
            lastName: 'Mikaelsson',
          ),
        ],
      )
    ];

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _allEvents.where((event) => event.date.day == day.day).toList();
  }

  List<Event> _getUpcomingEvents(DateTime day) {
    return _allEvents
        .where((event) =>
            event.date.isAfter(day) &&
            event.date.isBefore(day.add(const Duration(days: 7))))
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Material Dialog'),
            content: Text('Hey! I am Coflutter!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close')),
              TextButton(
                onPressed: () {
                  print('HelloWorld!');
                  _dismissDialog();
                },
                child: Text('HelloWorld!'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              _showMaterialDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Event'),
            style: ElevatedButton.styleFrom(
              primary: CustomColors.primary,
            ),
          ),
        ),
        TableCalendar<Event>(
          firstDay: DateTime.utc(2021, 12, 01),
          lastDay: DateTime.utc(2024, 12, 31),
          focusedDay: _focusedDay,
          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: CustomColors.primary,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: CustomColors.primaryVariant,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(day, _selectedDay);
          },
          onDaySelected: _onDaySelected,
          onPageChanged: (DateTime focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, events, child) {
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 12,
                    ),
                    child: InkWell(
                      onTap: () {
                        print('Tapped on ${event.title}');
                      },
                      child: ListTile(
                        title: Text(event.title),
                        subtitle: Text(event.date.toString()),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
