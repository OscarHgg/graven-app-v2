import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'screens/auth_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/homepage_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: AuthenticationGate(),
        debugShowCheckedModeBanner: false,
      );
}

class AuthenticationGate extends StatefulWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  State<AuthenticationGate> createState() => _AuthenticationGateState();
}

class _AuthenticationGateState extends State<AuthenticationGate> {
  int index = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (!userSnapshot.hasData) {
            //token found
            return const AuthScreen();
          }

          final List<Widget> screens = [
            const HomePageScreen(),
            const CalendarScreen(),
            const SettingsScreen(),
            const ChatScreen(),
          ];

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: Scaffold(
              body: screens[index],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: CustomColors.primary,
                height: 70,
                index: index,
                items: const [
                  Icon(Icons.home_outlined, size: 30),
                  Icon(Icons.calendar_today_outlined, size: 30),
                  Icon(Icons.settings_outlined, size: 30),
                  Icon(Icons.chat_bubble_outline, size: 30),
                ],
                onTap: (_index) => setState(() => index = _index),
              ),
            ),
          ); // show your app’s home page after login
        },
      );
}
