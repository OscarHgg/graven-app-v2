import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Event {
  final String title;
  final String? description;
  final DateTime date;
  final List<User> participants;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.participants,
  });

  Event.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'],
        description = snapshot['description'],
        date = snapshot['date'],
        participants = snapshot['participants'];
}
