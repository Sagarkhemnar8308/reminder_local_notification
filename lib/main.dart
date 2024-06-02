import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reminder/auth/signin.dart';
import 'package:reminder/firebase_options.dart';
import 'package:reminder/services/notification_logic.dart';
import 'homescreen.dart';

  User? user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   user = FirebaseAuth.instance.currentUser;
    NotificationLogic.init(user?.uid ?? "",
    );
    localNotifications();
  runApp(MyApp());
}

  void localNotifications() {
    NotificationLogic.onNotification.listen((value) {});
  }
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
MyApp({super.key});

  final FirebaseAuth _user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _user.currentUser != null
          ? const HomeScreen()
          : const SignUpScreen(),
    );
  }
}
