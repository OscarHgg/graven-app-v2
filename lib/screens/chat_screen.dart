import 'package:flutter/material.dart';
import 'package:gravenv2_app/widgets/chat/messages.dart';
import 'package:gravenv2_app/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Column(
        children: const [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ));
}
