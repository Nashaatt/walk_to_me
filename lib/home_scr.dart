import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  // sign out Method
  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: signOut,
              icon: Icon(
                Icons.logout_outlined,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_tFAVx9hk3S.json',
                   height: 300,
              ),
            ),
          ],
        )
      ),
    );
  }
}
