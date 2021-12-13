import 'user.dart';

class Event {
  String title;
  String? description;
  DateTime date;
  List<User> participants;

  Event({
    required this.title,
    this.description,
    required this.date,
    required this.participants,
  });
}
