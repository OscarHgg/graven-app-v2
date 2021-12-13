import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final firestoreInstance = FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true);

    return FutureBuilder(
        future: Future.value(auth.currentUser!),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<QuerySnapshot>(
              stream: firestoreInstance.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return StreamBuilder<QuerySnapshot>(
                    stream: firestoreInstance.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final document = snapshot.data?.docs;
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => MessageBubble(
                          document?[index]['text'],
                          document?[index]['username'],
                          document?[index]['userImage'],
                          document?[index]['userId'] == auth.currentUser!.uid,
                          key: ValueKey(document?[index].id),
                        ),
                      );
                    },
                  );
                }
              });
        });
  }
}
