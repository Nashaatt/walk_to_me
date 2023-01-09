import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home_scr.dart';
import 'login_scr.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot) {
          // user logged in
          if(snapshot.hasData) {
            return HomePage();
          }
          // user not logged in
           else {
            return LoginPage();
          }
        },
      ),
    );
  }
}