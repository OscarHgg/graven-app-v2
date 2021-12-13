import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:gravenv2_app/screens/calendar_screen.dart';
import 'package:gravenv2_app/theme/colors.dart';
import 'firebase_options.dart';
import 'screens/chat_screen.dart';
import 'screens/homepage_screen.dart';
import 'screens/settings_screen.dart';

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

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is not signed in - show a sign-in screen
          if (!snapshot.hasData) {
            return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId: 'xxxx-xxxx.apps.googleusercontent.com',
                ),
              ],
            );
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
              appBar: AppBar(
                title: const Text('Graven'),
                backgroundColor: CustomColors.secondary,
              ),
              body: screens[index],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: CustomColors.primary,
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
