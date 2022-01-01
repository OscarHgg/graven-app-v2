import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gravenv2_app/theme/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 100),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                //sign out firebase
                signOut();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                    child: Text(
                  'Logga ut',
                )),
              ),
            ),
          ],
        ),
      ));
}
