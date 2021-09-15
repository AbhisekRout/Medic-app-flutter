import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medic_app/Authentication/Login.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "The Medic",
      theme: ThemeData(
        primaryColor: Colors.lightBlue
      ),
      home: Initial(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Initial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}






