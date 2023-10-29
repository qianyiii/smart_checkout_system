import 'package:flutter/material.dart';
import 'package:smart_checkout_system/welcome.dart';
import 'package:smart_checkout_system/login.dart';
import 'package:smart_checkout_system/registration.dart';
import 'package:smart_checkout_system/UserScreens/home.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
          )
      ),
      // This defines the route it should start with
      initialRoute: Welcome.id,
      //This defines the available named routes and the widgets to build when navigating to those routes
      routes: {
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        Registration.id: (context) => Registration(),
        Home.id: (context) => Home(),
      },
    );
  }
}
